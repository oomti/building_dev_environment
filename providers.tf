terraform { 
    required_providers {
      gcp = {
        source = "hashicorp/gcp"
      }
    }
}

provider "google" {
    project = "devops-unleashed"
    region  = "us-west1"
}