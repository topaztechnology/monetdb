# Supported tags and respective `Dockerfile` links

* `latest` [(Dockerfile)](https://github.com/topaztechnology/monetdb/blob/master/Dockerfile)

| Tag        | Dockerfile                                                                        |
|------------|-----------------------------------------------------------------------------------|
| `11.45.13` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.45.13/Dockerfile) |
| `11.45.11` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.45.11/Dockerfile) |
| `11.45.7`  | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.45.7/Dockerfile)  |
| `11.43.21` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.43.21/Dockerfile) |
| `11.43.13` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.43.13/Dockerfile) |
| `11.41.21` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.41.21/Dockerfile) |
| `11.39.17` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.39.17/Dockerfile) |
| `11.37.11` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.37.11/Dockerfile) |
| `11.35.19` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.35.19/Dockerfile) |
| `11.33.3`  | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.33.3/Dockerfile)  |
| `11.31.13` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.31.13/Dockerfile) |
| `11.31.11` | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.31.11/Dockerfile) |
| `11.27.5`  | [Dockerfile](https://github.com/topaztechnology/monetdb/blob/11.27.5/Dockerfile)  |

# Overview

A MonetDB image built from sources on top of an Alpine base image, for both amd64 and arm64 architectures. It allows creation of a dbfarm and a database on startup.

# How to use this image

`docker run -e 'MONET_DATABASE=docker' -e 'MONETDB_PASSWORD=docker' -p 50000:50000 -d topaztechnology/monetdb:latest`

# Environment variables

* **MONET_DBFARM** : the path to the Monet dbfarm, see [here](https://www.monetdb.org/Documentation/monetdbd) for more details. Defaults to `/var/lib/monetdb/dbfarm`.
* **MONET_DATABASE** : the name of the Monet database to be created.
* **MONETDB_PASSWORD** : the password for the `monetdb` user. Defaults to `monetdb`
