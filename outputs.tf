output "appmesh_virtual_gateways_id" {
  description = "Map of id values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.id if v.id != null && length(v.id) > 0 }
}
output "appmesh_virtual_gateways_arn" {
  description = "Map of arn values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "appmesh_virtual_gateways_created_date" {
  description = "Map of created_date values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.created_date if v.created_date != null && length(v.created_date) > 0 }
}
output "appmesh_virtual_gateways_last_updated_date" {
  description = "Map of last_updated_date values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.last_updated_date if v.last_updated_date != null && length(v.last_updated_date) > 0 }
}
output "appmesh_virtual_gateways_mesh_name" {
  description = "Map of mesh_name values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.mesh_name if v.mesh_name != null && length(v.mesh_name) > 0 }
}
output "appmesh_virtual_gateways_mesh_owner" {
  description = "Map of mesh_owner values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.mesh_owner if v.mesh_owner != null && length(v.mesh_owner) > 0 }
}
output "appmesh_virtual_gateways_name" {
  description = "Map of name values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.name if v.name != null && length(v.name) > 0 }
}
output "appmesh_virtual_gateways_region" {
  description = "Map of region values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.region if v.region != null && length(v.region) > 0 }
}
output "appmesh_virtual_gateways_resource_owner" {
  description = "Map of resource_owner values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.resource_owner if v.resource_owner != null && length(v.resource_owner) > 0 }
}
output "appmesh_virtual_gateways_spec" {
  description = "Map of spec values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => one(v.spec) if v.spec != null && length(v.spec) > 0 }
}
output "appmesh_virtual_gateways_tags" {
  description = "Map of tags values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "appmesh_virtual_gateways_tags_all" {
  description = "Map of tags_all values across all appmesh_virtual_gateways, keyed the same as var.appmesh_virtual_gateways"
  value       = { for k, v in aws_appmesh_virtual_gateway.appmesh_virtual_gateways : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

