# Custom Ressource Definitions (CRD)

Custom Ressource Definitions are the way to extend the Kubernetes API. They are the basis for things like Operators or Service Meshes. In this example we are creating our own extension and will use it in several ways. 

## Creating a CRD

A definition for a CRD is prepared in `crd.yaml`. Take a look at it to see how the CRD is defined and then create it via:

```
kubectl apply -f crd.yaml
```

You can see all defined CRDs using:

```
kubectl get crd
```

## Accessing a CRD using kubectl

The CRD can now be used like any other API object. You can list it using kubectl:

```
kubectl get foo
```

Of course this will not show any objects as we have not created them yet. There is a definition of a foo object in `foo.yaml`. Take a look at the file to see how it is defined then apply it using:

```
kubectl apply -f foo.yaml
```

You can see it using:

```
kubectl get foos
```

(This time we used plural) 

## Accessing a CRD using the API

With the CRD installed we can now also use the Kubernetes REST API to access the CRD. First start the proxy again:

```
kubectl proxy
```

Now you can get the CRD using:

```
curl -H "accept: application/yaml" http://localhost:8001/apis/demo.example.com/v1/foos/
```

We use the YAML version as it is more readable. If you look at the self link field you will see that the proper url contains namespace information. 

Finally delete the API Object using the API:

```
curl -X DELETE http://localhost:8001/apis/demo.example.com/v1/namespaces/default/foos/my-first-foo
```