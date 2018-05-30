#!/bin/sh

# create a configMap for the startpage
kubectl create configmap content --from-file=www/
