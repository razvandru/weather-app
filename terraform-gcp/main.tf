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
  name     = "${var.cluster_name}-gke"
  location = var.gcp_region
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false # Explicitly disable deletion protection
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
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
