resource "google_service_account" "default" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
  project      = var.project_id # A Service Account é específica do projeto
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id # O cluster é específico do projeto

  # remove_default_node_pool = true indica que o Terraform
  # removerá o pool de nós padrão criado automaticamente pelo GKE.
  # Você precisará criar pools de nós explicitamente, como o que faremos abaixo.
  remove_default_node_pool = true

  # initial_node_count define quantos nós o pool padrão (que será removido)
  # teria. Como removemos o pool padrão, este valor tem menos impacto,
  # mas é ainda um campo obrigatório. Reutilizamos o var.node_count aqui.
  initial_node_count       = var.node_count

  # Configurações adicionais do cluster podem ser adicionadas aqui, como
  # networking, logging, monitoring, auto scaling do cluster, etc.
  # Para este exemplo, mantemos minimalista baseado no seu código de entrada.

  # Para mais opções, consulte a documentação do resource:
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_container_cluster
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  # Geral
  name       = var.node_pool_name
  cluster    = google_container_cluster.primary.name # Referencia o cluster pelo nome
  location   = var.region # O pool de nós deve estar na mesma location do cluster
  project    = var.project_id # O pool de nós deve estar no mesmo projeto do cluster
  node_count = var.node_count

  # Configuração do nó
  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    # A Service Account e os Oauth Scopes definem as permissões que
    # os nós terão para interagir com outros serviços GCP.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform" # Permissão ampla
      # Considere restringir os scopes para o mínimo necessário para segurança
    ]

    # Configurações adicionais do nó podem ser adicionadas aqui, como
    # labels, taints, metadata, disco de boot, etc.

    # Para mais opções, consulte a documentação do bloco node_config:
    # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_container_node_pool#node_config
  }

  # A dependência explícita garante que o cluster seja criado antes do pool de nós.
  # O Terraform geralmente infere isso, mas a dependência explícita aumenta a clareza.
  depends_on = [google_container_cluster.primary]

  # Para mais opções do node pool, consulte a documentação do resource:
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_container_node_pool
}