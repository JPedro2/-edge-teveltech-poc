
data "spectrocloud_cluster_profile" "pds_flux_profile" {
  name = var.flux_profile_name
}

data "spectrocloud_cluster_profile" "pds_infra_profile" {
  name = var.infra_profile_name
}

data "spectrocloud_cloudaccount_aws" "this" {
  name = local.cloud_account[var.account]
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

