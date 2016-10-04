# wordpress-devenv

A boilerplate template for creating a simple Wordpress development environment
with Docker. It uses Apache 7.0 and MariaDB 10.1. Tested with WordPress 4.5.3.

**Note: This template creates a simple environment for quick local development.
It is not secure by any means so do not use it for public-facing solutions!**

The data in the database is persistent as it is on a Docker volume.

The Apache docroot is also a volume which is binded to `../docroot`.

`tree`:
```
.
├── wordpress-devenv
│   ├── [The files in this repo.]
└── docroot
    ├── index.php
    ├── wp-config-sample.php
    ├── wp-content
    ├── ...
    ├── [And other WordPress files.]
```

## Usage

Initiate the environment: `docker-compose up`

Apache listens on port 80, so you can simply access WordPress under:
`http://localhost`

Connecting to the database: `mysql -h 127.0.0.1 -u wordpress -pwordpress`

You can remove stopped containers and volumes (deletes the database) with:
`docker-compose rm -v`
