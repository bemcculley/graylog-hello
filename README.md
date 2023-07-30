# graylog-hello
Graylog Hello World project

### Installation and initial setup ###

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
```

### URLS ###
[Weave Gitops](http://a6af14c8811704d2caf3747e3fd9eb26-116247240.us-east-1.elb.amazonaws.com:9000/applications)  
username: admin  
password: in email

[Hello World](http://ab2d37533b50f45abbb7c3a6db6a236f-1476568444.us-east-1.elb.amazonaws.com:8080)  
[Alternate Hello World](http://a7f99ccab8543414bba6c025a11a7099-1275988966.us-east-1.elb.amazonaws.com:8000) - will reflect any uri as well (eg. /healthz)
