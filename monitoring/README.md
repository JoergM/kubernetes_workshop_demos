# Monitoring

## Enable Metrics Server

You need to enable the metrics server in order to use metrics and any connected service or command. If you are using minikube you are doning this by enabling the addon:

```
minikube addons enable metrics-server
```

## Accessing the metrics API directly

The Metrics API is not intended to be used directly. Use kubectl top (see below) instead. But if you want to access it you can still do it like this:

API Overview:

 ```
 kubectl get --raw /apis/metrics.k8s.io/v1beta1/ |jq
 ```

List all Nodes where metrics are available

```
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes |jq
```

Get Data for a specific Node:

```
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/minikube |jq
```
This might be useful if you want to extract e.g. the CPU usage of a node with a tool like jq:

```
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/minikube |jq .usage.cpu
```

## Using kubectl top 

When metrics-server is active you can see performance information on the Kubernetes dashboard and you can also use the top command at the commandline:

```
kubectl top node
kubectl top pod
```

## Kubernetes dashboard

You can install the kubernetes dashboard in minikube as addon using:

```
minikube addons enable dashboard
```

Start the dashboard using:

```
minikube dashboard
```