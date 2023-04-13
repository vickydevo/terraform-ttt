# terraform installation
 check for terraform version 
 terraform -version
# URL TO install in the diferent platform
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
# to download provider plugins
terraform init 
# to check current status and desired status of statefile/
terraform plan  
/create resources and we to give confirmation ****yes****
terraform apply   
terraform apply -auto-approve
# NEVER USE  remove all resources which are file but content in file is not removed
terraform destroy    
terraform destroy -target resource
# export environment variables
export AWS_ACCESS_KEY_ID="AKIA24IWL4NXIFCPYSUT"
export AWS_SECRET_ACCESS_KEY="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"
export AWS_REGION="us-east-1"
# export GLOBAL environment variables
export TF_VAR_az="us-east-1e" 

# encoded error message
aws sts decode-authorization-message --encoded-message KDmmJmkLKm...iUtfAa --output text | jq '.'

