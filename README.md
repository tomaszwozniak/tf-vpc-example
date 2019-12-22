## Example VPC with ALB, bastion and webapplication host

#### Usage: ####
1. Create state bucket and lock table **(optional)**
    
    Set proper s3_terraform_bucket and dynamodb_table in remote_state/variables.tf
    
    Then run:
    
    ```bash
    cd remote_state
    terraform init
    terraform apply
    ```

2. Create your environment settings by changing config/EXAMPLE files (replace example to your environment name)

    ```bash
    cp config/backend-EXAMPLE.conf config/backend-dev.conf
    cp config/EXAMPLE.tfvars config/dev.tfvars
    ```
    
    backend contains state backend settings 
    (it's remote so S3 bucket, region and dynamodb lock table settings are required)
    
    tvfvars file contains environment, aws ssh key name and r53 zone idg
    ```bash
    cd remote_state
    terraform init
    terraform apply
    ```

3. Initialize project:
    ```bash
    env=dev
    terraform get -update=true
    terraform init -backend-config=config/backend-${env}.conf
    ```

4. Execute commands with -var-file argument:
    ```bash
    terraform plan -var-file=config/${env}.tfvars
    terraform apply -var-file=config/${env}.tfvars
    terraform destroy -var-file=config/${env}.tfvars
    ```
