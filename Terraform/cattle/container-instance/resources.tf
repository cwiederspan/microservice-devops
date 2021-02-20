variable "resource_group_name" { 
  #default = "mhug-devops-20180918"
}

variable "aci_service_name" { 
  #default = "mhug-aci-ms01-20180918"
}

variable "location" {
  default = "westus2"
}

variable "acr_name" { 
  #default = "mhugacr20180918"
}

variable "acr_password" { }

variable "image_name" { 
  #default = "microservice-api-docker-01"
}

variable "image_tag" { 
  #default = "170"
}


resource "azurerm_resource_group" "group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_container_group" "aci" {
  name                = "${var.aci_service_name}-${var.image_tag}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  ip_address_type     = "public"
  dns_name_label      = "${var.aci_service_name}-${var.image_tag}"
  os_type             = "linux"

  container {
    name   = "hw"
    image  = "${var.acr_name}.azurecr.io/${var.image_name}:${var.image_tag}"
    cpu    ="1.0"
    memory =  "1.5"
    port   = "80"
  }

  image_registry_credential {
    server   = "${var.acr_name}.azurecr.io"
    username = "${var.acr_name}"
    password = "${var.acr_password}"
  }
}