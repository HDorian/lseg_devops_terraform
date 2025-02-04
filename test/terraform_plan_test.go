package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformPlanExecution(t *testing.T) { // Rename function
    t.Parallel()
    t.Log("Terraform test started...")

    terraformOptions := &terraform.Options{
        TerraformDir: "../",
    }

    // Initialize and Validate Terraform
    terraform.InitAndValidate(t, terraformOptions)
    t.Log("Terraform validation completed.")

    // Run Terraform Plan
    plan := terraform.Plan(t, terraformOptions)
    t.Log("Terraform plan executed.")

    // Ensure the plan is generated correctly
    assert.NotEmpty(t, plan)
}
