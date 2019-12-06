#!/bin/sh

# Creating a directory for the generated files
AUTH_DIR=auth-data
mkdir ${AUTH_DIR}

# Creating a key using openssl
openssl genrsa -out ${AUTH_DIR}/user-key.pem 2048

# Creating a certificate sign request
openssl req -new -key ${AUTH_DIR}/user-key.pem \
    -subj "/CN=demo-user" \
    -out ${AUTH_DIR}/user.csr \

# Signing and generating the certificate using the minikube key
openssl x509 -req -in ${AUTH_DIR}/user.csr -CA ~/.minikube/ca.crt \
    -CAkey ~/.minikube/ca.key -CAcreateserial \
    -out ${AUTH_DIR}/user.crt -days 500

# Set the KUBECONFIG variable and create an empty file it wil be filled by the following commands 
export KUBECONFIG=${AUTH_DIR}/config
touch ${AUTH_DIR}/config

# Setting details of the config
kubectl config set-cluster minikube --certificate-authority=${HOME}/.minikube/ca.crt --embed-certs=true --server=https://$(minikube ip):8443 
kubectl config set-credentials demo-user --client-key=${AUTH_DIR}/user-key.pem --client-certificate=${AUTH_DIR}/user.crt --embed-certs=true 
kubectl config set-context minikube-demo-user --user demo-user --cluster minikube 
kubectl config use-context minikube-demo-user 
