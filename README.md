Wilhelm GraphDB - Visualizing Wiktionary in Graph Database
==========================================================

![Python Version Badge]
[![Neo4J DB version badge]][Neo4J Docker version]
[![GitHub workflow status badge][GitHub workflow status badge]][GitHub workflow status URL]
[![Apache License Badge]][Apache License, Version 2.0]

__wilhelm-graphdb__ is a Docker image that hosts language data in graph databases, such as Neo4J. It is part of the
efforts that [scales project Wilhelm](https://github.com/QubitPi/wilhelm?tab=readme-ov-file#why-do-i-decide-to-scale-project-wilhelm)

Development
-----------

### Data Sources

- [wiktionary-data](https://github.com/QubitPi/wiktionary-data)
- [Verbformen](./verbformen) (For German)

### Docker

This section discusses the details of how Docker image is made. It is recommended to go through this process in a remote
machine such as AWS EC2 because it takes more than a day to load data completely.

#### VM Setup

The setup installs 2 packages:

- Docker Engine
- Python3 `virtualenv`

```console
./docker-setup.sh
```

Then log out of the remote machine and back in.

> [!CAUTION]
> 
> The Python 3.10+ should be installed separately. If the remote server is Ubuntu 22.04 or above, this should have
> automatically been satisfied

#### Creating Docker Image

Prerequisite:

- Docker
- Python 3.10


```console
git clone git@github.com:QubitPi/wilhelm-graphdb.git
cd wilhelm-graphdb
```

Creating the following environment variables:

- __DOCKERHUB_USERNAME__: The value for the `-u` argument as used in the [Docker login command]
- __DOCKERHUB_TOKEN__: The value for the `-p` argument as used in the [Docker login command]

> [!CAUTION]
>
> The script would overwrite the following environment variables with the specified values if already defined locally:
>
> - __NEO4J_URI__: `neo4j://localhost:7687`
> - __NEO4J_USERNAME__: `neo4j`
>
> The loading takes several hours, please be patient

```console
nohup ./docker-load.sh > load.log &
```

- The loading log can be found at `./load.log`
- The database UI can now be accessed at http://localhost:7474 which shows how much data has been loaded

```console
docker cp neo4j-loader:/data .
docker build -t jack20191124/wilhelm-graphdb:neo4j .

docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD
docker push jack20191124/wilhelm-graphdb:neo4j
```

### Troubleshooting

#### Reinstalling `wilhelm_python_sdk`

```console
pip3 uninstall wilhelm_python_sdk
pip3 install --upgrade --force-reinstall wilhelm-python-sdk
```



License
-------

The use and distribution terms for [wilhelm-graphdb]() are covered by the [Apache License, Version 2.0].

[Apache License Badge]: https://img.shields.io/badge/Apache%202.0-F25910.svg?style=for-the-badge&logo=Apache&logoColor=white
[Apache License, Version 2.0]: https://www.apache.org/licenses/LICENSE-2.0

[Docker login command]: https://docker.qubitpi.org//reference/cli/docker/login/#options

[GitHub workflow status badge]: https://img.shields.io/github/actions/workflow/status/QubitPi/wilhelm-graphdb/ci-cd.yaml?branch=master&style=for-the-badge&logo=github&logoColor=white&label=CI/CD
[GitHub workflow status URL]: https://github.com/QubitPi/wilhelm-graphdb/actions/workflows/ci-cd.yaml

[Neo4J DB version badge]: https://img.shields.io/badge/Neo4J-5.24--enterprise-4581C3.svg?style=for-the-badge&logo=neo4j&logoColor=white
[Neo4J Docker version]: https://hub.docker.com/_/neo4j/tags?name=5.24-enterprise

[Python Version Badge]: https://img.shields.io/badge/Python-3.10-FFD845?labelColor=498ABC&style=for-the-badge&logo=python&logoColor=white
