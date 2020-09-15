
# Windows Subsystem for Linux

The Windows Subsystem for Linux lets developers run a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly on Windows, unmodified, without the overhead of a traditional virtual machine or dualboot setup.

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
