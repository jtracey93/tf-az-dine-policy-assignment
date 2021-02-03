terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.43.0"
    }
  }
  required_version = ">= 0.13"
}


locals {
  region    = (var.policyARMLocation != null ? var.policyARMLocation : "North Europe")
  rbacScope = (var.rbacAssignmentScope != null ? var.rbacAssignmentScope : var.policyAssignmentScope)
}

resource "azurerm_policy_assignment" "dine-pol-asi" {
  name                 = var.policyName
  scope                = var.policyAssignmentScope
  policy_definition_id = var.policyDefinitionID
  description          = var.policyDescription
  display_name         = var.policyName
  location             = local.region

  identity {
    type = "SystemAssigned"
  }

  parameters = jsonencode(var.policyParameters)
}

resource "azurerm_role_assignment" "dine-pol-rbac-asi" {
  for_each = var.policyMsiRbacRoleNames

  principal_id                     = azurerm_policy_assignment.dine-pol-asi.identity[0].principal_id
  scope                            = local.rbacAssignmentScope
  role_definition_name             = each.value
  skip_service_principal_aad_check = true
}

