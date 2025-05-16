output "cluster_name" {
   description = "O nome do cluster GKE criado."
   value       = google_container_cluster.primary.name
}

output "cluster_id" {
   description = "O ID do cluster GKE criado."
   value       = google_container_cluster.primary.id
}

output "node_pool_name" {
  description = "O nome do pool de nós GKE criado."
  value       = google_container_node_pool.primary_preemptible_nodes.name
}

output "node_pool_id" {
  description = "O ID do pool de nós GKE criado."
  value       = google_container_node_pool.primary_preemptible_nodes.id
}

output "service_account_email" {
  description = "O email da Service Account criada para o node pool."
  value       = google_service_account.default.email
}