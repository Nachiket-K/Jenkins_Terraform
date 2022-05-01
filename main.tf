terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.15.0"
    }
  }
}
provider "google" {
  project="nachiket-devops"
  region="us-central1"
  zone = "us-central1-a"
}
resource "google_cloud_run_service" "run-app-from-tf" {
  name = "run-app-from-tf-nnk"
  location="us-central1"
  template {
    spec{
      containers{
        image="us.gcr.io/nachiket-devops/github_nachiket-k_cloud-build-cloud-run-python/github-nachiket-k-cloud-build-cloud-run-python:40eb24488221f8103d1663a4ebe098020f3498ec"

      }
    }
  }
}
resource "google_cloud_run_service_iam_policy" "pub_access" {
  service=google_cloud_run_service.run-app-from-tf.name
  location = google_cloud_run_service.run-app-from-tf.location
  policy_data = data.google_iam_policy.pub-1.policy_data
}

data "google_iam_policy" "pub-1"{
  binding {
    role="roles/run.invoker"
    members=["allUsers"]
  }
}
