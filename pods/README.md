# Pods

## Creating a pod using the imperative commands

There are multiple ways to interact with the API. The most common will be to use the command `kubectl`. Using this command there are also several ways to start things inside Kubernetes. In the first example we will start a container containing the webserver nginx using a single commandline, also called an imperative command:

```
kubectl run nginx --image nginx
```

This actually created a deployment, that started the pod. We concentrate on the started pod. Deployments are described [here](../deployments/README.md). 
You can see this container running by typing on the commandline:

```
kubectl get pods
``` 

You can also use the dashboard to take a look at the pod.

The pod can be deleted by:

```
kubectl delete deployment nginx
```

## Creating a pod using declarative files

Everything Kubernetes API Object can also be described in a declarative file. A declarative file for an nginx pod can be found at [nginx.yaml](nginx.yaml).

To apply it to the kubernetes cluster use:

```
kubectl apply -f nginx.yaml
``` 

## Multiple Containers per Pod

Multiple Containers in a pod share the filesystem and the network address. All containers will run on the same cluster node. There are a number of patterns how this can be used. The following examples are already using services so that you can see the effects. Services are described [here](../services/README.md) 

### Init-Container

Init containers are run before the service containers are started. There can be multiple of them but the example only shows one. 

In our example we are starting an example container, that changes the content of the website shown by the nginx server started later on. See the full definition in [init_nginx.yaml](init_nginx.yaml). To start it use:

```
kubectl apply -f init_nginx.yaml
``` 

This file also creates a service so you can see the results of the init in your browser. If you have not read about [services](../services/README.md) yet, ignore this and just use the following to see the result:

```
minikube service nginx
``` 

### Sidecar

[TODO]
