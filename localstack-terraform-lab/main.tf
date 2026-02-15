module "meu_bucket" {
  source         = "./modules/s3-bucket"
  nome_do_bucket = "bucket-projeto-profissional-2026"
}