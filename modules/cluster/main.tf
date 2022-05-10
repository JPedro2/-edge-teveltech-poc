locals {
  dns_policy = {
    dev  = "arn:aws:iam::649513742363:policy/ExternalDNS@pds-dev.io",
    prod = "arn:aws:iam::122887745879:policy/ExternalDNS@pds-eap.io",
  }
  hosted_zone = {
    dev  = "Z05842373JU7NUIZQHIZN",
    prod = "Z02281973657LOF23E96O",
  }
  oidc_redirect_url = {
    dev = "https://${var.environment}.pds-dev.io/auth-wait"
    prod = "https://${var.environment}.pds-dev.io/auth-wait"
  }
  cloud_account = {
    dev  = "portworx-dev",
    prod = "portworx",
  }
  environments = {
    dev01      = "dev01",
    dev02      = "dev02",
    dev03      = "dev03",
    production = "production"
  }
  value_files = {
    flux-config = {
      location = "./config/flux-config.yaml"
    }
    flux-secret = {
      location = "./config/flux-secret.yaml"
    }
    flux-setup = {
      location = "./config/flux-setup.yaml"
    }
    k8s = {
      location = "./config/k8s.yaml"
    }
  }
}
data "spectrocloud_cluster_profile" "pds_flux_profile" {
  name = var.flux_profile_name
}

data "spectrocloud_cluster_profile" "pds_infra_profile" {
  name = var.infra_profile_name
}

data "spectrocloud_cloudaccount_aws" "this" {
  name = local.cloud_account[var.account]
}
# Get FLUX SOPS GPG Secret
data "aws_secretsmanager_secret" "flux-sops-gpg" {
  name = "secret/engineering/portworx/pds/kustomize/sops-gpg"
}
data "aws_secretsmanager_secret_version" "flux-sops-gpg" {
  secret_id = data.aws_secretsmanager_secret.flux-sops-gpg.id
}

# Get OIDC Token
data "aws_secretsmanager_secret" "token-issuer-staging" {
  name = "secret/engineering/portworx/pds/px-central/token-issuer-staging"
}

data "aws_secretsmanager_secret_version" "token-issuer-staging" {
  secret_id = data.aws_secretsmanager_secret.token-issuer-staging.id
}

### Create Random Strings ###
resource "random_string" "self-signing-secret" {
  length  = 32
  special = false
}
resource "random_string" "encryption-secret" {
  length  = 16
  special = false
}
### Create Random Suffix ###
resource "random_string" "suffix" {
  length  = 6
  special = false
  number  = false
  upper   = false
}


#### Create AWS Resources #####
## AWS IAM Policy for Portworx on EKS Nodes
resource "aws_iam_policy" "portworx" {
  name        = "${var.name}-${random_string.suffix.result}-portworx"
  description = "PDS policy to enable Portworx on EKS nodes."
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:ModifyVolume",
        "ec2:DetachVolume",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeTags",
        "ec2:DescribeVolumeAttribute",
        "ec2:DescribeVolumesModifications",
        "ec2:DescribeVolumeStatus",
        "ec2:DescribeVolumes",
        "ec2:DescribeInstances",
        "autoscaling:DescribeAutoScalingGroups"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
# Create Observability Buckets for PDS Cluster
resource "aws_s3_bucket" "observability" {
  bucket        = "pds-${var.account}-observability-${var.owner}-${random_string.suffix.result}"
  force_destroy = true

}
# Create IAM Policy for PDS Observability Buckets
resource "aws_iam_policy" "observability" {
  name        = "pds-${var.account}-observability-${var.owner}-${random_string.suffix.result}"
  description = "PDS policy to allow access to observability S3 storage."
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.observability.arn}",
        "${aws_s3_bucket.observability.arn}/*"
      ]
    }
  ]
}
EOF
}
#### Create Clusters ####

resource "spectrocloud_cluster_eks" "this" {

  name             = "${var.name}-${random_string.suffix.result}"
  tags             = var.tags
  cloud_account_id = data.spectrocloud_cloudaccount_aws.this.id

  cloud_config {
    ssh_key_name = var.sshKeyName
    region       = var.aws_region
  }


  cluster_profile {
    id = data.spectrocloud_cluster_profile.pds_infra_profile.id
    pack {
      name = "kubernetes-eks"
      tag  = "1.21"
      values = templatefile(local.value_files["k8s"].location, {
        pxObservabilityArn : aws_iam_policy.observability.arn,
        dnsUpdaterArn : local.dns_policy[var.account],
        portworxArn : aws_iam_policy.portworx.arn
      })
    }

  }
  cluster_profile {
    id = data.spectrocloud_cluster_profile.pds_flux_profile.id
    pack {
      name = "pds-flux-config"
      tag  = "1.0.0"
      manifest {
        name = "flux-secret"
        content = templatefile(local.value_files["flux-secret"].location, {
          hostedZoneId : local.hosted_zone[var.account],
          awsRegion : var.aws_region,
          oidcRedirectUrl : local.oidc_redirect_url[var.environment],
          oidcClientSecret : data.aws_secretsmanager_secret_version.token-issuer-staging.secret_string,
          oidcClientId : "'3'",
          oidcIssuer : "https://release-staging-api.portworx.dev/api",
          selfSigningSecret : random_string.self-signing-secret.result,
          encryptionSecret : base64encode(random_string.encryption-secret.result),
          observabilityBucketName : aws_s3_bucket.observability.bucket


        })
      }
      manifest {
        name = "flux-config"
        content = templatefile(local.value_files["flux-config"].location, {
          fluxBranch : var.flux_branch,
          fluxEnvironment : var.flux_environment
          ghPassword : var.gh_password
          ghUser : var.gh_user
          pxSopsAsc : data.aws_secretsmanager_secret_version.flux-sops-gpg.secret_string
        })
      }
    }
  }
  machine_pool {
    name          = "workers"
    count         = 3
    instance_type = "m5.xlarge"
    disk_size_gb  = 100
  }
}

