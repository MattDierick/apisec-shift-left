terraform {
          required_version = ">= 0.12.9, != 0.13.0"
          required_providers {
          volterra = {
              source = "volterraedge/volterra"
              version = "0.11.43"
           }
          terracurl = {
              source = "devops-rob/terracurl"
              version = "1.2.2"
            }
          jq = {
              source  = "massdriver-cloud/jq"
              version = "0.2.0"
            }
          }
        backend "http" {}
      }

provider "terracurl" {}
provider "jq" {}
provider "volterra" {
  url = "${var.api_url}"
  api_cert = "${var.api_cert}"
  api_key = "${var.api_key}"
}

locals {
        body = templatefile("${path.module}/payload-swagger.json.tmpl", {
            encoded-swagger = filebase64("${path.module}/../../openapi/sentence.yaml")
            })
}

resource "terracurl_request" "swagger" {
  name         = "${var.swagger_name}"
  url          = "https://f5-emea-ent.console.ves.volterra.io/api/object_store/namespaces/${var.namespace}/stored_objects/swagger/${var.swagger_name}"
  method       = "PUT"
  request_body = local.body
  destroy_skip = true

  headers = {
   Authorization = "APIToken ${var.f5xcapi}"
  }

  response_codes = [
    200
  ]

}

data "jq_query" "swagger_url" {
    data = terracurl_request.swagger.response
    query = ".metadata.url"

    depends_on = [terracurl_request.swagger]

}

resource "volterra_api_definition" "api_def_create" {
  name      = "api-def-${var.appname}"
  namespace = "${var.namespace}"
  strict_schema_origin = true

  swagger_specs = [jsondecode(data.jq_query.swagger_url.result)]

  depends_on = [terracurl_request.swagger]
}
