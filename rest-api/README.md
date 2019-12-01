# REST API

Every interaction with Kubernetes is done via the API Server. Even the kubectl commando uses the same API that is also available for other programs. This API is based on the [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) principles. 

## Basic access to the REST API

Every call to the API Server needs to be authenticated. There are several mechanisms to authenticate. More on this can be found in the demos for [Authentication](../authentication/README.md). When you have configured the kubectl CLI to use a cluster you can also use it to open a locally available proxy for connecting to the API:

```
kubectl proxy
```

This will open a proxy by default on port 8001. You can then access the API with tools like curl:

```
curl http://localhost:8001/api
```

This will give you a list of api versions available under this url. For historical reasons there are two entry urls 'api' and 'apis'. Core APIs like pods tend to be under 'api'. All modern APIs can be found under 'apis', To get a list of available APIs under 'apis' try:

```
curl http://localhost:8001/apis
```

## Manipulating namespaces via the API

As an example of using the API we are going to use namespaces. They have only a few attributes so it is easy to handle the neccessary JSON or YAML. 

### Getting information on a namespace

Getting information in an API Object is done via GET Request:

```
curl http://localhost:8001/api/v1/namespaces/default
``` 

This will result in a json description of the namespace object for default. Compare this to the result of the respective kubectl command:

```
kubectl get -o json ns default
```
The results are the same. Which is no surprise, as kubectl does just call the same API. 

If you prefer to get the results in yaml as this is the more common format in Kubernetes world just set the accept header:

```
curl -H 'accept: application/yaml' http://localhost:8001/api/v1/namespaces/default 
```

### Creating a namespace

Ressources are created using a POST request. The body will contain all necessary information to create the ressource. A ressource description of a namespace is prepared in `namespace.yaml`. To create the namespace use:

```
curl -X POST -H "content-type: application/yaml" --data-binary "@namespace.yaml" http://localhost:8001/api/v1/namespaces/ 
```

Use kubectl to get all namespaces and you will find the newly generated namespace.

```
kubectl get namespaces
```

### Changing a namespace

Changing uses the request method PUT on the object. In this example we add a label to the namespace. Take a look into labeled_namespace.yaml to see the new definition. Apply the definition using: 

```
curl -X PUT -H "content-type: application/yaml" --data-binary "@labeled_namespace.yaml" http://localhost:8001/api/v1/namespaces/api-generated-namespace
```

You can see the changes using: 

```
kubectl describe namespace api-generated-namespace
```

### Deleting a namespace

Deleting an API Object is just using the DELETE request method on the ressource URL:

```
curl -X DELETE http://localhost:8001/api/v1/namespaces/api-generated-namespace
```

Use kubectl to get all namespaces and you will see the namespace disappeared.

```
kubectl get namespaces
```

## Open API Specification

To get a specification of all available APIs in OPEN API Format use:

```
curl http://localhost:8001/openapi/v2
```

The resulting file can be loaded into tools like [Postman](https://www.getpostman.com/), [Insomnia](https://insomnia.rest/) or [Paw](https://paw.cloud/) to get an overview of the complete API.