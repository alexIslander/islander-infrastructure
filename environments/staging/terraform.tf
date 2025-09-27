terraform {
  cloud {
    organization = "islander-corp"
    workspaces {
      name = "oci-infrastructure-staging"
    }
  }
}

