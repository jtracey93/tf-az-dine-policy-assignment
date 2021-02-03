# Azure Policy Deploy If Not Exists (DINE) Assignment Module

This module handles the assignment of an Azure DINE Policy as well as the Managed Service Identity creation and RBAC assignment at the same policy assignment scope.

## Usage

```terraform

module "nav-activity-log-pol-asi" {
  source = "github.com/jtracey93/tf-az-dine-policy-assignment?ref=v0.2.1"

  policyName         = "test-module-dine-001"
  policyDescription  = "Test DINE TF Module Asignment"
  assignmentScope    = module.management_groups.output["JT"]["Landing-Zones"]["NAV"].id
  policyDefinitionID = module.azopsreference.policydefinition_deploy_diagnostics_activitylog.id
  policyParameters = (
    {
      "logAnalytics" : {
        "value" : "azurerm_log_analytics_workspace.jt-nstar-lab-mgmt-law-01.id"
      }
    }
  )

  policyMsiRbacRoleNames = ["Owner", "Contributor"]

}
```