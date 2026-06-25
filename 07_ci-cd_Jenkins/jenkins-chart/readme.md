helm repo add jenkinsci https://charts.jenkins.io
helm repo update
kubectl create namespace jenkins
#add secrets
kubectl create secret generic jenkins-secrets --from-literal=github-username=chmelvv --from-literal=github-token=<PAT_TOKEN> --from-literal=dockerhub-username=chmelvv --from-literal=dockerhub-token=<DOCKERHUB_TOKEN> -n jenkins

RedHat Vault

helm install jenkins jenkinsci/jenkins -n jenkins -f jenkins-values.yaml
 # jenkins - release name
 # jenkinsci/jenkins  - repository-name/chart-name
kubectl get svc -n jenkins jenkins # find EXTERNAL-IP