terraform {
          required_version = ">= 0.12.9, != 0.13.0"
          required_providers {
            terracurl = {
              source = "devops-rob/terracurl"
              version = "1.2.2"
              }
          }
}

resource "terracurl_request" "run-scan" {
  name         = "run-scan"
  url          = "https://app.heyhack.com/api/scanjobs?profile_id=${var.wasprofileid}&application_id=${var.wasappid}"
  method       = "POST"

  headers = {
   Authorization = "${var.wasapi}"
  }

  response_codes = [
    200
  ]

}
