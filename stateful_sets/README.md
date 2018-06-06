# Stateful sets


The example contains two nginx servers with a persistent storage each. Take a look at the file [stateful_nginx.yaml](stateful_nginx.yaml). Apply it using:

```
kubectl apply -f stateful_nginx.yaml
```

When you list the pods in the cluster you will find something like this:

```
# kubectl get pods
NAME                        READY     STATUS    RESTARTS   AGE
diagnose-78d958b9db-gcs6r   1/1       Running   14         85d
nginx-0                     1/1       Running   0          1m
nginx-1                     1/1       Running   0          1m
nginx-5ccd64769-gn9bn       1/1       Running   0          4h
```

If you had run the earlier nginx examples you probably have one or more entries like the last one. It is not recommended to use the same name for deployments and stateful sets. Here this demonstrates, that both exist in parallel. You can see that there is a simpler name for the actual pod. Those names always stay the same. If you delete nginx-0 with:

```
kubectl delete pod nginx-0  
```

the stateful set will recreate a pod with the same name. This is even true for the ip address. This allows applications create clusters but rely on single nodes to be always reachable under the same name.

## Stateful sets and persistent volume claims

The stateful set definition also contained a template for creating a persistent volume claim. Take a look at the created claims using the dashboard or:

```
kubectl get pvc
```

Those PVCs are also guaranteed to be connected again to the pod with the same name should that be terminated.

**Experiment**

Try to scale up the number of replicas of the stateful nginx.