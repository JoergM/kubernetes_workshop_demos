# Ingress


## Activate ingress controller

The ingress API objects are interpreted by ingress controllers. Depending on your Kubernetes installation you have to make sure that this ingress controller is up and running. 

When using minikube to follow these examples you can activate an ingress controller using the following command:

```
minikube addons enable ingress
```

Ingresses will be made available under the ip address of the virtual machine minikube has created. This ip address can be found using:

```
minikube ip
``` 

As a number of services require a hostname in your ingress definition it is recommended to e.g. put this Ip address and a name into your `/etc/hosts` by adding a line like this:

```
192.168.99.100  minikube
```

(where 192.168.99.100 would be the result of `minikube ip`)


## Ingress example

[TODO]