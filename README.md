# What is inception ?
This exercise is designed to introduce you to the fundamentals of Docker and help you build a small infrastructure using containers. We'll be setting up a basic architecture with several services, allowing you to get hands-on experience with Docker concepts and configuration.
## Mandatory Part

The requirements are:

- Each Docker image must have the same name as its corresponding service.
- Each service must run in a dedicated container.
- The containers must be built either from the penultimate stable version of Alpine or Debian.
- The student must write their own Dockerfiles, one per service, and call them in the docker-compose.yml - file using the Makefile.
- The student is not allowed to pull ready-made Docker images or use services such as DockerHub (except for - Alpine/Debian).

The student must set up the following:

-  Docker container with NGINX that uses TLSv1.2 or TLSv1.3 only.
-  Docker container with WordPress + php-fpm (installed and configured) without NGINX.
-  Docker container with MariaDB without NGINX.
-  volume for the WordPress database.
-  second volume for the WordPress website files.
-  Docker network to establish the connection between the containers.

The containers must restart in case of a crash. The student is advised to read about how daemons work and whether it's recommended to use certain "hacky" patches.

The WordPress database must have two users, one of which is the administrator. The administrator's username cannot contain "admin", "Admin", "administrator", or "Administrator".

The volumes will be available in the /home/login/data folder of the host machine using Docker, where login is the student's login.

The student must configure their domain name to point to their local IP address. The domain name must be login.42.fr, where login is the student's login.

The student is prohibited from using the latest tag, storing passwords in Dockerfiles, and using "hacky" patches like tail -f, bash, sleep infinity, or while true. Environment variables must be used, and it is recommended to use a .env file to store them.

The NGINX container must be the only entry point into the infrastructure via port 443 using the TLSv1.2 or TLSv1.3 protocol.

## Bonus Part

For this project, the bonus part is aimed to be simple. The main requirement is that a Dockerfile must be written for each extra service, so that each one will run inside its own container and have a dedicated volume if necessary.

The bonus list includes the following tasks:
- Set up Redis cache for your WordPress website: Properly manage the cache for the WordPress website by setting up a Redis container.
- Set up an FTP server container: The FTP server container should point to the volume of your WordPress website.
- Create a simple static website: Create a simple static website in a language of your choice, excluding PHP. This could be a showcase site, a resume site, or any other type of simple static website.
- Set up Adminer: Set up the Adminer tool, which is a lightweight alternative to phpMyAdmin for managing databases.
- Set up a service of your choice: Set up an additional service of your own choice that you think would be useful. During the defense, you will have to justify your choice of this additional service.

# Getting Started

To complete this exercise, you will need to have a virtual machine set up, as specified in the general guidelines. All the required configuration files should be placed in the srcs folder, and a Makefile should be created at the root of the directory to automate the setup process.

Remember, the focus of this exercise is to help you understand the basics of Docker and its application in a simple infrastructure setup. Don't hesitate to refer to the documentation and ask for help if you encounter any difficulties along the way.

Good luck with your "Inception" project!

#  Docker

**Definitions** : An open-source platform that automates the deployment and management of applications within lightweight, isolated containers. These containers package applications and their dependencies into standardized units, ensuring consistent performance across different computing environments.

**Key Components:**

- Docker Engine: Builds and runs containers.
- Docker Hub: Cloud-based service for sharing and distributing container images.
**Key Features and Benefits:**

Portability: Containers can be deployed on any system running Docker, ensuring consistency across environments.
- Isolation: Containers encapsulate applications and their dependencies, preventing interference.
- Efficiency: Containers are lightweight, share the host system's kernel, and offer faster startup times with reduced resource overhead compared to traditional virtual machines.
- Scalability: Easily scale applications by creating multiple container instances to handle increased workload.
- Version Control: Manage and version container images, allowing for easy tracking of changes and rollbacks.

### How Docker Works ?

Namespaces and control groups are two key Linux kernel features that Docker (and other containerization technologies) leverage to provide isolation and resource management for containers.

**Linux namespaces**

Linux namespaces provide process-level isolation by creating separate instances of global system resources for each container, allowing them to have their own isolated view of resources like process IDs, network interfaces, file systems, and inter-process communication. This separation prevents containers from interfering with each other and the host system.
Namespaces provide isolation by creating separate instances of global system resources for each container. - This allows containers to have their own isolated view of:
- Process IDs (PID): Each container has its own process ID space.
- Network Interfaces: Containers have their own network interfaces and can have separate IP addresses.
- File Systems: Containers can have isolated file systems, independent of the host.
- Inter-process Communication (IPC): Containers have their own IPC mechanisms, preventing interference.
- User IDs (UID): User and group IDs are isolated within containers.
- Mount Points: Each container can have its own mount points for file systems.

Namespaces ensure containers are isolated from each other and the host system, preventing interference and ensuring security.

