terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.0" # Use uma versão compatível com suas necessidades
    }
  }
}

# Configuração do provedor Google.
# É comum configurar o project e a region/zone aqui ou passá-los via variáveis.
# Neste exemplo, vamos usar variáveis definidas em variables.tf.
provider "google" {
  project = var.project_id
  region  = var.region
  # zone = var.zone # Opcional, se quiser fixar uma zona específica
}