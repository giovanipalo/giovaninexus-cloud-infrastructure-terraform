# Infraestrutura em Nuvem com Terraform no Azure

Este projeto configura e gerencia a infraestrutura em nuvem no Azure usando Terraform. Abaixo, você encontrará informações sobre como configurar, usar e contribuir para este projeto.

## Estrutura do Projeto

/projeto │ ├── Dockerfile │ └── IaC ├── main.tf ├── providers.tf └── terraform.tfvars


### Dockerfile

O `Dockerfile` na raiz do projeto define a configuração do contêiner Docker. Ele especifica a imagem base, as dependências e os comandos necessários para construir a imagem Docker.

### Pasta `IaC`

A pasta `IaC` contém arquivos relacionados à infraestrutura como código utilizando o Terraform:

- **`main.tf`**: Define os recursos principais da infraestrutura, como grupos de recursos, redes virtuais e máquinas virtuais no Azure.
- **`providers.tf`**: Configura o provedor de infraestrutura para o Azure (`azurerm`).
- **`terraform.tfvars`**: Contém valores específicos para variáveis definidas no `main.tf`. Use este arquivo para configurar informações sensíveis e específicas do ambiente.

## Configuração

### Pré-requisitos

- **Docker**: Certifique-se de que o Docker esteja instalado e em execução. [Instruções de instalação do Docker](https://docs.docker.com/get-docker/).
- **Terraform**: Certifique-se de que o Terraform esteja instalado. [Instruções de instalação do Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- **Conta Azure**: Uma conta no Azure com permissões para criar recursos como grupos de recursos, redes, máquinas virtuais, etc.

### Construindo a Imagem Docker

Para construir a imagem Docker, execute o seguinte comando na raiz do projeto:

```bash
docker build -t giovaninexus-image .

```

### Executando o Contêiner Docker

Execute o comando abaixo para criar o contêiner Docker:

```bash
docker run -dit --name giovaninexus-container -v ./IaC:/iac giovaninexus-image /bin/bash
```

No Windows, você deve substituir ```./IaC``` pelo caminho completo da pasta. Por exemplo: ```C:\SeuCaminho\IaC.```

### Verifique a Versão do Terraform

Dentro do contêiner Docker, verifique a versão do Terraform com:

```bash
terraform version
```

### Execute as Instruções Abaixo Dentro do Contêiner Docker

#### 1. Instale o Azure CLI

Referência: [Instalação do Azure CLI para Linux](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)

#### Para baixar e instalar a ferramenta de linha de comando do Azure CLI, execute:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

#### Para atualizar a versão do Azure CLI (se necessário), execute:

```bash
az upgrade
```

#### Para efetuar login no Azure, execute:

```bash
az login
```
### 2. Deploy

Inicialize o Terraform:

```bash
terraform init
```

Valide a configuração do Terraform:

```bash
terraform validate
```

Planeje as mudanças e salve o plano:

```bash
terraform plan -out giovaninexus.tfplan
```

Gere o gráfico de recursos:

```bash
terraform graph
```
(Visualize o gráfico em webgraphviz.com)

Aplique as mudanças para criar ou atualizar os recursos no Azure:

```bash
terraform apply giovaninexus.tfplan
```

Para destruir os recursos criados:
```bash
terraform destroy
```

## Utilização do Docker

Para este projeto, o Docker foi integrado ao ambiente Linux (Ubuntu) para otimizar o desenvolvimento e assegurar um ambiente consistente e eficiente. Utilizando contêineres Docker, conseguimos garantir a portabilidade dos aplicativos, facilitando a configuração e o gerenciamento de dependências.