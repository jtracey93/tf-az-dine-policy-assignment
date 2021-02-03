variable "policyName" {
  type        = string
  description = "The name of the Azure policy assignment and display name."

  validation {
    condition     = length(var.policyName) <= 24
    error_message = "Cannot exceed 24 characters."
  }

}

variable "policyARMLocation" {
  type = string
  description = "The region to target the deployment at. Note that policies are not region specific so this is mainly for Managed Identity purposes"
}

variable "policyDescription" {
  type        = string
  description = "The Azure policy assignment description."

}

variable "policyAssignmentScope" {
  type        = string
  description = "The ARM resoruce ID of where this policy should be assigned. e.g Management Group, Subscription etc."
}

variable "rbacAssignmentScope" {
  type        = string
  description = "The ARM resoruce ID of where this policies managed identity should be assigned. e.g Management Group, Subscription etc."
}

variable "policyDefinitionID" {
  type        = string
  description = "The ARM resoruce ID of the Azure Policy Definititon."
}

variable "policyParameters" {
  default     = null
  description = "The Azure Policy Assignment parameters, if required."
}

variable "policyMsiRbacRoleNames" {
  type        = set(string)
  description = "Azure RBAC Role Names required for DINE policy MSI. Can specify multiple RBAC roles as a set."
}


