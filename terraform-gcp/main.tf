terraform {
  backend "gcs" {
    bucket  = "weather-app-493314-bucket"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

resource "google_container_cluster" "primary" {
  name                = "${var.cluster_name}-gke"
  location            = var.gcp_region
  deletion_protection = false

  node_pool {
    name       = "${var.cluster_name}-node-pool"
    node_count = var.node_count

    node_config {
      preemptible  = false
      machine_type = "e2-medium"
      disk_type    = "pd-standard"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}
