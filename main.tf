module "compute" {
  source            = "./modules/compute"
  compute_config    = var.compute_config
  allow_https_sg_id = module.network.allow_https_sg_id
}

module "network" {
  source         = "./modules/network"
  network_config = var.network_config
}

module "database" {
  source = "./modules/database"

  dynamodb_config = var.dynamodb_config
}
