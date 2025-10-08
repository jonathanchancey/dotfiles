#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reconcile Academy
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔄

# Documentation:
# @raycast.author jonathanchancey
# @raycast.authorURL https://raycast.com/jonathanchancey

flux --context=academy reconcile -n flux-system source git academy
flux --context=academy reconcile ks -n flux-system academy-cluster
