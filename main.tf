/*


Enable OS Login feature on VM ( this is added in metadata, and apparently required to be done at VM creation)
Grant OS Login Permission to service account
Grant IAP-Secured Tunnel User Permission

Enable IAP SSH traffic in firewall to the VM
Enable IAM API
Enable IAP Proxy API
Enable OS Login API
Cloud Build API(for cloudbuild)

#VM with OS login metadata - IAP Secured tunnel permission
resource
*/


#VPC
resource "google_compute_network" "test_network" {
  project                 = "terraform-testing-project-sg"
  name                    = "test-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}
#VPC Subnet

# Firewall rule IAP SSH traffic
resource "google_compute_firewall" "iap-ssh-allow" {
  name        = "iap-ssh-allow"
  network     = "test-network"
  direction   = "INGRESS"
  priority    = 1000
  project     = "terraform-testing-project-sg"

  source_ranges = ["35.235.240.0/20"]

  # Allow SSH traffic
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Apply the firewall rule to instances with the "iap-ssh" tag
  target_tags = ["iap-ssh"]
}

# Create the f1-compute engine instance
resource "google_compute_instance" "f1-instance" {
  name         = "f1-instance"
  machine_type = "f1-micro"
  zone         = "us-west1-b"
  project      = "terraform-testing-project-sg"
  tags         = ["iap-ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  # Enable OS Login and IAP SSH
  metadata = {
    enable-oslogin = "TRUE"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    network         = "test-network"    
  }
}


