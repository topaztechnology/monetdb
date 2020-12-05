# Supported tags and respective `Dockerfile` links
* `latest` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/master/Dockerfile) - the latest release
* `11.37.11` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/11.37.11/Dockerfile) - release based on MonetDB 11.37.11 sources
* `11.35.19` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/11.35.19/Dockerfile) - release based on MonetDB 11.35.19 sources
* `11.33.3` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/11.33.3/Dockerfile) - release based on MonetDB 11.33.3 sources
* `11.31.13` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/11.31.13/Dockerfile) - release based on MonetDB 11.31.13 sources
* `11.31.11` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/11.31.11/Dockerfile) - release based on MonetDB 11.31.11 sources
* `11.27.5` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/11.27.5/Dockerfile) - release based on MonetDB 11.27.5 sources

# Overview

A MonetDB image built from sources on top of an Alpine base image, which allows creation of a dbfarm and a database on startup.

# How to use this image

`docker run -e 'MONET_DATABASE=docker' -e 'MONETDB_PASSWORD=docker' -p 50000:50000 -d topaztechnology/monetdb:latest`

# Environment variables

* **MONET_DBFARM** : the path to the Monet dbfarm, see [here](https://www.monetdb.org/Documentation/monetdbd) for more details. Defaults to `/var/lib/monetdb/dbfarm`.
* **MONET_DATABASE** : the name of the Monet database to be created.
* **MONETDB_PASSWORD** : the password for the `monetdb` user. Defaults to `monetdb`
