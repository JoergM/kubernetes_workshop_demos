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

The example below requires a hostname in your ingress definition it is recommended to e.g. put this Ip address and a name into your `/etc/hosts` by adding a line like this:

```
192.168.99.100  minikube
```

(where 192.168.99.100 would be the result of `minikube ip`)


## Ingress example

The setup of this example includes multiple config files:

- [nginx_ingress.yaml](nginx_ingress.yaml) contains a deployment and service for an nginx webserver
- [httpd_ingress.yaml](httpd_ingress.yaml) contains a deployment and service for an apache based server
- [ingresses.yaml](ingresses.yaml) contains the ingress definitions for both servers

To apply all those configurations use:

```
kubectl apply -f nginx_ingress.yaml 
kubectl apply -f httpd_ingress.yaml 
kubectl apply -f ingresses.yaml 
```

Open your browser and point to [http://minikube/nginx](http://minikube/nginx) to see the answer of the nginx service and to 
[http://minikube/httpd](http://minikube/httpd) to see the answer of the Apache service.