.PHONY: infra destroy init cluster
SSH_KEY ?= $(HOME)/.ssh/id_rsa
MASTERS ?= 1
WORKERS ?= 2

infra:
	terraform init terraform/
	terraform apply -var masters=$(MASTERS) -var workers=$(WORKERS) terraform/

destroy:
	terraform destroy terraform/

init:
	pipenv init --three && pipenv install -r kubespray/requirements.txt

cluster:
	pipenv run ansible playbook -i inventory/inventory.ini kubespray/cluster.yml -v -b --private-key=$(SSH_KEY)
	