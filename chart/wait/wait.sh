#!/bin/bash
wait_project() {
   # interval and timeout are in seconds
   interval=5
   timeout=600
   crdname="authorizationpolicies.security.istio.io"
   jobLabel="app.kubernetes.io/name=podinfo"
   namespace=podinfo
   counter=0
   while true; do
      sleep $interval
      initJobStatus=$(kubectl get pods -l $jobLabel -n $namespace -o jsonpath='{.items[0].status.conditions[0].status}')
      echo "podinfo pods status is $initJobStatus"
      if [[ $initJobStatus == "True" ]]; then
        authcrdstatus=$(kubectl get crd $crdname -o jsonpath='{.status.conditions[0].status}')
        if [[ $authcrdstatus == "True" ]]; then
            echo "crd $crdname status is $authcrdstatus"
            break
        fi
      fi
      (( counter++ )) || true
      if [[ $((counter * interval)) -ge $timeout ]]; then
         echo "$daemonset timeout waiting $timeout seconds for creation, running describe..." 1>&2
         kubectl describe $daemonset --namespace=$namespace 1>&2
         exit 1
      fi
   done
}
