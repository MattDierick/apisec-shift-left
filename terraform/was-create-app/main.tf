terraform {
          required_version = ">= 0.12.9, != 0.13.0"
          required_providers {
            terracurl = {
              source = "devops-rob/terracurl"
              version = "1.2.2"
            }
          }
        }


resource "terracurl_request" "create-app" {
  name         = "create-app"
  url          = "https://app.heyhack.com/api/applications"
  method       = "POST"
  request_body = <<EOF
{
  "address": "${var.fqdn}",
  "name": "${var.appname}",
  "useKnownIpAddress": false,
  "users":[]
}

EOF

  headers = {
   Authorization = "${var.wasapi}"
   Content-Type = "application/json"
  }

  response_codes = [
    200
  ]

}
