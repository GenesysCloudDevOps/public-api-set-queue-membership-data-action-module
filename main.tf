resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "delete" = {
                "type" = "boolean"
            },
            "queueId" = {
                "type" = "string"
            },
            "userId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "[\n  {\n    \"id\": \"$${input.userId}\"\n  }\n]"
        request_type         = "POST"
        request_url_template = "/api/v2/routing/queues/$${input.queueId}/members?delete=$${input.delete}"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}