**Control groups (cgroups)**

Control groups (cgroups) enable fine-grained resource allocation and management by limiting and prioritizing resources like CPU, memory, disk I/O, and network bandwidth for containers. This ensures predictable and controlled access to resources, preventing any container from monopolizing resources and affecting others.

**PID1**

The first process executed in an operating system, typically the parent of all other processes. Key characteristics and responsibilities include:

- Init Process: First user-space process, responsible for initializing system resources and managing system startup and shutdown.
- Process Lifecycle Management: Reaps orphaned processes and ensures proper termination and cleanup.
- Signal Handling: Manages system signals (e.g., SIGTERM, SIGKILL) for orderly system shutdown.
- Service Management: Often implemented as a specialized process manager (e.g., systemd, SysV init) to manage system services, dependencies, and provide features like monitoring and logging.
- System Recovery: Restarts critical services, handles system crashes, and initiates cleanup and repair processes.
- Process Hierarchy: Acts as the ultimate ancestor of all processes, providing a hierarchical structure for process management.

### Docker Engine / Daemon

Also known as Docker Daemon, Docker Engine is the core of the Docker platform for managing containers.

Docker Daemon: Background process on the host that manages containers, handling execution, image, network, and storage management.

Docker CLI: Command-Line Interface to interact with Docker Daemon, controlling container lifecycle, images, networks, volumes, and configurations.

Container Runtime: Uses Docker Containerd by default for container isolation and execution, with support for other runtimes like Docker runc.

Docker Images: Templates for creating containers, built from Dockerfiles. Images can be pulled from Docker Hub or pushed to private registries.

Networking: Provides various network drivers (bridge, overlay, host) for connecting containers and exposing services.

Storage: Manages container storage with different drivers for local filesystems and remote storage solutions.

### Docker Volumes

Volumes in Docker provide persistent storage for containers, separate from the container's filesystem. They are used to share and persist data between containers and the host system.

Docker supports various types of volumes:

- Named Volumes: Managed by Docker, easier to manage and backup.
- Bind Mounts: Links container path to host path, useful for development.
- TMPFS Volumes: Stored in the host memory, suitable for temporary data.

Usage: Volumes are used to:

- Persist data beyond the container's lifecycle.
- Share data between containers or between containers and the host.
- Store configuration files, databases, and other persistent data.

Offers:

- Improved data persistence and sharing.
- Flexibility in managing data separate from containers.
- Integration with Docker Compose and orchestration tools for managing complex deployments.

### Docker Networking

Docker offers several networking options for container communication and external connectivity:

- Bridge Networking: Default network named "bridge" connects containers on the same host. Containers use IP addresses for communication and can be accessed by name or IP.

- Host Networking: Containers share the host's network stack, useful for performance or when accessing host ports directly.

- Overlay Networking: Spans multiple Docker hosts in a swarm cluster, enabling seamless communication across hosts.

- MacVLAN Networking: Assigns MAC and IP addresses directly to containers, making them appear as separate physical devices on the network.

- Custom Networks: Create isolated networks with specific configurations like IP ranges and gateways. Containers communicate via container names.

- Service Discovery and DNS: Built-in DNS resolves container names within user-defined networks, simplifying inter-container connectivity.

### Docker Build Time Vs Run Time

**Docker Build Time:**

- Purpose: During Docker build time, Docker creates images from Dockerfiles. This process involves downloading base images, executing commands specified in the Dockerfile to configure the environment, install dependencies, and package the application.
- Actions: Docker builds images layer by layer. Each instruction in the Dockerfile creates a new layer in the image. Layers are cached to optimize subsequent builds, speeding up the process if changes are minimal.
- Commands: Common Docker build commands include `docker build -t <image-name>` . to build an image from the current directory's Dockerfile and `docker-compose build` for Docker Compose projects.

**Docker Runtime:**

- Purpose: Docker runtime refers to the period when containers created from Docker images are running and executing applications.
- Execution: Containers run in isolated environments created by Docker Engine. They leverage the host operating system's kernel but are otherwise independent, providing consistent behavior across different environments.
- Management: Docker runtime allows scaling, monitoring, and managing containers using Docker CLI commands like docker run, docker stop, docker restart, and orchestration tools such as Docker Swarm or Kubernetes for large-scale deployments.
- Features: Runtime includes features like network management, resource allocation via cgroups, and namespace isolation for processes.

## Docker Compose

A tool for defining and managing multi-container applications using a declarative YAML file (docker-compose.yaml).

- Services: Defined components of the application, each configured with details like image, environment variables, ports, and volumes.

- Networking: Automatically creates a default network for inter-service communication. Custom networks can isolate or configure connectivity between services.

- Volumes: Manages persistent data storage by defining and mounting volumes to containers, ensuring data persistence across container lifecycles.

