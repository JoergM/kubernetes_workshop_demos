# Configuration

## Configuration as Environment Variables

[TODO]

## Configuration as Files or directories

In more complex scenarios you can store complete directories as configuration and mount them into a pod.

In this example we have a website stored in a directory `www` which will be mounted into a pod as the source for 
an nginx server. In order to store the directory as a configuration into the cluster we use a script that itself calls kubectl in an imperative way.

```
./create_config.sh
```

You can see the configuration by looking it up at the kubernetes dashboard or by querying it using the kubectl command:

```
kubectl get configmap
kubectl describe configmap content
```
 
The kubernetes configuration in [config_nginx.yaml](config_nginx.yaml) mounts the stored configuration data into the pods. To apply it use:

```
kubectl apply -f config_nginx.yaml 
```

You can see the resulting website by opening a browser pointing to the service. For minikube use the following command:

```
minikube service nginx
```