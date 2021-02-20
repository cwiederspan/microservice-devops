variable "resource_group_name" { 
  #default = "mhug-devops-20180918"
}

variable "app_service_name" { 
  #default = "mhug-app-ms01-20180918"
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
  #default = "166"
}


resource "azurerm_resource_group" "group" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.resource_group_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  kind                = "Linux"

  properties {
    reserved = true
  }

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_service_name}-${var.image_tag}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  app_service_plan_id = "${azurerm_app_service_plan.plan.id}"
  #kind                = "app,linux,container"
  
  site_config {
    always_on         = true
    linux_fx_version  = "DOCKER|${var.acr_name}.azurecr.io/${var.image_name}:${var.image_tag}"
    #default_documents = [ "Index.html" ]
  }

  app_settings {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://${var.acr_name}.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME     = "${var.acr_name}"
    DOCKER_REGISTRY_SERVER_PASSWORD     = "${var.acr_password}"
  }
}