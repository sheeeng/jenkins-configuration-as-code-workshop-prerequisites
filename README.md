# jenkins-configuration-as-code-workshop-prerequisites

This project provides the prerequisites for Jenkins Configuration as Code workshop. It was tested on recent Linux and macOS platforms. Windows platform users advised to use most recent WSL2 or use Linux virtual machines as an alternative.

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

### Windows

The following instructions are summarized from the Microsoft [Update to WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10#update-to-wsl-2) documentation and [Setting up WSL Version 2 and the Ubuntu](https://codefellows.github.io/setup-guide/windows/) guide.

- In the Search box next to the Windows Menu, type `Turn Windows Features On or Off` and hit enter.
- Enable the following features.
  - [ ] Virtual Machine Platform
  - [ ] Windows Hypervisor Platform
  - [ ] Windows Subsystem for Linux
- If you are running Windows as a Virtual Machine, enable the following features.
  - [ ] Containers
  - [ ]  Hyper-V
- Once this operation is complete, we will need to reboot the system.
- After reboot, install the `Windows Terminal` app from the [Microsoft Store](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab). After it is installed, open Windows Terminal.

- Enter the following command to set out system default to WSL 2:

```bash
wsl --set-default-version 2
```

Read the output you get from running that command. Follow the instructions thoroughly.

```text
WSL 2 requires an update to its kernel component. For information please visit https://aka.ms/wsl2kernel
```

- We must update the current WSL Kernel before we use WSL2.
- Follow the instructions from [Updating the WSL 2 Linux kernel](https://docs.microsoft.com/en-us/windows/wsl/wsl2-kernel) documentation.
- When you finish with those instructions, try running the `wsl --set-default-version 2` command again.

```text
For information on key differences with WSL 2 please visit https://aka.ms/wsl2
```

- Install the Ubuntu app from [Microsoft Store](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab). Run and setup the Ubuntu app after the installation is completed.

The following Windows system was able to run the following prerequisites.

```console
Microsoft Windows [Version 10.0.19041.388]
(c) 2020 Microsoft Corporation. All rights reserved.

C:>\systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
OS Name:                   Microsoft Windows 10 Pro for Workstations
OS Version:                10.0.19041 Build 19041

C:\>
C:\>docker --version
Docker version 19.03.12, build 48a66213fe

C:\>
C:\>docker-compose --version
docker-compose version 1.26.2, build eefe0d31

C:\>

C:\>wsl --list --verbose
  NAME                   STATE           VERSION
  Debian                 Running         2
* Ubuntu                 Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2

C:\>
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
2.235.3
```

### Nexus

- Nexus should be locally available on [http://localhost:8081](http://localhost:8081).

```bash
curl --silent --show-error --include localhost:8081 \
    | tr --delete '\r' \
    | sed -En 's/^Server: (.*)/\1/p'
```

```text
Nexus/3.25.1-04 (OSS)
```

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
