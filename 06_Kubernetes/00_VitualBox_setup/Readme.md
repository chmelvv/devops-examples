# Kubernetes lab on VirtualBox

This Vagrant setup creates three Ubuntu VMs on a VirtualBox host-only network. Vagrant installs VirtualBox guest utilities, `containerd`, `kubeadm`, `kubelet`, and `kubectl` on every VM. You initialize the cluster and join the workers manually so the lab includes the `kubeadm` steps.

Each kubelet is configured to advertise its VM's host-only IP as its Kubernetes node IP, rather than the shared VirtualBox NAT address.

## Requirements

- VirtualBox and Vagrant installed on the host
- Internet access from the VMs to download packages and container images
- About 10 GB of free host RAM for the configured VMs
- Each virtual disk has a 40 GB maximum capacity but is dynamically allocated; it grows as the guest writes data rather than reserving 40 GB up front.

| VM | Role | Host-only IP | RAM | SSH port |
| --- | --- | --- | ---: | ---: |
| `k8s-cp` | Control plane | `192.168.56.10` | 4 GB | 22222 |
| `k8s-worker1` | Worker | `192.168.56.11` | 3 GB | 22223 |
| `k8s-worker2` | Worker | `192.168.56.12` | 3 GB | 22224 |

The default Kubernetes package channel is `v1.37`. Set `KUBERNETES_MINOR` before provisioning if you need another supported minor version.

## Create and prepare the VMs

Run these commands from this directory:

```powershell
vagrant up
vagrant status
```

The first run downloads the Ubuntu box and installs the container runtime and Kubernetes packages. If the VMs already exist and you changed the provisioning script, run:

```powershell
vagrant provision
```

Provisioning updates the kubelet node IP on existing VMs as well. Verify the addresses with `kubectl get nodes -o wide`; the `INTERNAL-IP` values should match the host-only IPs in the table above.

## Initialize the control plane

Connect to the control-plane VM:

```powershell
vagrant ssh k8s-cp
```

Inside that VM, initialize Kubernetes using its host-only IP:

```bash
sudo kubeadm init \
  --control-plane-endpoint=192.168.56.10:6443 \
  --apiserver-advertise-address=192.168.56.10 \
  --pod-network-cidr=10.244.0.0/16
```

Configure `kubectl` for the `vagrant` user and install Flannel networking:

```bash
mkdir -p "$HOME/.kube"
sudo cp /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u):$(id -g)" "$HOME/.kube/config"
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

## Join the worker VMs

On the control-plane VM, print a join command:

```bash
sudo kubeadm token create --print-join-command
```

Copy the printed command. Open a separate terminal for each worker:

```powershell
vagrant ssh k8s-worker1
```

```powershell
vagrant ssh k8s-worker2
```

Run the copied command with `sudo` on each worker. Then check the cluster from the control-plane VM:

```bash
kubectl get nodes -o wide
kubectl get pods -A
```

Wait for the nodes to become `Ready` before deploying workloads.

## SSH access

Vagrant manages SSH keys automatically:

```powershell
vagrant ssh k8s-cp
vagrant ssh k8s-worker1
vagrant ssh k8s-worker2
```

The Vagrantfile also forwards SSH to localhost on ports `22222`, `22223`, and `22224`. These avoid Vagrant's own SSH forwarding ports. For example, from this directory:

```powershell
ssh -i ".vagrant\machines\k8s-cp\virtualbox\private_key" -o IdentitiesOnly=yes -p 22222 vagrant@127.0.0.1
```

Use the corresponding worker port and private-key path for the workers. These forwarded ports listen only on `127.0.0.1`.

## Use kubectl from the Windows host (optional)

The simplest option is to run `kubectl` inside the control-plane VM. To use it from Windows, first copy the admin kubeconfig to the Vagrant user's home directory from the control-plane VM:

```bash
sudo cp /etc/kubernetes/admin.conf /home/vagrant/kubeconfig
sudo chown vagrant:vagrant /home/vagrant/kubeconfig
```

Then, from this directory in PowerShell, copy it to the host:

```powershell
New-Item -ItemType Directory -Force "$HOME\.kube" | Out-Null
scp -P 22222 -i ".vagrant\machines\k8s-cp\virtualbox\private_key" -o IdentitiesOnly=yes `
  vagrant@127.0.0.1:/home/vagrant/kubeconfig "$HOME\.kube\config"
$env:KUBECONFIG = "$HOME\.kube\config"
kubectl get nodes -o wide
```

This kubeconfig grants cluster-admin access. Keep it private and do not commit it to Git.

## Access applications

From the host, use `kubectl port-forward` for a simple local test:

```powershell
kubectl apply -f ..\01_one_pod\pod.yaml
kubectl port-forward pod/whoami-pod 8080:80
```

Open `http://localhost:8080`. For a NodePort service, access the node's host-only IP and the assigned NodePort, for example `http://192.168.56.10:32000`.

## Stop or remove the lab

```powershell
vagrant halt
vagrant destroy
```

`vagrant destroy` removes the VMs and their local Kubernetes state.