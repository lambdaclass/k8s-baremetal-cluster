.PHONY: reset help
.DEFAULT_GOAL := help

SSH_KEY ?= $(HOME)/.ssh/id_rsa
MASTERS ?= 1
WORKERS ?= 2

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

infra: ## Initialize Terraform state and setup infrastructure
	terraform init terraform/
	terraform apply -var masters=$(MASTERS) -var workers=$(WORKERS) terraform/

destroy: ## Tear down infrastructure
	terraform destroy terraform/

init: ## Create a Python virtual environment and install Ansible
	pipenv --three && pipenv install -r kubespray/requirements.txt

cluster: ## Provision cluster with Kubespray
	pipenv run ansible-playbook -i inventory/inventory.ini cluster.yml -b --private-key=$(SSH_KEY)

reset: ## Reset cluster (removes Kubernetes)
	pipenv run ansible-playbook -i inventory/inventory.ini kubespray/reset.yml -b --private-key=$(SSH_KEY)
