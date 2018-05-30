# Kubernetes Demos 

This repository contains the demos used at the Workshop:

"Kubernetes die abstrakte Cloud".

It is grouped by the different abstractions and concepts used in Kubernetes.
Each directory contains its own README to explain how to use it. 
The following table gives an overview of the content: 

| Directory                       | Content                                               |
| ------------------------------- | ----------------------------------------------------- |
| pods                            | Basics of Pods                                        |
| deployments                     | Deploying Pods                                        |
| service                         | Services to access pods                               |
| configuration                   | Store configuration and secrets and apply it to pods  |
| ingress                         | Organize access to services from the outside world    |
| jobs                            | Running pods regularly                                |
| persistent_volumes              | Storing data in a cluster                             |
| stateful_sets                   | Allow Pods to carry state                             |
| namespaces_and_service_accounts | Splitting a cluster in namespaces and organize access |

## Requirements to run the demos

To run the demos you need a Kubernetes cluster. An easy way to run it on a local machine is
using minikube. Please follow the instructions on their website to install it on your local machine:

https://kubernetes.io/docs/tasks/tools/install-minikube/

In the examples we will use minikube to explain specific setups that might be necessary.
