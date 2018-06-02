# Configuration

## Configuration as Environment Variables

There are several ways to inject environment variables into containers. The configuration-file [env_config.yaml](env_config.yaml) demonstrates two of them. Apply the config using:

```
kubectl apply -f env_config.yaml
```

**Note**

If you had the nginx containers running before, you will see a rolling update of all instances. Watch it using `kubectl get pods`.

After the pods have restarted connect to one or more of them using:

```
kubectl exec -ti nginx-... sh
```

Find the complete name of the pod by using `kubectl get pods`. If you have shell completion installed for kubectl it might be enogh to press tab after `nginx`.

Inside the container try echoing the injected environment variables:

```
# echo $VIA_CONFIGMAP
From Configmap
# echo $VIA_SPEC
From Spec
```

## Configuration as Files or directories

In more complex scenarios you can store complete directories as configuration and mount them into a pod.

In this example we have a website stored in a directory [www](www/) which will be mounted into a pod as the source for 
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