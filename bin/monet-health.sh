#!/bin/bash

# Try to start the database, it does not come up automatically when daemon is started
monetdb -q start ${MONET_DATABASE}

set -eo pipefail
monetdb status | tail -n +2 | grep -E "^${MONET_DATABASE}\s+R"
