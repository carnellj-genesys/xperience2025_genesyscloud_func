terraform {
  required_version = ">= 1.0.0"
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.68.2"
    }
  }
}

resource "genesyscloud_integration" "Xperience_2025_Integration" {
  config {
    name       = "Xperience2025_Get_Ticket_Status"
    properties = jsonencode({		})
    advanced   = jsonencode({		})
  }
  integration_type = "function-data-actions"
  intended_state   = "ENABLED"
}
//Genesys Cloud Data Actions
resource "genesyscloud_integration_action" "Xperience_2025_Get_Ticket_Status" {
  category = "Xperience2025_Get_Ticket_Status"
  config_response {
    success_template = "$${rawResult}"
  }
  contract_input  = jsonencode({
		"properties": {
				"ticket_number": {
						"description": "Ticket_Number",
						"type": "string"
				}
		},
		"required": [
				"ticket_number"
		],
		"title": "Request",
		"type": "object"
	})
  contract_output = jsonencode({
		"properties": {
				"changed": {
						"description": "Date of Change",
						"type": "string"
				},
				"notes": {
						"description": "Notes on the ticket",
						"type": "string"
				},
				"priority": {
						"description": "priority of ticket",
						"type": "string"
				},
				"status": {
						"description": "Status of Ticket",
						"type": "string"
				},
				"ticket_number": {
						"description": "Target ticketnumber",
						"type": "string"
				}
		},
		"required": [
				"ticket_number",
				"priority",
				"status",
				"changed",
				"notes"
		],
		"title": "Response",
		"type": "object"
	})
  config_request {
    request_template     = "$${input.rawRequest}"
    request_type         = "POST"
    request_url_template = ""
  }
  integration_id = genesyscloud_integration.Xperience_2025_Integration.id
  name           = "Xperience2025_Get_Ticket_Status"
  secure         = false

  function_config {
    file_path      = "./xp2025_get_ticket_status.zip"
    description     = "Retrieve a ticket status from TicketFlow"
    handler         = "dist/index.handler"
    runtime         = "nodejs20.x"
    timeout_seconds = 15
  }
}