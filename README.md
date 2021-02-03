# Azure Policy Deploy If Not Exists (DINE) Assignment Module (tf-az-dine-policy-assignment)

This module handles the assignment of an Azure DINE Policy as well as the Managed Service Identity creation and RBAC assignment at the same policy assignment scope (can be changed to another scope if required as well).

## Example Usage

```hcl

module "dine-pol-asi" {
  source = "github.com/jtracey93/tf-az-dine-policy-assignment?ref=v0.3.4"

  policyARMLocation     = "West Europe" //OPTIONAL - Defaults to 'North Europe'
  policyName            = "dine-pol-asi-demo-1"
  policyDescription     = "Demo DINE Azure Policy Assignment 1 - Using DINE Module (https://github.com/jtracey93/tf-az-dine-policy-assignment)"
  policyAssignmentScope = "/providers/Microsoft.Management/managementGroups/Landing-Zones"
  policyDefinitionID    = "/providers/Microsoft.Management/managementgroups/Contoso/providers/Microsoft.Authorization/policyDefinitions/DINE-Demo-Policy-Def"
  policyParameters = (
    {
      "parameter1" : {
        "value" : "123"
      },
      "parameter2" : {
        "value" : "abc"
      },
    }
  ) //OPTIONAL - Defaults to 'Null'

  policyMsiRbacRoleNames = ["Owner", "Contributor"] 
  rbacAssignmentScope    = "/providers/Microsoft.Management/managementGroups/Platform" //OPTIONAL - Default to the same value provided to 'policyAssignmentScope' input variable above

}

```

## Argument Reference

The following arguments are supported:

* `source` - (Required) Specifies the path to the module.

* `policyARMLocation` - (Optional) The name of the Azure Region to target the Azure Policy Assignment too. Azure Policies are not tied to a specific region so this mainly dictates where the Managed Service Identity is created as part of the Policy Assignment. Defaults to `North Europe`.

* `policyName` - (Required) The name for the policy assignment. This value is also used for the Policy Assignment Display Name. Changing this forces a new resource to be created.This must be 24 characters in length or less.

* `policyDescription` - (Required) A description to use for this Policy Assignment.

* `policyAssignmentScope` - (Required) The Scope at which the Policy Assignment should be applied, which must be a Resource ID (such as Management Group e.g. `/providers/Microsoft.Management/managementGroups/Landing-Zones`, Subscription e.g. `/subscriptions/00000000-0000-0000-000000000000`, Resource Group e.g. `/subscriptions/00000000-0000-0000-000000000000/resourceGroups/myResourceGroup`). Changing this forces a new resource to be created.

* `policyDefinitionID` - (Required) The Resource ID of the Policy Definition to be assigned. e.g. `/providers/Microsoft.Management/managementgroups/Contoso/providers/Microsoft.Authorization/policyDefinitions/DINE-Demo-Policy-Def`.

* `policyParameters` - (Optional) Parameters for the policy definition to be used in assignment. This field is a JSON string, wrapped in brackets`( )`, that maps to the Parameters field from the Policy Definition. Changing this forces a new resource to be created.

* `policyMsiRbacRoleNames` - (Required) The name of the RBAC roles required for the Managed Service Identity (MSI) to be used for the DeployIfNotExists (DINE) Policy Assignment. e.g. `["Owner", "Contributor"]` or `["Owner"]`

* `rbacAssignmentScope` - (Optional) The Scope at which the MSI is RBAC is assigned/granted, which must be a Resource ID (such as Management Group e.g. `/providers/Microsoft.Management/managementGroups/Landing-Zones`, Subscription e.g. `/subscriptions/00000000-0000-0000-000000000000`, Resource Group e.g. `/subscriptions/00000000-0000-0000-000000000000/resourceGroups/myResourceGroup`). Defaults to the same value as `policyAssignmentScope` if not specified.

## Attributes Reference

The following attributes are exported:

* `policyAsignmentOutput` - The output of the entire Policy Assignment object