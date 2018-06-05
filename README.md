# Kubernetes Demos 

This repository contains the demos used at certain Workshops about Kubernetes.

It is grouped by the different abstractions and concepts used in Kubernetes.
Each directory contains its own README to explain how to use it. 
The following table gives an overview of the content: 

| Directory                                                                    | Content                                               |
| ---------------------------------------------------------------------------- | ----------------------------------------------------- |
| [pods](pods/README.md)                                                       | Basics of Pods                                        |
| [deployments](deployments/README.md)                                         | Deploying Pods                                        |
| [services](services/README.md)                                               | Services to access pods                               |
| [configuration](configuration/README.md)                                     | Store configuration and secrets and apply it to pods  |
| [ingress](ingress/README.md)                                                 | Organize access to services from the outside world    |
| [jobs](jobs/README.md)                                                       | Running pods regularly                                |
| [persistent_volumes](persistent_volumes/README.md)                           | Storing data in a cluster                             |
| [stateful_sets](stateful_sets/README.md)                                     | Allow Pods to carry state                             |
| [namespaces_and_service_accounts](namespaces_and_service_accounts/README.md) | Splitting a cluster in namespaces and organize access |

## Requirements to run the demos

### The kubernetes cluster

To run the demos you need a Kubernetes cluster. An easy way to run it on a local machine is
using minikube. Please follow the instructions on their website to install it on your local machine:

https://kubernetes.io/docs/tasks/tools/install-minikube/

In the examples we will use minikube to explain specific setups that might be necessary.

### Dashboard

To see the results of your actions it can be useful to take a look at the kubernetes dashboard. If you are using minikube
it is installed and activated by default. You can watch it using the following command:

```
minikube dashboard
``` 

### The diagnose pod

For some demos it is necessary to connect to a pod that runs inside the cluster. This is e.g. necessary when you want to test network connections that are not visible outside the cluster. The Kubernetes configuration in [diagnose.yaml](diagnose.yaml) defines a pod that does nothing and has a certain number of tools already installed. Install this container in the cluster using:

```
kubectl apply -f diagnose.yaml
```

You can open a shell inside this container using:

```
kubectl exec -ti <diagnose-...> sh
```

Where <diagnose-...> is the name of the pod that you can either find using shell completion (if installed) or by listing all pods using:

```
kubectl get pods
```
