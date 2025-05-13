variable "api_cert" {
	type = string
	default = "certificate.cert"
}
        
variable "api_key" {
	type = string
	default = "private_key.key"
}

variable "api_url" {
  type = string
  default = "https://f5-emea-ent.console.ves.volterra.io/api"
}

variable "f5xcapi" {
	type = string
}

variable "swagger_name" {
	type = string
	default = "swagger-shift2left"
}

variable "namespace" {
  type = string
}

variable "appname" {
  type = string
}
