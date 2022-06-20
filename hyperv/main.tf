# Configure HyperV
provider "hyperv" {
  user            = "Justin"
  password        = "P@ssw0rd!"
  host            = "192.168.178.5"
  port            = 5985
  https           = false
  insecure        = false
  use_ntlm        = true
  tls_server_name = ""
  cacert_path     = ""
  cert_path       = ""
  key_path        = ""
  script_path     = "C:/Temp/terraform_%RAND%.cmd"
  timeout         = "30s"
}



terraform {
  required_providers {
    hyperv = {
      source = "taliesins/hyperv"
      version = "1.0.3"
    }
  }
}


