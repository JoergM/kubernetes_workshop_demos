# Deployments

## Watching deployments

In order to observe the results of different deployment commands it is recommended to use a second terminal which runs the following command:

```
watch -n 1 kubectl get pods
```

This shows changes on deployed pods every 1 second. It might be necessary to install the command watch using your package management of choice (especially on Mac).

## Scaling with deployments

Deployments allow to specify how many instances of a certain pod are created. One example is prepared in the file [5_nginx.yaml](5_nginx.yaml). It scales an nginx based container to five instances. Apply it with:

```
kubectl apply -f 5_nginx.yaml
```

How the loadbalancing between those instances works is described under [services](../services/README.md).

**Experiment 1**

Try to kill one pod. Find the name by using:

```
kubectl get pods
```

And kill it using:

```
kubectl delete pod <name>
```

You will see that it is recreated fast.

**Experiment 2**

Change the number of pods back to 1. Edit `5_nginx.yaml` to change the number of replicas and apply with

```
kubectl apply -f 5_nginx.yaml
```

Alternatively use the scale command to scale the pods manually:

```
kubectl scale deployment nginx --replicas=1
```

## Updating versions

Deployments are also used to update pods to new container versions. 

### Rolling Update

In a rolling update containers are updated without downtime but with the old and the new
version online at the same time. 

The Example is include in [rolling_update_nginx.yaml](rolling_update_nginx.yaml). This changes the version of deployed nginx containers.
To see the update you should have applied the file [5_nginx.yaml](5_nginx.yaml) from the [deployments-section](../deployments/README.md).

It is also recommended to have a watch on the current pods (see above).

Apply the new version using:

```
kubectl apply -f rolling_update_nginx.yaml
```

### Recreate

Recreate stops all old versions before it starts containers in the new version. So there is only one version of the pods online. But there will be downtime. 

Take a look at [recreate_update_nginx.yaml](recreate_update_nginx.yaml) 

Apply it with:

``` 
kubectl apply -f recreate_update_nginx.yaml
```
