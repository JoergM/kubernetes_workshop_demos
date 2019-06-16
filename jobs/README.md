# Jobs

## One time job

Jobs are Pods that run only a certain amount of time and complete. Think of certain batch jobs. 
The Job-Definition is comparable to the replication set for non finishing pods. The file [single_job.yaml](single_job.yaml) contains the definition of a job that just sleeps for 10 seconds and then quits. Start it using

```
kubectl apply -f single_job.yaml
```

Watch the job running and finishing using:

```
kubectl get pods
```

After it is finished you can take a look at the result e.g. in the log.

```
kubectl logs sleeper-...
```

A finished job will stay around in your pod list unless you delete it manually using:

```
kubectl delete job sleeper
```

## Regular jobs using cron expressions

Cron Jobs are basically a level above Jobs like Deployments are above Replication Sets. So Cron Jobs are starting new Jobs on a given time pattern. The File [cron_job.yaml](cron_job.yaml) contains an example that is starting the sleeper job from above once every minute. Start it by using:

```
kubectl apply -f cron_job.yaml
```

You might have to wait a minute until the job starts. This file is configured to only keep the latest Job in your history. 

If you want to remove the cronjob use:

```
kubectl delete cronjob sleeper
```