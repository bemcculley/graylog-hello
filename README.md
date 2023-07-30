# graylog-hello
Graylog Hello World project

### Step 1: Installation and initial setup ###

Make sure the following tools are installed:

AWS CLI - v2.13.5  
Terraform - v1.5.4  
kubectl - v1.27.4  
flux - v2.0.1  


#### awscli configuration ####

- Run `aws configure --profile graylog-eks`
- Enter access key information and set default region to `us-east-1`
- Generate ec2 access keys `aws ec2 create-key-pair --key-name graylog-keypair --query 'KeyMaterial' --output text --profile graylog-eks > ./graylog-eks-key.pem`
- Set permissions on private key `chmod 400 graylog-eks-key.pem`

#### Terraform configuration ####
- If running on an m1 mac and using tfenv be sure to specify `TFENV_ARCH=arm64`
- Change to the terraform directory `cd ./terraform`
- Run `terraform init`
- Run `AWS_PROFILE=graylog-eks terraform plan -out graylog-eks-plan`
- Run `AWS_PROFILE=graylog-eks terraform apply graylog-eks-plan`

### Kubectl config ###
- Install or update kubectl if needed: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/
- Update kubeconfig with eks cluster context `aws eks --region us-east-1 update-kubeconfig --name graylog-eks-cluster --profile graylog-eks`
- Test access: `kubectl get ns`
  ```NAME              STATUS   AGE
  default           Active   19m
  kube-node-lease   Active   19m
  kube-public       Active   19m
  kube-system       Active   19m

### Flux bootstrap ###

- Setup credentials:
    - `export GITHUB_TOKEN=<token>`
    - `export GITHUB_USER=<username>`

### Repo structure diagram
```
terraform

flux
├── bootstrap-scripts
│
├── apps
│   ├── base
│   └── production
│
├── infrastructure
│   └── controllers
│   
└── cluster
    └── graylog-eks