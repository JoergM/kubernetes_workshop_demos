# Authentication

## Basic Auth

wahrscheinlich nicht für minikube.
Dazu müsste ein API Server parameter beim Start übergeben werden und die Datei muss auf dem Server hinterlegt werden. 

## Certificates

Wahrscheinlich Shell Skript schreiben, dass die Schritte macht. Dieses gut dokumentieren und dann in der Demo zeigen. Steps hier beschreiben. 

https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b

Ziel sollte allerdings eine neue kubeconfig sein.

Zeigen, dass der neue Nutzer nix kann und auf den RBAC Teil verweisen.

## Service Account Token

Alternativ

Zugriff auf die API ohne Token:

curl -k https://$(minikube ip):8443/api

Führt zu forbidden.

Zugriff mit Serviceaccount:

kubectl create serviceaccount foo
export TOKEN_NAME=$(kubectl get sa foo -o=jsonpath="{.secrets[0].name}")
export TOKEN=$(kubectl get secret $TOKEN_NAME -o=jsonpath={.data.token})

curl --insecure --header "Authorization: Bearer $TOKEN" https://$(minikube ip):8443/api

führt zu unauthorized. Verweis auf RBAC

TODO Minimale Rolle, damit sichtbar wird, dass es der Nutzer ist.

Trotzdem evt. Demo aus dem Diagnose Container.