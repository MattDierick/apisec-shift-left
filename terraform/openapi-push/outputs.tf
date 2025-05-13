output "response_oas_push" {
  value = jsondecode(terracurl_request.swagger.response)
}

output "url_swagger" {
    value = jsondecode(data.jq_query.swagger_url.result)
}
