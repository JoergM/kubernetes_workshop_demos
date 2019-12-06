# Role Based Access Control

To follow these examples you need to create a new user that has initially no rights. The procedure is explained [here](../advanced/authentication/README.md#creating-a-new-user-using-a-certificate). Please make sure, you are in this folder again and change your KUBECONFIG to use the newly created one:

```
export KUBECONFIG=$(pwd)/../authentication/auth-data/config
```

When you try to list pods using this configuration you will get an error:

```
kubectl get pods
```

You can find whether the current user is allowed to do a certain operation by using `kubectl config can-i` like:

```
kubectl config can-i get po
```

## Creating read-only access

This user could of course not give access rights to itself so we have to change to the default user again:

```
unset KUBECONFIG
```

Now apply the following Role and Rolebindings:

```
kubectl apply -f read-only.yaml
```

Take a look at the file to see details of the definition.

Now set the new config again and try to get information about the pods:

```
export KUBECONFIG=$(pwd)/../authentication/auth-data/config
kubectl get pods
```

Also try 
```
kubectl config can-i get po
```

To test whether you are allowed to do other operations try e.g.:

```
kubectl get namespaces
kubectl auth can-i create pod
```

## Clean up

Don't forget to reset to the default user by

```
unset KUBECONFIG
```

<!-- TODOs:
example that can also create a pod and deployment maybe using '*' for verbs 
Mention default roles like admin or cluster-admin
-->
