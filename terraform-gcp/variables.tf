variable "gcp_project_id" {
  description = "The Google Cloud project ID to deploy to."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy the GKE cluster to."
  type        = string
  default     = "europe-central2"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "weather-app"
}

variable "node_count" {
  description = "The number of worker nodes in the GKE cluster."
  type        = number
  default     = 2
}
