variable "appmesh_virtual_gateways" {
  description = <<EOT
Map of appmesh_virtual_gateways, attributes below
Required:
    - mesh_name
    - name
    - spec (block):
        - backend_defaults (optional, block):
            - client_policy (optional, block):
                - tls (optional, block):
                    - certificate (optional, block):
                        - file (optional, block):
                            - certificate_chain (required)
                            - private_key (required)
                        - sds (optional, block):
                            - secret_name (required)
                    - enforce (optional)
                    - ports (optional)
                    - validation (required, block):
                        - subject_alternative_names (optional, block):
                            - match (required, block):
                                - exact (required)
                        - trust (required, block):
                            - acm (optional, block):
                                - certificate_authority_arns (required)
                            - file (optional, block):
                                - certificate_chain (required)
                            - sds (optional, block):
                                - secret_name (required)
        - listener (required, block):
            - connection_pool (optional, block):
                - grpc (optional, block):
                    - max_requests (required)
                - http (optional, block):
                    - max_connections (required)
                    - max_pending_requests (optional)
                - http2 (optional, block):
                    - max_requests (required)
            - health_check (optional, block):
                - healthy_threshold (required)
                - interval_millis (required)
                - path (optional)
                - port (optional)
                - protocol (required)
                - timeout_millis (required)
                - unhealthy_threshold (required)
            - port_mapping (required, block):
                - port (required)
                - protocol (required)
            - tls (optional, block):
                - certificate (required, block):
                    - acm (optional, block):
                        - certificate_arn (required)
                    - file (optional, block):
                        - certificate_chain (required)
                        - private_key (required)
                    - sds (optional, block):
                        - secret_name (required)
                - mode (required)
                - validation (optional, block):
                    - subject_alternative_names (optional, block):
                        - match (required, block):
                            - exact (required)
                    - trust (required, block):
                        - file (optional, block):
                            - certificate_chain (required)
                        - sds (optional, block):
                            - secret_name (required)
        - logging (optional, block):
            - access_log (optional, block):
                - file (optional, block):
                    - format (optional, block):
                        - json (optional, block):
                            - key (required)
                            - value (required)
                        - text (optional)
                    - path (required)
Optional:
    - mesh_owner
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    mesh_name  = string
    name       = string
    mesh_owner = optional(string)
    region     = optional(string)
    tags       = optional(map(string))
    tags_all   = optional(map(string))
    spec = object({
      backend_defaults = optional(object({
        client_policy = optional(object({
          tls = optional(object({
            certificate = optional(object({
              file = optional(object({
                certificate_chain = string
                private_key       = string
              }))
              sds = optional(object({
                secret_name = string
              }))
            }))
            enforce = optional(bool)
            ports   = optional(set(number))
            validation = object({
              subject_alternative_names = optional(object({
                match = object({
                  exact = set(string)
                })
              }))
              trust = object({
                acm = optional(object({
                  certificate_authority_arns = set(string)
                }))
                file = optional(object({
                  certificate_chain = string
                }))
                sds = optional(object({
                  secret_name = string
                }))
              })
            })
          }))
        }))
      }))
      listener = list(object({
        connection_pool = optional(object({
          grpc = optional(object({
            max_requests = number
          }))
          http = optional(object({
            max_connections      = number
            max_pending_requests = optional(number)
          }))
          http2 = optional(object({
            max_requests = number
          }))
        }))
        health_check = optional(object({
          healthy_threshold   = number
          interval_millis     = number
          path                = optional(string)
          port                = optional(number)
          protocol            = string
          timeout_millis      = number
          unhealthy_threshold = number
        }))
        port_mapping = object({
          port     = number
          protocol = string
        })
        tls = optional(object({
          certificate = object({
            acm = optional(object({
              certificate_arn = string
            }))
            file = optional(object({
              certificate_chain = string
              private_key       = string
            }))
            sds = optional(object({
              secret_name = string
            }))
          })
          mode = string
          validation = optional(object({
            subject_alternative_names = optional(object({
              match = object({
                exact = set(string)
              })
            }))
            trust = object({
              file = optional(object({
                certificate_chain = string
              }))
              sds = optional(object({
                secret_name = string
              }))
            })
          }))
        }))
      }))
      logging = optional(object({
        access_log = optional(object({
          file = optional(object({
            format = optional(object({
              json = optional(list(object({
                key   = string
                value = string
              })))
              text = optional(string)
            }))
            path = string
          }))
        }))
      }))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        length(v.spec.listener) >= 1
      )
    ])
    error_message = "Each listener list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        length(v.mesh_name) >= 1 && length(v.mesh_name) <= 255
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        v.spec.backend_defaults == null || (v.spec.backend_defaults.client_policy == null || (v.spec.backend_defaults.client_policy.tls == null || (v.spec.backend_defaults.client_policy.tls.ports == null || (alltrue([for x in v.spec.backend_defaults.client_policy.tls.ports : x >= 1 && x <= 65535])))))
      )
    ])
    error_message = "must be a valid port number (1-65535)"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        v.spec.backend_defaults == null || (v.spec.backend_defaults.client_policy == null || (v.spec.backend_defaults.client_policy.tls == null || (v.spec.backend_defaults.client_policy.tls.validation.trust.sds == null || (length(v.spec.backend_defaults.client_policy.tls.validation.trust.sds.secret_name) >= 1 && length(v.spec.backend_defaults.client_policy.tls.validation.trust.sds.secret_name) <= 255))))
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.grpc == null || (item.connection_pool.grpc.max_requests >= 1)))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.http == null || (item.connection_pool.http.max_connections >= 1)))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.http == null || (item.connection_pool.http.max_pending_requests == null || (item.connection_pool.http.max_pending_requests >= 1))))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.http2 == null || (item.connection_pool.http2.max_requests >= 1)))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_gateways : (
        alltrue([for item in v.spec.listener : (item.tls == null || (item.tls.validation == null || (item.tls.validation.trust.sds == null || (length(item.tls.validation.trust.sds.secret_name) >= 1 && length(item.tls.validation.trust.sds.secret_name) <= 255))))])
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  # Note: 23 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

