# jenkins-configuration-as-code-workshop-prerequisites

This project provides the prerequisites for Jenkins Configuration as Code workshop. It was tested on recent Linux and macOS platforms.

Users of Windows platform are advised to use most recent Windows 10 with Windows Subsystem for Linux or use Linux virtual machines as an alternative. See [WSL.md](WSL.md) file for more details.

## Prerequisites

- Upload your SSH public key to your [GitHub](https://github.com/) account.
- Install [Docker](https://docs.docker.com/install/#supported-platforms).
- Install [Docker Compose](https://docs.docker.com/compose/install/).

This project was tested with Docker Engine release 18.06.0+, which supports Compose file format `3.7`.

```console
$ docker version --format '{{.Server.Version}}'
19.03.11
$ docker-compose version --short
1.25.4
```

## Getting Started

- Clone this project.

- Use the commands are given in the [Makefile](Makefile).

- Get Docker Compose up and running.

```bash
make
```

### GitHub

- [Test](https://help.github.com/en/articles/testing-your-ssh-connection) your SSH connection GitHub.

### Jenkins

- Jenkins should be locally available on [http://localhost:8080](http://localhost:8080).

```bash
curl --silent --show-error --include localhost:8080 \
    | tr --delete '\r' \
    | sed --quiet --regexp-extended 's/^X-Jenkins: (.*)/\1/p'
```

```text
2.249.1
```

## Optional: Change Jenkins Administrator Password

- Run `make`. See [Makefile](Makefile) for more information.

- Get the initial uniquely generated administrator password of Nexus.

```bash
docker exec -it \
    $(docker ps --filter "name=jenkins_1" --quiet)  \
    bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"
```

- Open [http://localhost:8080](http://localhost:8080) to access Jenkins.

### Nexus

- Nexus should be locally available on [http://localhost:8081](http://localhost:8081).

```bash
curl --silent --show-error --include localhost:8081 \
    | tr --delete '\r' \
    | sed -En 's/^Server: (.*)/\1/p'
```

```text
Nexus/3.27.0-03 (OSS)
```

## Optional: Change Nexus Administrator Password

- Run `make`. See [Makefile](Makefile) for more information.

- Get the initial uniquely generated administrator password of Nexus.

```bash
docker exec -it \
    $(docker ps --filter "name=nexus" --quiet)  \
    bash -c "cat /nexus-data/admin.password && echo"
```

- Open [http://localhost:8081](http://localhost:8081) to access Nexus.

### Lightweight Directory Access Protocol (LDAP)

- The phpLDAPadmin service should be locally available on [http://localhost:8090](http://localhost:8090).

```bash
$ curl --silent --show-error --include localhost:8090 \
    | tr --delete '\r' \
    | sed -En 's/^Server: (.*)/\1/p'
```

```text
Apache
```

```bash
curl --silent --show-error --include localhost:8090 \
    | tail -n +18 \
    | sed "s/\&nbsp\;//g" \
    | xmlstarlet sel \
    -N n="http://www.w3.org/1999/xhtml" \
    -t -m "//n:div[@id='ajFOOT']" -v . -n
```

```text
1.2.5
```

Login phpLDAPadmin using the following credentials.

Login DN: `cn=admin,dc=acme,dc=local`

Password: `changeit`

Expand the `+--> dc=acme,dc=local (3)` sign on top on left pane to see the following generated LDAP users and groups.

```text
+--> dc=acme,dc=local (3)
---> cn=admin
+--> ou=Groups (4)
| ---> cn=Acme Managers
| ---> cn=Acme Servicers
| ---> cn=Acme Superusers
| ---> cn=Acme Users
| ---> Create new entry here
+--> ou=Users (4)
| ---> cn=manager
| ---> cn=service
| ---> cn=superuser
| ---> cn=user
| ---> Create new entry here
---> Create new entry here
```

If we have `ldapsearch` command available (e.g. from `openldap-clients` package on Fedora Linux), we can list the generated LDAP users and groups.

```bash
ldapsearch \
    -x \
    -h localhost:389 \
    -b "dc=acme,dc=local" \
    -s sub "objectclass=*"
```

## Summary

If all the above mentioned services are up and running, we are ready for the Jenkins Configuration as Code workshop.

## License

[GNU General Public License v3.0](LICENSE)
