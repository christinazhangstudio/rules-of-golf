#!/bin/bash

echo "getting all internal error logs from service..."

RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
RESET='\e[0m'  # Reset to default color

if [ -z "$1" ]; then
  echo "Run 'kubectl get deployment' to set the app= value to 'kubectl get pods' from."
fi

# I got app.kubernetes.io/instance from the label of the pod, since app= didn't work.
# e.g. I ran kubectl describe pod <pod-name> -n <namespace>

for pod in $(kubectl get pods -l app.kubernetes.io/instance=$1 -o jsonpath='{.items[*].metadata.name}'); do
    echo -e "${YELLOW}Checking logs from $pod:"
    #kubectl logs $pod | grep "internal"

    log_lines=$(kubectl logs $pod)

    # fetch the logs and filter for "internal"
    internal_logs=$(kubectl logs $pod | grep "internal")

    # find the line number of the last occurrence of "internal"
    last_internal_line=$(echo "$log_lines" | grep -n "internal" | tail -n 1 | cut -d: -f1)

    # if there are any "internal" logs, print the last one
    if [ ! -z "$internal_logs" ]; then
        echo -e "${RED}Found 'internal' log for $pod, getting last log:"
        #echo "$internal_logs" | tail -n 1

        start_line=$((last_internal_line - 5))
        end_line=$((last_internal_line + 5))

        echo -e "${RESET}Logs before and after the last 'internal' log for pod $pod"
        echo "$log_lines" | sed -n "${start_line},${end_line}p"
    fi

done
