#VPC
resource "google_compute_network" "test_network" {
  project                 = "terraform-testing-project-sg"
  name                    = "test-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}
#VPC Subnet

# Firewall rule IAP SSH traffic


/*
Enable OS Login feature on VM ( this is added in metadata, and apparently required to be done at VM creation)
Grant OS Login Permission to service account
Grant IAP-Secured Tunnel User Permission
Grant Cloud Build Service account(for cloud build)
Enable IAP SSH traffic in firewall to the VM
Enable IAM API
Enable IAP Proxy API
Enable OS Login API
Cloud Build API(for cloudbuild)

#VM with OS login metadata - IAP Secured tunnel permission
resource
*/