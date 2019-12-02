# Authentication

There are multiple ways to authenticate to a Kubernetes Cluster. This Demo will use three different ways:

- From inside a Pod using the provided service account credentials
- From the outside using credentials of a newly defined service account
- From the outside via kubectl using a certificate


## Using a service account token inside a pod

To try this method log in to the diagnose container using:

```
kubectl exec -ti diagnose-... s
```

(diagnose-... is the complete name of the pod found via shell completion or `kubectl get pods`)

Every pod in kubernetes will get service account credentials injected at a well-known location which is `/var/run/secrets/kubernetes.io/serviceaccount/`. When you list this directory you will find a certificate, a file containing the namespace this pod runs in and a token to access the API. We export the last into an environment variable:

```
export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
```

Now the API can be accessed with curl like this:

```
curl --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
--header "Authorization: Bearer $TOKEN" \
--url https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT_HTTPS/api/
```

With the argument "--cacert" curl gets will be able to validate the https certificate. The header contains the token and is used to identify to the API Server. The Url contains a few more environment variables (KUBERNETES_SERVICE_HOST and KUBERNETES_SERVICE_PORT_HTTPS). These contain the relevant adress of the API server inside the cluster and will also be injected into containers.

The service account itself is not allowed to do much. If you try to get information about namespaces you will get a message that this action is forbidden:   

```
curl --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
--header "Authorization: Bearer $TOKEN" \
--url https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT_HTTPS/api/v1/namespaces
```

In the next chapter (creating a service account) we will add more rights to a service account. The same method could be used here. In order to do a rolebinding you would need to know the name of the service account. This can be found using:

```
kubectl get pod diagnose-... -o jsonpath={.spec.serviceAccount}
```

## Creating and using a service account token from outside the cluster

Accessing the api of a minikube server can be done using:

```
curl -k https://$(minikube ip):8443/api
```

We ignore the certificate validation for this example. If you try this you will get a status code 403 forbidden telling you that User 'system:anonymous' can not get the path /api.

To authorize we can create a new service account and use its token to authorize against the API:

```
kubectl create serviceaccount foo
export TOKEN_NAME=$(kubectl get serviceaccount foo -o=jsonpath="{.secrets[0].name}")
export TOKEN=$(kubectl get secret $TOKEN_NAME -o=jsonpath={.data.token}|base64 -D)
curl -k --header "Authorization: Bearer $TOKEN" https://$(minikube ip):8443/api
```

First a service account named foo is created. Then 'kubectl get' is used with jsonpath to extract the name of the token secret. In the next step this token is extracted into an environment variable called TOKEN. Finally this TOKEN is used as a header to make the same curl command as above. This time the result is a listing of API versions. But this service account is also not allowed to do more, like listing namespaces. Try:

```
curl -k --header "Authorization: Bearer $TOKEN" https://$(minikube ip):8443/api/v1/namespaces
```

With the following command you can assign the admin role to the service account:

```
kubectl create clusterrolebinding --clusterrole=cluster-admin --serviceaccount=default:foo foo-binding
```

Of course don't use this in any production system to grant rights to a service account. This service account can now do anything on this cluster. 

## Creating a new User

Wahrscheinlich Shell Skript schreiben, dass die Schritte macht. Dieses gut dokumentieren und dann in der Demo zeigen. Steps hier beschreiben. 

https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b

Ziel sollte allerdings eine neue kubeconfig sein.

Zeigen, dass der neue Nutzer nix kann und auf den RBAC Teil verweisen.
