# Helm

[Helm](https://helm.sh/) is a package manager for Kubernetes that allows to quickly install applications on Kubernetes clusters either by using available packages or by creating packages from your own applications.

## Installation

### Helm client 

You need to install the Helm binary on your local computer. Please follow the instructions on the website:

https://docs.helm.sh/using_helm/#installing-helm

On a Mac you would probably use Homebrew like this:

```
brew install kubernetes-helm
```

### Server component (Tiller)

Helm also needs a component in the cluster called tiller. In the most simple case this will be installed by using:

```
helm init
```

You need to have a Kubernetes cluster configured already. 

## Searching for charts

To find charts which you can install from the central repository use:

```
helm search
```

Without any parameter this lists all charts available.

## Handling charts

### Installing

The following example installs the wordpress chart with some values as defined in [wordpress_values.yaml](wordpress_values.yaml)

```
helm install -f wordpress_values.yaml --name wordpress stable/wordpress
```

Take a look at the dashboard to see what has been installed with this one command. There are:

- Deployments for a mariaDB for persistence and the Wordpress installation itself
- Persistent Volumes for Wordpress and MariaDB
- Services
- and an Ingress that publishes the Blog under wordpress.local

When installing this on minikube you have to add a line to your /etc/hosts like this

```
192.168.99.100  wordpress.local
```

You can know reach the blog using under the url [http://wordpress.local](http://wordpress.local).

Also try the admin interface:[http://wordpress.local/admin](http://wordpress.local/admin). Login data is as defined in the values file [wordpress_values.yaml](wordpress_values.yaml). 

### Listing all installed charts

```
helm list
```

### Deleting the chart

```
helm delete --purge wordpress
``` 

## Getting more information about a chart

### Prefetching a chart

To take a detailed look at a chart you can fetch it locally using:

```
helm fetch --untar stable/owncloud
```

You will know have a local directory called `owncloud` which contains the full chart. Take a look at it to get a feeling for the structure of a chart. 

For many use cases the most important file is values.yaml at the top level of this directory. This gives a good overview of the
configurable values of the chart. 

### Running Helm in Debug mode

It is a good idea to take a look at whats going to be installed, by running the following first:

```
helm install stable/owncloud --dry-run --debug
```

This lists all yaml files that will be applied by installing this chart. It already replaces all variable values.
