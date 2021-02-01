terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.43.0"
    }
  }
  required_version = ">= 0.13"
}

resource "azurerm_policy_assignment" "dine-pol-asi" {
  name                 = var.policyName
  scope                = var.assignmentScope
  policy_definition_id = var.policyDefinitionID
  description          = var.policyDescription
  display_name         = var.policyName
  location             = "North Europe"

  identity {
    type = "SystemAssigned"
  }

  parameters = jsonencode(var.policyParameters)
}

resource "azurerm_role_assignment" "dine-pol-rbac-asi" {
  for_each = var.policyMsiRbacRoleNames

  principal_id                     = azurerm_policy_assignment.dine-pol-asi.identity[0].principal_id
  scope                            = var.assignmentScope
  role_definition_name             = each.value
  skip_service_principal_aad_check = true
}

