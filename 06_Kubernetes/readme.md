* Code for k8s cluster under virtualbox

https://github.com/kodekloudhub/certified-kubernetes-administrator-course/tree/master/kubeadm-clusters/virtualbox 
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/kubeadm-clusters/generic/04-node-setup.md 


* VSCode + estensions:

   - Kubernetes extension by Microsoft + 

   - Helm extension

*  copy   /etc/kubernetes/admin.conf  from k8s control plane to your local machine ( ~/.kube/config) to have default config

## Network addresses

| Layer | Address or CIDR | Notes |
| --- | --- | --- |
| Windows host-only adapter | `192.168.56.1/24` | Host address on the private Vagrant network; separate from the laptop's Wi-Fi/LAN IP |
| Control-plane node | `192.168.56.10` | Kubernetes node IP |
| Worker 1 node | `192.168.56.11` | Kubernetes node IP |
| Worker 2 node | `192.168.56.12` | Kubernetes node IP |
| Pod network | `10.244.0.0/16` | Flannel network for pod addresses |
| Example pod IP | `10.244.2.3` | `whoami-pod` on worker 2 when last observed; pod IPs can change |

Use `kubectl get nodes -o wide` to see current node IPs and `kubectl get pods -A -o wide` to see current pod IPs.

# 01  one pod
(You can set shorter alias: 

   e.g. for power shell: 

   Set-Alias k kubectl
)

Discover k8s:

kubectl cluster-info

kubectl get all

kubectl get pods

kubectl get pods -o wide

For deeper pod's investifation: 

   kubectl describe pod <name>

kubectl get pods -A

kubectl get nodes

kubectl get nodes -o wide

kubectl describe node <name>

kubectl get services

kubectl get deployments

 Apply changes:

 kubectl apply -f .\pod.yaml

 kubectl get pods

 kubectl logs whoami-pod

 kubectl port-forward whoami-pod 8080:80



#  02 pod and  ReplicaSet

 kubectl port-forward rs/www-replicaset 8080:80

 kubectl delete replicaset www-replicaset

# 03 Service

# 04 Deployment
kubectl rollout status deployment/whoami-deployment

# 05 Ingress
0) to investigate:  
   curl   "https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/baremetal/deploy.yaml" -o ./deploy.yaml 
1) kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/baremetal/deploy.yaml

kubectl get svc -n ingress-nginx
kubectl get nodes -o wide

2) add 
   192.168.31.108 my-web-server
to /etc/hosts

http://my-web-server:<port>

kubectl.exe delete ValidatingWebhookConfiguration ingress-nginx-admission

http://my-web-server:32437/site-one
http://my-web-server:32437/site-two 

# 06. Helm

helm template my-web-sites ./ 
helm install  my-web-sites ./
helm upgrade my-web-sites ./ --set ingress.host="my-new-domain" --reuse-values
helm get values my-web-sites
helm upgrade  my-web-sites ./ -f changes.yaml
helm list
helm list -A
helm status my-web-sites
<edit values>
helm upgrade my-web-sites ./
helm history my-web-sites
helm rollback helm rollback 1
helm uninstall my-web-sites

helm create myChart
