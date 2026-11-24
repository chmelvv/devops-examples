run k8s cluster
aws eks update-kubeconfig --name devops-eks-cluster --region eu-north-1 --profile aws
kubectl apply -f app/deployment.yaml -f app/service.yaml
kubectl create namespace monitoring

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

 https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack - Prometheus + Grafana + k8s manifests

helm install prom-stack prometheus-community/kube-prometheus-stack --namespace monitoring

https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/#create-a-customresourcedefinition




Visit https://github.com/prometheus-operator/kube-prometheus for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.

Для доступу в Прометеус
kubectl port-forward svc/prom-stack-kube-prometheus-prometheus 9090:9090 -n monitoring

Приклади метрик:
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) 
    node_cpu_seconds_total
    node_cpu_seconds_total{mode="idle"}
    node_cpu_seconds_total{mode="idle"}[5m]
    rate(node_cpu_seconds_total{mode="idle"}[5m])
    avg by (pod) ()
    avg by (pod) (rate(node_cpu_seconds_total{mode="idle"}[5m]))
    avg by (pod) (rate(node_cpu_seconds_total{mode="idle"}[5m]))*100
    100 - avg by (pod) (rate(node_cpu_seconds_total{mode="idle"}[5m]))*100

Моніторинг веб-серверу:
Вбудована статистика в Nginx, в кастомному форматі
kubectl exec -it  myapp-deployment-6bf9bbb49b-bhg2l  -- curl http://localhost/stub_status

Приклади:
nginx_connections_active
rate(nginx_http_requests_total[1m])

kubectl get endpointslice -l kubernetes.io/service-name=myapp-service 

# Grafana
kube-prometheus-stack has been installed. Check its status by running:
  kubectl --namespace monitoring get pods -l "release=prom-stack"

Get Grafana 'admin' user password by running:

  kubectl --namespace monitoring get secrets prom-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

  [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((kubectl --namespace monitoring get secrets prom-stack-grafana -o jsonpath='{.data.admin-password}')))
  7pVLemFJGDj9A0T1Q2MTcmMAlURdnpVdZCgnsf5T

Access Grafana local instance:

  export POD_NAME=$(kubectl --namespace monitoring get pod -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=prom-stack" -oname)

  kubectl --namespace monitoring port-forward $POD_NAME 3000
  kubectl --namespace monitoring port-forward prom-stack-grafana-cf4fb9775-m8g5h  3000                                 