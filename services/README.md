# Services

## Making pods available via service

Multiple pods can be available under a single address which is called a service. An example definition of pods with a service is included in the file `service_5_nginx.yaml`. It starts five instances of an nginx pod and defines a service pointing to them. Start it using: 

```
kubectl apply -f service_5_nginx.yaml
```

When using minikube you can point your browser at the service endpoint by calling:

```
minikube service nginx
```

On other platforms you would need to access the port 80 on one of the worker nodes. 

### Discovery of the service inside the cluster

To see how the service is available inside the cluster please use the diagnose container described in the [main-README](../README.md).

Connect to the container using:

```
kubectl exec -ti diagnose-... sh
```

Where <diagnose-...> is the name of the pod that you can either find using shell completion (if installed) or by listing all pods using:

```
kubectl get pods
```

Inside the container use the following command to query the service:

```
nslookup nginx
``` 

The result will look something like this:

```
Server:		10.96.0.10
Address:	10.96.0.10#53

Name:	nginx.default.svc.cluster.local
Address: 10.96.243.175
```

Every service has an IP address, that does not change even if the underlying pods change. There is also an DNS entry inside the cluster that allows to query a service. It has the format `service_name.namespace.svc.cluster.local`. 

You can get an answer from the webserver by entering:

```
curl nginx
``` 

## A second service pointing to the same pods

Pods can be exposed via multiple services. Here we define a second service for the nginx pods, this time using the imparative commandline syntax:

```
kubectl expose deployment nginx --name webserver --port 80 --type NodePort
```

The loose coupeling of services and pods is an important feature needed to implement various types of rollout strategies, such as blue green or canary.

**Experiment**

Query this service using the diagnose pod.

## A service to an external endpoint

Services do not need to point to pods. They can also point to external resources. This is an easy way to integrate e.g. an external database with the kubernetes cluster.

You can find an example setup in [external_service.yaml](external_service.yaml). This creates a CNAME entry to the external DNS name. Apply it by using:

```
kubectl apply -f external_service.yaml
```

You can again test it by using the diagnose pod. Inside it enter:

```
nslookup example
```

which will result in something like:

```
Server:		10.96.0.10
Address:	10.96.0.10#53

example.default.svc.cluster.local	canonical name = www.example.com.
Name:	www.example.com
Address: 93.184.216.34
Name:	www.example.com
Address: 2606:2800:220:1:248:1893:25c8:1946
```
