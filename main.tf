/**
 * Copyright 2018 Google LLC
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


provider "google" {
  credentials = "${file("/root/.config/gcloud/application_default_credentials.json")}"
  # credentials = "${file("/home/bmenasha/Downloads/gcpidentityexample-1-cf-1-6c0eaee5ccd6.json")}"
}

provider "gsuite" {
  credentials = "/root/.config/gcloud/application_default_credentials.json"
  # credentials = "/home/bmenasha/Downloads/gcpidentityexample-1-cf-1-6c0eaee5ccd6.json"
  impersonated_user_email = "${var.admin_email}"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.user"
  ]
}


resource "google_folder" "dothraki" {
  display_name = "dothraki"
  parent       = "organizations/${var.organization_id}"
}

resource "google_folder" "dothraki-horses" {
  display_name = "dothraki-horses"
  parent       = "${google_folder.dothraki.id}"
}

resource "google_folder" "dothraki-donkeys" {
  display_name = "dothraki-donkeys"
  parent       = "${google_folder.dothraki.id}"
}


resource "google_folder" "dothraki-sheep" {
  display_name = "dothraki-sheep"
  parent       = "${google_folder.dothraki.id}"
}

resource "google_folder" "dothraki-horses-dev" {
  display_name = "dothraki-horses-dev"
  parent       = "${google_folder.dothraki-horses.id}"
}

module "dothraki-horses-dev-1" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "dothraki-horses-dev-1"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.dothraki-horses-dev.id}"
  billing_account   = "${var.billing_account}"
}

resource "google_folder" "dothraki-horses-prod" {
  display_name = "dothraki-horses-prod"
  parent       = "${google_folder.dothraki-horses.id}"
}

module "dothraki-horses-prod-1" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "dothraki-horses-prod-1"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.dothraki-horses-prod.id}"
  billing_account   = "${var.billing_account}"
  create_group      = "true"
  group_name        = "dothraki-horses-prod-1-editors"
}

module "dothraki-horses-prod-2" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "dothraki-horses-prod-2"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.dothraki-horses-prod.id}"
  billing_account   = "${var.billing_account}"
  create_group      = "true"
  group_name        = "dothraki-horses-prod-2-editors"
}

resource "google_folder" "qohor" {
  display_name = "qohor"
  parent       = "organizations/${var.organization_id}"
}

resource "google_folder" "qohor-valyrian" {
  display_name = "qohor-valyrian"
  parent       = "${google_folder.qohor.id}"
}

resource "google_folder" "qohor-valyrian-dev" {
  display_name = "qohor-valyrian-dev"
  parent       = "${google_folder.qohor-valyrian.id}"
}

resource "google_folder" "qohor-valyrian-prod" {
  display_name = "qohor-valyrian-prod"
  parent       = "${google_folder.qohor-valyrian.id}"
}

module "qohor-valyrian-prod-1" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "qohor-valyrian-prod-1"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.qohor-valyrian-prod.id}"
  billing_account   = "${var.billing_account}"
  create_group      = "true"
  group_name        = "qohor-valyrian-prod-1-editors"
}

resource "google_folder" "lhazar" {
  display_name = "lhazar"
  parent       = "organizations/${var.organization_id}"
}

resource "google_folder" "lhazar-sheep" {
  display_name = "lhazar-sheep"
  parent       = "${google_folder.lhazar.id}"
}

resource "google_folder" "lhazar-sheep-dev" {
  display_name = "lhazar-sheep-dev"
  parent       = "${google_folder.lhazar-sheep.id}"
}

module "lhazar-sheep-dev-1"{
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "lhazar-sheep-dev-1"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  billing_account   = "${var.billing_account}"
  folder_id         = "${google_folder.lhazar-sheep-dev.id}"
  create_group      = "true"
  group_name        = "lhazar-sheep-dev-1-editors"
}


resource "google_folder" "take-over" {
  display_name = "take-over"
  parent       = "organizations/${var.organization_id}"
}

module "take-over-1" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "take-over-theworld-1123-1"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.dothraki-horses-dev.id}"
  billing_account   = "${var.billing_account}"
}



resource "google_folder" "take-over-the-world" {
  display_name = "take-over-the-world"
  parent       = "organizations/${var.organization_id}"
}

module "take-over-the-world-2" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "take-over-theworld-1123-2"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.take-over-the-world.id}"
  billing_account   = "${var.billing_account}"
}

module "take-over-the-world-3" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "take-over-theworld-1123-3"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.take-over-the-world.id}"
  billing_account   = "${var.billing_account}"
}


module "vpc" {
    source            = "terraform-google-modules/network/google"
    version = "0.4.0"
    project_id   = "take-over-theworld-1123-3"
    network_name = "example-vpc"
    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-west1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-west1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
        },
    ]
    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]
        subnet-02 = []
    }
}
