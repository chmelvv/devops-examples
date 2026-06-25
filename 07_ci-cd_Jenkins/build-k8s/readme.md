aws eks --region eu-west-2 update-kubeconfig --name devops-eks-cluster --profile aws

//Zero nodes
aws eks update-nodegroup-config \
  --cluster-name devops-eks-cluster \
  --nodegroup-name default_node_group \
  --scaling-config minSize=0,maxSize=2,desiredSize=0

  terraform destroy -auto-approve
  terraform apply -auto-approve