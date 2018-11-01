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

/** group created too fast **/
module "dothraki-1" {
  source            = "github.com/DothrakiHord/terraform-google-project-factory"
  name              = "dothraki-horses-dev-1-3323f"
  activate_apis      = ["compute.googleapis.com", "container.googleapis.com", "cloudbilling.googleapis.com"]
  org_id            = "${var.organization_id}"
  folder_id         = "${google_folder.dothraki.id}"
  billing_account   = "${var.billing_account}"
  create_group      = "true"
  group_name        = "dothraki-horses-dev-1-editors"
}
