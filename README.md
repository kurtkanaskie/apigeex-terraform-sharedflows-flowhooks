# Shared Flows and Flow Hooks via Terraform

## Quickstart
Clone this repository.

```
gcloud auth application-default login
terraform init
./package.sh # Update all zips from source
terraform plan -var='project_id=apigeex-org-name' -var='env=test'
terraform plan -var='project_id=apigeex-org-name' -var='env=test'
```

## Overview

[Apigee Terraform Modules](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/apigee_sharedflow)

Directory structure
```
src
	sf-name
		sharedflowbundle
			policies
				policy.xml
			sharedflows
				default.xml
			sf-name.xml
		sf-name.zip
```

**Process for each shared flow**
1. Make changes to the local files: `src/sf-name/sharedflowbundle/*`
   1. cd src/sf-name
   1. zip -r sf-name.zip sharedflowbundle
   1. cd -
1. terraform plan -var='project_id=apigeex-org-name' -var='env=test'
1. terraform apply -var='project_id=apigeex-org-name' -var='env=test'

Update all zips after multiple edits using `package.sh`
```
for sf in `ls src`
do
	cd src/$sf
	rm $sf.zip
	zip -r $sf.zip sharedflowbundle
	cd -
done
```

## Example Shared Flows Overview
```
tf-cors-any-v1
tf-log-cloud-logging-sc-v1 # used by individual proxies in PostClientFlow, uses variables set by tf-log-set-values-v1
tf-log-set-values-v1

--> tf-pre-proxy-v1
	tf-cors-any-v1
	tf-log-set-values-v1

	--> tf-pre-target-v1
		tf-log-set-values-v1

	<-- tf-post-target-v1
		tf-log-set-values-v1

<-- tf-post-proxy-v1
	tf-log-set-values-v1
```

### Source
```
tree .
.
├── HOW_TO.txt
├── apigeex-org-name.tfvars
├── main.tf
├── src
│   ├── tf-cors-any-v1
│   │   ├── sharedflowbundle
│   │   │   ├── policies
│   │   │   │   └── CORS-any.xml
│   │   │   ├── sharedflows
│   │   │   │   └── default.xml
│   │   │   └── tf-cors-any-v1.xml
│   │   └── tf-cors-any-v1.zip
│   ├── tf-log-cloud-logging-sc-v1
│   │   ├── sharedflowbundle
│   │   │   ├── policies
│   │   │   │   └── SC-log-cloud-logging.xml
│   │   │   ├── sharedflows
│   │   │   │   └── default.xml
│   │   │   └── tf-log-cloud-logging-sc-v1.xml
│   │   └── tf-log-cloud-logging-sc-v1.zip
│   ├── tf-log-set-values-v1
│   │   ├── sharedflowbundle
│   │   │   ├── policies
│   │   │   │   ├── JS-set-log-values.xml
│   │   │   │   └── KV-log-config.xml
│   │   │   ├── resources
│   │   │   │   └── jsc
│   │   │   │       └── JS-set-log-values.js
│   │   │   ├── sharedflows
│   │   │   │   └── default.xml
│   │   │   └── tf-log-set-values-v1.xml
│   │   └── tf-log-set-values-v1.zip
│   ├── tf-post-proxy-v1
│   │   ├── sharedflowbundle
│   │   │   ├── policies
│   │   │   │   └── FC-tf-log-set-values-v1.xml
│   │   │   ├── sharedflows
│   │   │   │   └── default.xml
│   │   │   └── tf-post-proxy-v1.xml
│   │   └── tf-post-proxy-v1.zip
│   ├── tf-post-target-v1
│   │   ├── sharedflowbundle
│   │   │   ├── policies
│   │   │   │   └── FC-tf-log-set-values-v1.xml
│   │   │   ├── sharedflows
│   │   │   │   └── default.xml
│   │   │   └── tf-post-target-v1.xml
│   │   └── tf-post-target-v1.zip
│   ├── tf-pre-proxy-v1
│   │   ├── sharedflowbundle
│   │   │   ├── policies
│   │   │   │   ├── FC-tf-cors-any-v1.xml
│   │   │   │   └── FC-tf-log-set-values-v1.xml
│   │   │   ├── sharedflows
│   │   │   │   └── default.xml
│   │   │   └── tf-pre-proxy-v1.xml
│   │   └── tf-pre-proxy-v1.zip
│   └── tf-pre-target-v1
│       ├── sharedflowbundle
│       │   ├── policies
│       │   │   └── FC-tf-log-set-values-v1.xml
│       │   ├── sharedflows
│       │   │   └── default.xml
│       │   └── tf-pre-target-v1.xml
│       └── tf-pre-target-v1.zip
├── terraform.tfstate
└── variables.tf
```

## Issues

1. 403s?

    gcloud auth application-default login

2. How to use for multiple envs and run for each seperately?

    Using Terraform for proxies / shared flows is not really a good use case for Terraform.

    This results in the shared flows being undeployed from test. Perhaps I need seperate deployment resources for each environment.

    ```
    terraform plan -var='project_id=apigeex-org-name' -var='env=test'
    terraform apply -var='project_id=apigeex-org-name' -var='env=test'
    ```
3. Race conditions with deployments and assignment to Flow Hook.

    On full build frrom scratch, assigning the SF to the FH may fail because the SF is not depoloyed.

	Just run again.

4. Race conditions using terraform destroy.
    ```
    terraform plan -destroy -var='project_id=apigeex-org-name' -var='env=test'
    terraform apply -destroy -var='project_id=apigeex-org-name' -var='env=test'
    ```
	Just run again.