# Monitoring

## cAdvisor

cAdvisor is an Agent included in every kubelet and thus installed on every node. It collects measurements of the containers running on the node as well as on the node itself. 

**Hint**
For the following urls you need the ip address of the node you want to look at. If you are using minikube you get it via

```
minikube ip
```

The following urls are useful for looking at cAdvisor directly:

```
http://<node-ip>:4194/
```

for the cAdvisor interface. And:

```
http://<node-ip>:4194/metrics
```

to retrieve the metrics in Prometheus format. This can be useful when you want to scrape node data directly from prometheus without going via Heapster.

## Heapster

Heapster is itself a pod that collects the measurements of all cAdvisor instances in your cluster. When you are using minikube you can enable it using:

```
minikube addons enable heapster
```

Heapster provides it's data again using the prometheus metrics format. As the addon does not provide an externally available service you have to login to the diagnose-pod ( see [../README.md](../README.md) ):

```
kubectl exec -ti diagnose-... sh
```

Inside that container you can get the monitoring data using:

```
curl heapster.kube-system/metrics
```

When heapster is active you can see performance information on the Kubernetes dashboard and you can also use the top command at the commandline:

```
kubectl top node
kubectl top pod
```

## Grafana dashboard

Where cAdvisor and Heapster work pretty much the same in most Kubernetes installations all further monitoring tools differ very often. It is usual to use a combination of Prometheus or Influx DB as timeseries database and Grafana as dashboard. 

Minikube comes with a influx/grafana combination. You can open the dashboard using:

```
minikube -n kube-system service monitoring-grafana
``` 