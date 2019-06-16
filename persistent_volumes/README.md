# Persistent Volumes

## Persistent Volume Claims

The persistent volume claim is the abstraction of something persistent, that can be mounted into a container. The example config file [persistent_redis.yaml](persistent_redis.yaml) defines a redis with a persistent storage. Start it with:

```
kubectl apply -f persistent_redis.yaml
```

You can see the various objects either in the dashboard or by using the respective get commands:

```
kubectl get pods
kubectl get pvc
kubectl get pv
``` 

The persistent volume is the actual instance of the Volume claim. It can be maintained manually, but in most cases there will be some sort of dynamic provisioning. If you are using minikube for this example there will be a hostpath mounted as the volume. 

### Creating some data

To see the persistence in action create some data inside the redis database. To get an redis-cli log into the pod using:

```
kubectl exec -ti redis-... redis-cli
```

where redis-... is the complete name of the redis pod. You should get a prompt and you can store a key and value like this:

```
127.0.0.1:6379> set foo bla
OK
127.0.0.1:6379> get foo
"bla"
127.0.0.1:6379>
```

Now the data is stored on the persistent volume. You can find the datafiles when logging into the redis pod by using the shell:

```
kubectl exec -ti redis-... sh
/data # ls -lsa
total 12
     4 drwxrwxrwx    2 root     root          4096 Jun  5 14:24 .
     4 drwxr-xr-x    1 root     root          4096 Jun  5 14:26 ..
     4 -rw-r--r--    1 root     root           108 Jun  5 14:46 appendonly.aof
/data #
```

### Testing the persistence

Now test, whether the data just stored survives the deletion of the pod. To test this find the redis pod and delete it, like this:

```
# kubectl get pods
NAME                        READY     STATUS    RESTARTS   AGE
redis-5ff7b8476c-clkkt      1/1       Running   0          24m
# kubectl delete pod redis-5ff7b8476c-clkkt 
pod "redis-5ff7b8476c-clkkt" deleted
```

If you now list the pods again you will find, that there is a newly created redis pod. You can now test whether the persistence worked by connecting to the redis-cli again:

```
kubectl exec -ti redis-... redis-cli
127.0.0.1:6379> get foo
"bla"
127.0.0.1:6379>
```

The data survived a complete restart of the pod which might even include a move to another Kubernetes node.

This only works when there is one replica of the redis pod. When you need to implement a cluster of pods, each with their own persistent volume then you need to look at [stateful sets](../stateful_sets/README.md)