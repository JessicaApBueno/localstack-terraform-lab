# 🚀 LocalStack & Terraform: S3 DevSecOps Lab

![Terraform CI](https://github.com/JessicaApBueno/localstack-terraform-lab/actions/workflows/terraform.yml/badge.svg)
![Terraform Version](https://img.shields.io/badge/terraform-v1.x-purple)
![LocalStack](https://img.shields.io/badge/localstack-v4.x-blue)

Este projeto demonstra um fluxo de trabalho profissional de **Infraestrutura como Código (IaC)** utilizando **Terraform** para simular recursos da AWS localmente com **LocalStack**. O foco principal é a implementação de uma esteira de **CI/CD no GitHub Actions** com validações automáticas de qualidade, segurança e simulação de infraestrutura.

[Image of a professional DevSecOps pipeline for Terraform]

## 📂 Organização do Projeto

A estrutura segue o padrão de **módulos reutilizáveis**, separando a lógica de recursos da configuração global:

```text
localstack-terraform-lab/
├── .github/workflows/
│   └── terraform.yml       # Esteira de CI/CD (GitHub Actions)
├── modules/
│   └── s3-bucket/          # Módulo isolado de S3
│       ├── main.tf         # Recursos S3 (Bucket, Segurança, Versionamento)
│       └── variables.tf    # Variáveis específicas do módulo
├── .gitignore              # Proteção contra arquivos temporários
├── main.tf                 # Chamada dos módulos (Entrypoint)
├── provider.tf             # Configuração do LocalStack e AWS Provider
└── variables.tf            # Variáveis globais do projeto
```

## 🛠️ O que cada arquivo faz?
### 1. Configuração Global (Raiz)
provider.tf: Configura o provedor AWS para apontar para o endpoint do LocalStack (http://localhost:4566). A versão do provedor foi travada em ~> 5.0 para garantir compatibilidade.

main.tf: Ponto central onde o módulo de S3 é instanciado. Ele permite criar buckets de forma padronizada em diferentes ambientes.

.gitignore: Essencial para segurança, impedindo que o estado do Terraform (.tfstate) e chaves sensíveis sejam enviados ao controle de versão.

### 2. Módulo de S3 (modules/s3-bucket/)
O módulo foi atualizado para seguir as melhores práticas de segurança exigidas pelo tfsec:

Public Access Block: Bloqueia explicitamente todo acesso público ao bucket.

Server-Side Encryption: Ativa a criptografia AES256 por padrão em todos os objetos.

Versioning: Habilita o histórico de versões para proteção contra deleções acidentais.

### 3. Automação de CI/CD (.github/workflows/)
O arquivo terraform.yml define uma esteira visual de 3 etapas:
<img width="850" height="200" alt="image" src="https://github.com/user-attachments/assets/40d16815-c81d-48b3-b9c1-ff47ed4d5b30" />

Check Code Quality: Roda terraform fmt e validate para garantir que o código está bem escrito.

Security Scan: Utiliza o tfsec para analisar vulnerabilidades antes de qualquer simulação.

LocalStack Plan: Inicia um container LocalStack temporário no GitHub e gera o plano de execução (terraform plan).

## 🔍 Troubleshooting (Desafios & Soluções)
Durante a construção do laboratório, os seguintes problemas técnicos foram resolvidos:

MalformedXML (Error 400): Resolvido ao realizar o downgrade do provider AWS para a versão 5.x, evitando conflitos de protocolo XML do LocalStack v4.

Workflow "Invisível": Resolvido ao mover a pasta .github para a raiz absoluta do repositório, permitindo que o GitHub Actions detectasse o YAML.

Job de Validação Falhando: Resolvido ao adicionar terraform init na primeira etapa do pipeline, permitindo que o runner "enxergasse" os módulos locais.

Vulnerabilidades de Segurança: O tfsec barrou o deploy inicial por falta de criptografia e bloqueio de acesso público. Corrigido com a adição de recursos aws_s3_bucket_public_access_block e aws_s3_bucket_server_side_encryption_configuration.
<img width="684" height="541" alt="image" src="https://github.com/user-attachments/assets/67d3fd5e-dbe5-4f3f-8de8-d6f9af748a53" />


---

© 2026 - Desenvolvido por Jessica Bueno para fins de estudo em Cloud & DevSecOps.


---

