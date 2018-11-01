/**
 * Copyright 2018 Google LLC
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
}

provider "gsuite" {
  credentials = "/root/.config/gcloud/application_default_credentials.json"
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
  create_group      = "false"
  group_name        = "dothraki-horses-dev-1-editors"
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
  create_group      = "false"
  group_name        = "dothraki-horses-prod-1-editors"
}

module "dothraki-horses-prod-2" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "dothraki-horses-prod-2"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.dothraki-horses-prod.id}"
  billing_account   = "${var.billing_account}"
  create_group      = "false"
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
  create_group      = "false"
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
  create_group      = ""
  group_name        = "lhazar-sheep-dev-1-editors"
  app_engine        = {"location" = "us-central"}
}
