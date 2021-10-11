variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "layer" {
  description = "Nombre del proyecto"
  type        = string
  default     = "YOUR_PROJECT_NAME"  # CHANGE
}

variable "component_name" {
  description = "Nombre del componente"
  type        = string
  default     = "core"
}

variable "aliases" {
  default = ["YOUR_PROJECT_DOMAIN"]  # CHANGE, exm: test123.com
  type    = list(string)
}

variable "domain_name"  {
  default  = "YOUR_PROJECT_DOMAIN"   # CHANGE, exm: test123.com
  type    = string
}

variable "stack_id" {
  description = "A unique identifier for the deployment. Used as a prefix for all the Openstack resources."
  type        = string
  default     = "prod"
}

variable "type" {
  description = "Tipo del recurso, infra, frontend, movil, backend"
  type        = string
  default     = "frontend"
}

variable "path_name_content" {
  description = "Path de consumo para contenido estatico"
  type = string
  default  = "html"
}

variable "path_name_back" {
  description = "Path de consumo peticiones back"
  type = string
  default = "wp-json"
}

variable "user_information" {
  description = "Información de IAM"
  type = object({
    access_key  = string
    secret_key  = string
  })
  default = {
    access_key  = "YOUR_AWS_ACCESS_KEY"  # CHANGE
    secret_key  = "YOUR_AWS_SECRET_KEY"  # CHANGE
  }
  sensitive = true
}

# Variable Security Group
variable "ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
      {
        description = "HTTP"
        # En este caso solo se acepta un puerto el 80
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "HTTPS"
        # En este caso solo se acepta un puerto el 443
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description      = "TCP"
        # En este caso solo se acepta un puerto el 3389
        from_port        = 3389
        to_port          = 3389
        protocol         = "tcp"
        # Dirección por defecto para ipv4 'cualquier dirección puede acceder a él
        cidr_blocks      = ["0.0.0.0/0"]
      },
      {
        description      = "SSH"
        # En este caso solo se acepta un puerto el 22
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        # Dirección por defecto para ipv4 'cualquier dirección puede acceder a él
        cidr_blocks      = ["0.0.0.0/0"]
      }  
  ]
}