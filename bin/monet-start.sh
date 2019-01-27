#!/bin/bash

echo "Starting MonetDB server farm at ${MONET_DBFARM}..."
exec monetdbd start -n ${MONET_DBFARM}
