terraform init
terraform plan
terraform apply

aws eks --region eu-west-2 update-kubeconfig --name devops-eks-cluster --profile aws
kubectl create namespace jenkins

//make zero nodes to save resources
# aws eks update-nodegroup-config \
#  --cluster-name devops-eks-cluster \
#  --nodegroup-name default_node_group \
#  --scaling-config minSize=0,maxSize=2,desiredSize=0


# terraform destroy -auto-approve



# add secrets
# Hashicorp Vault - to store secrets in enterprise
kubectl create secret generic jenkins-secrets --from-literal=github-username=chmelvv --from-literal=github-token=<token>  -n jenkins
kubectl create secret docker-registry dockerhub-secret --docker-username=chmelvv   --docker-password=<token>   -n jenkins

helm repo add jenkinsci https://charts.jenkins.io
helm repo update

helm install jenkins jenkinsci/jenkins -n jenkins -f jenkins-values.yaml
 # jenkins - release name
 # jenkinsci/jenkins  - repository-name/chart-name
kubectl get svc -n jenkins jenkins # find EXTERNAL-IP