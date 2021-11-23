# Helm

[Helm](https://helm.sh/) is a package manager for Kubernetes that allows to quickly install applications on Kubernetes clusters either by using available packages or by creating packages from your own applications.

## Installation

### Helm 

You need to install the Helm binary on your local computer. Please follow the instructions on the website:

https://helm.sh/docs/intro/install/

On a Mac you would probably use Homebrew like this:

```
brew install helm
```

## Searching for charts

You can use the included search to search artifact hub using:

```
helm search hub ...
```

This will usually lead to a large number of results. It is probably easier to use the web search at:

https://artifacthub.io/ 

## Adding a repo and installing a package

In this example we are installing the kube-prometheus-stack (https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack). 

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install promstack prometheus-community/kube-prometheus-stack
```

### Taking a look at the results

Assuming you are using minikube open grafana using:

```
minikube service promstack-grafana 
```

The login to the grafana dashboard is: `admin/prom-operator`

Now browse the readymade dashboards using the search icon in the left toolbar of Grafana.


### Listing all installed charts

```
helm list
```

### Deleting the chart

```
helm delete kube-prometheus-stack
``` 

## Getting more information about a chart

To take a detailed look at a chart you can fetch it locally using:

```
helm pull --untar prometheus-community/kube-prometheus-stack
```

You will know have a local directory called `kube-prometheus-stack` which contains the full chart. Take a look at it to get a feeling for the structure of a chart. 

For many use cases the most important file is values.yaml at the top level of this directory. This gives a good overview of the
configurable values of the chart. 
