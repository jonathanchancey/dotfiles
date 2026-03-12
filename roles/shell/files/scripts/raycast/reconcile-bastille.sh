#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reconcile Bastille
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔄

# Documentation:
# @raycast.author jonathanchancey
# @raycast.authorURL https://raycast.com/jonathanchancey

flux --context=bastille reconcile source git flux-system
flux --context=bastille reconcile ks bastille-apps
