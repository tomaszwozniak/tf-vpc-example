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
    mv config/backend_EXAMPLE.conf config/backend_dev.conf
    mv config/EXAMPLE.tfvars config/dev.tfvars
    ```
    
    backend contains state backend settings 
    (it's remote so S3 bucket, region and dynamodb lock table settings are required)
    
    tvfvars file contains environment and aws ssh key name
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

4. Execute plan and apply commands with var file:
    ```bash
    terraform plan -var-file=config/${env}.tfvars
    terraform apply -var-file=config/${env}.tfvars
    ```