- Environment Variables: Sets environment variables for services, allowing dynamic configuration of containerized applications.

- Dependencies: Defines service dependencies to ensure correct startup order based on dependencies between services or resources.

- Scaling: Easily scales services horizontally by specifying the number of replicas, enabling multiple instances of a service.

- CLI: Provides commands (docker-compose up, docker-compose down, docker-compose ps) to manage the application's containers from the command line.

# DOCKER VS VIRTUAL MACHINES

## Architecture

**VMs:** Virtual machines emulate an entire physical computer, including hardware and an operating system (OS), using a hypervisor on the host machine. Each VM runs its own OS instance and applications are installed and executed within this isolated environment.

**Containers:** Containers share the host machine's OS kernel and only package the application and its dependencies. They run as isolated processes on the host OS, leveraging lightweight virtualization techniques. This approach makes containers more lightweight and efficient compared to VMs.

## Resource Usage

**VMs:** Each VM requires its own OS installation, which consumes significant resources (memory, CPU, storage). VMs allocate resources upfront, even if they are not fully utilized.

**Containers:** Share the host OS and kernel, leading to smaller resource footprints. They utilize resources more efficiently since they only include the application and necessary dependencies. Containers can dynamically allocate resources based on demand, optimizing resource utilization.

## Startup Time
**VMs:** Boot an entire OS, which typically results in longer startup times (minutes).

**Containers:** Start almost instantly (seconds) as they leverage the host OS and kernel. Containers only need to launch the application within the container, avoiding the overhead of booting a separate OS.

## Isolation
**VMs:** Provide strong isolation since each VM runs its own OS instance, kernel, and resources. This isolation is beneficial for security and ensures that applications in one VM cannot affect others.

Containers: Although they share the host OS, containers use kernel features like namespaces and control groups to provide process-level isolation. Each container has its own filesystem, network interfaces, process space, and resource allocations, ensuring that applications running inside containers are isolated from each other.

## Portability
**Containers:** Highly portable due to their lightweight nature and encapsulation of the application and dependencies into a single package. Docker containers can run consistently across different environments with Docker installed, regardless of the underlying host OS or infrastructure.

**VMs:** Less portable compared to containers as they require specific hypervisors compatible with the host machine's architecture. Moving VMs between different environments can be more complex due to differences in hypervisor configurations.

# How does Docker communicates with the host operating system ?

Docker communicates with the host operating system's kernel differently depending on whether it's running on macOS, Linux, or Windows. Here’s an overview of how Docker interacts with the kernel on each platform:

## Docker on macOS
1. Docker Desktop: On macOS, Docker uses Docker Desktop, which includes a lightweight virtual machine (VM) running Linux (called the Docker Desktop VM) that hosts Docker containers. This VM is managed by the Docker Desktop application.

2. Communication with Kernel:

    - Linux VM: Docker containers on macOS run inside this Linux VM. Docker communicates with the Linux kernel within the VM using standard Linux kernel interfaces (syscalls).
    - File System Mounts: File system mounts from macOS to the Docker containers are handled by a shared directory between the macOS host and the Docker Desktop VM.

3. Performance: Docker on macOS may have slightly reduced performance compared to Linux due to the overhead of running containers within a virtualized environment.

## Docker on Linux
1. Native Kernel: On Linux, Docker containers run natively on the host's Linux kernel. There is no additional virtualization layer (as in macOS or Windows).

2. Communication with Kernel:

- Direct Kernel Access: Docker directly interacts with the Linux kernel through system calls (syscalls) to manage namespaces, control groups (cgroups), and other kernel features for process isolation and resource management.
- Performance: Docker containers on Linux typically have optimal performance since they leverage the host's native kernel without additional virtualization overhead.
## Docker on Windows
1. Windows Containers: Docker on Windows supports running both Windows containers (using Windows Server Core or Nano Server as the base image) and Linux containers (using a Hyper-V Linux VM).

2. Communication with Kernel:

    - Windows Containers: For Windows containers, Docker interacts with the Windows kernel using the Windows API. Windows containers share the kernel of the host operating system.
    - Linux Containers: When running Linux containers on Windows, Docker uses a Hyper-V Linux VM (Moby Linux VM) similar to Docker on macOS. Docker communicates with the Linux kernel within this VM.

3. Performance: Windows containers may have slightly reduced performance compared to Linux containers due to the differences in kernel architecture and the overhead of the Hyper-V virtualization layer for Linux containers.

**In Summary :**

- Mac: Docker uses a Linux VM (Docker Desktop VM) to host containers, communicating with the Linux kernel within the VM.
- Linux: Docker containers run directly on the host's Linux kernel, leveraging native kernel interfaces for optimal performance.
- Windows: Docker supports both Windows and Linux containers. For Linux containers, Docker uses a Hyper-V Linux VM, while Windows containers interact directly with the Windows kernel.