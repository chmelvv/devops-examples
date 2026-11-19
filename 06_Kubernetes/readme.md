1) Code for k8s cluster under virtualbox
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/tree/master/kubeadm-clusters/virtualbox 

2) VSCode + estensions:
   - Kubernetes extension by Microsoft + 
   - Helm extension
3)  скопіювати вміст файлу /etc/kubernetes/admin.conf  з  контролер-ноди на свій локальний комп'ютер (у папку ~/.kube/config).

5.  one pod
Discover k8s:
kubectl cluster-info
kubectl get all
kubectl get pods
kubectl get pods -o wide
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


02 pod and  ReplicaSet

 kubectl port-forward rs/www-replicaset 8080:80
 kubectl delete replicaset www-replicaset

03 Service

04 Deployment
kubectl rollout status deployment/whoami-deployment

05 Ingress
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

06. Helm

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
