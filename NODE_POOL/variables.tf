variable "project_id" {
  description = "O ID do projeto Google Cloud onde os recursos serão criados."
  type        = string
}

variable "region" {
  description = "A região do Google Cloud para o cluster GKE e o node pool."
  type        = string
  default     = "us-central1" # Valor padrão baseado no seu código
}

variable "cluster_name" {
  description = "O nome do cluster GKE a ser criado."
  type        = string
  default     = "my-gke-cluster" # Valor padrão baseado no seu código
}

variable "node_pool_name" {
  description = "O nome para o pool de nós GKE."
  type        = string
  default     = "my-node-pool" # Valor padrão baseado no seu código
}

variable "service_account_id" {
  description = "O ID para a Service Account a ser criada (a parte antes de @project-id.iam.gserviceaccount.com)."
  type        = string
  default     = "gke-node-pool-sa" # Um ID mais genérico
}

variable "service_account_display_name" {
  description = "O nome de exibição para a Service Account."
  type        = string
  default     = "GKE Node Pool Service Account"
}

variable "machine_type" {
  description = "O tipo de máquina para os nós no node pool."
  type        = string
  default     = "e2-medium" # Valor padrão baseado no seu código
}

variable "node_count" {
  description = "O número de nós desejado no node pool."
  type        = number
  default     = 1 # Valor padrão baseado no seu código
}

variable "preemptible" {
  description = "Define se os nós no node pool são preemptíveis."
  type        = bool
  default     = true # Valor padrão baseado no seu código
}