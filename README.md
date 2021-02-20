# Microservice DevOps

## Intro
**Name:** Chris Wiederspan  
**Role:** Microsoft Azure App Dev Specialist  
**Email:** chris.wiederspan@microsoft.com

## Prerequisites

### Setup a Service Principal for use with AKS

Based on [this guidance](https://docs.microsoft.com/en-us/azure/container-service/kubernetes/container-service-kubernetes-service-principal), we will start by setting up a Service Principal that we'll use when creating an Azure AKS cluster.

`az login`  
`az ad sp create-for-rbac --name <YOUR_SP_NAME>`

You'll want to make a copy of the results, specifically the appId and password, as shown below.

![Credential screenshot](/Assets/service-principal-creds.png)

### Azure Resource Setup Using Terraform

We will use Terraform to create a Resource Group, Azure Container Registry and an AKS Cluster.
[Click here](https://www.terraform.io/docs/providers/azurerm/index.html) to read more about Terraform
and the Azure Resource Providers that it provides.

```
cd Terraform/pets  
terraform init  
terraform apply  
```

You can expect this process to take between 10 to 15 minutes, mostly because AKS takes a while to provision in Azure.

## The Project

The code and project itself is just an out-of-the-box .NET Core 2.x Web API project that was created using the <i>Project... New...</i>
functionality in Visual Studio. The code itself is fairly irrelevant to the discussion.

## Key Files

[Terraform Pets](/Terraform/pets)  
[Terraform Cattle](/Terraform/cattle)  

## Microservices Reading
[Overview](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-overview-microservices)  
[Building Microservices Book](http://shop.oreilly.com/product/0636920033158.do)  
[Sam Newman Video](https://www.youtube.com/watch?v=PFQnNFe27kU)  