output "was_app_id" {
   value = jsondecode(terracurl_request.create-app.response)
}
