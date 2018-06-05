# Namespaces and service accounts

## Namespaces

Namespaces are a simple way to group objects in a Kubernetes cluster. It is useful to reduce the clutter when working with the Kubernetes commands but is also the basis for a number of security mechanisms.

You can see the namespaces in your cluster using:

```
kubectl get namespaces
```

Which will usually result in something like this:

```
NAME          STATUS    AGE
default       Active    88d
kube-public   Active    88d
kube-system   Active    88d
```

`kube-public` and `kube-system` are namespaces used by Kubernetes specific services and controllers. You can see the pods running in a different namespace by using:

```
kubectl get pods -n kube-system
``` 

Most demo configurations have been applied to the default namespace so far. The configuration in [other_namespace_service.yaml](other_namespace_service.yaml) creates an nginx with a service inside another namespace. Apply it using

```
kubectl apply -f other_namespace_service.yaml 
```

To see the pods and the service use:

```
kubectl -n other get pods
kubectl -n other get services
```

To open the respective service in your browser use:

```
minikube service -n other nginx
```

**Experiment**

Log into the diagnose container in the default namespace and try to access the nginx service in the "other" namespace.
When inside the diagnose container you can use:

```
curl nginx.other
```

## Service accounts

[TODO]