# Pod security policies

## Running a privileged container

Certain commands require a container to be run in a privileged mode. One of the is `fdisk -l` which shows the partions of a machine. Try to run this command inside the diagnose container:

```
kubectl exec -ti diagnose-... sh 
fdisk -l
```

You will get an empty result because the container is not allowed to see the partions of the host it is running on. Now start the same container in privileged mode using:

```
kubectl apply -f privileged.yaml
```

Try the fdisk commando inside of that pod again:

```
kubectl exec -ti privileged-... sh 
fdisk -l
```

Now you will see the partitions of the host machine. 

## Restricting pods using pod security policies

In most production systems you probably do not want pods to be run in privileged mode. To prevent this you need to define podsecurity policies and make sure the respective admission controller is active. 

TODO


<!--
Beispiel Yaml mit priviledged Container
    - Was kann man hier demonstrieren?
    - Einfach ein Shell Container in dem ich manuell ein Kommando aufrufe?

PSP, die priviledged unterbindet

Zeigen, dass der Pod noch läuft:
    - Das ist wichtige Info. PSPs werden nicht auf vorhandene Pods angewendet

Pod löschen
Pod neu starten -> Zeigen, dass das nicht mehr geht

https://kubernetes.io/docs/concepts/policy/pod-security-policy/

META:

PSP auf default namespace/service account anwenden
Nur priviledged demonstrieren. Restliche Policies im Vortrag.
-->

