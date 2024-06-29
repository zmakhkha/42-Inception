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

# Project Structure

``` bash
ls  -l **/**

```

```
-rw-r--r--  1 zmakhkha  candidate    489 Jun 22 16:10 Makefile
-rw-r--r--  1 zmakhkha  candidate   2102 Jun 27 17:24 srcs/docker-compose.yml
-rw-r--r--  1 zmakhkha  candidate    325 Jun 26 19:37 srcs/requirements/bonus/adminer/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    138 Jun 26 19:37 srcs/requirements/bonus/ftp/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    411 Jun 26 19:37 srcs/requirements/bonus/ftp/tools/script.sh
-rw-r--r--  1 zmakhkha  candidate    445 Jun 26 19:37 srcs/requirements/bonus/portainer/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    322 Jun 26 19:37 srcs/requirements/bonus/redis/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    245 Jun 26 19:37 srcs/requirements/bonus/static/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    447 Jun 26 19:37 srcs/requirements/bonus/static/conf/index.html
-rw-r--r--  1 zmakhkha  candidate    294 Jun 27 17:24 srcs/requirements/bonus/static/conf/nginx.conf
-rw-r--r--  1 zmakhkha  candidate    388 Jun 27 17:24 srcs/requirements/mariadb/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    488 Jun 22 16:10 srcs/requirements/mariadb/tools/script.sh
-rw-r--r--  1 zmakhkha  candidate    402 Jun 22 16:10 srcs/requirements/nginx/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    608 Jun 27 17:24 srcs/requirements/nginx/conf/ngnix.conf
-rw-r--r--  1 zmakhkha  candidate    545 Jun 27 17:24 srcs/requirements/wordpress/Dockerfile
-rw-r--r--  1 zmakhkha  candidate    714 Jun 26 19:37 srcs/requirements/wordpress/tools/script.sh

srcs:
total 8
-rw-r--r--  1 zmakhkha  candidate  2102 Jun 27 17:24 docker-compose.yml
drwxr-xr-x  6 zmakhkha  candidate   204 Jun 26 19:37 requirements

srcs/requirements:
total 0
drwxr-xr-x  7 zmakhkha  candidate  238 Jun 26 19:37 bonus
drwxr-xr-x  5 zmakhkha  candidate  170 Jun 27 17:24 mariadb
drwxr-xr-x  5 zmakhkha  candidate  170 Jun 22 16:10 nginx
drwxr-xr-x  5 zmakhkha  candidate  170 Jun 27 17:24 wordpress

srcs/requirements/bonus:
total 0
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 26 19:37 adminer
drwxr-xr-x  4 zmakhkha  candidate  136 Jun 26 19:37 ftp
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 26 19:37 portainer
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 26 19:37 redis
drwxr-xr-x  4 zmakhkha  candidate  136 Jun 26 19:37 static

srcs/requirements/bonus/adminer:
total 8
-rw-r--r--  1 zmakhkha  candidate  325 Jun 26 19:37 Dockerfile

srcs/requirements/bonus/ftp:
total 8
-rw-r--r--  1 zmakhkha  candidate  138 Jun 26 19:37 Dockerfile
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 26 19:37 tools

srcs/requirements/bonus/ftp/tools:
total 8
-rw-r--r--  1 zmakhkha  candidate  411 Jun 26 19:37 script.sh

srcs/requirements/bonus/portainer:
total 8
-rw-r--r--  1 zmakhkha  candidate  445 Jun 26 19:37 Dockerfile

srcs/requirements/bonus/redis:
total 8
-rw-r--r--  1 zmakhkha  candidate  322 Jun 26 19:37 Dockerfile

srcs/requirements/bonus/static:
total 8
-rw-r--r--  1 zmakhkha  candidate  245 Jun 26 19:37 Dockerfile
drwxr-xr-x  4 zmakhkha  candidate  136 Jun 27 17:24 conf

srcs/requirements/bonus/static/conf:
total 16
-rw-r--r--  1 zmakhkha  candidate  447 Jun 26 19:37 index.html
-rw-r--r--  1 zmakhkha  candidate  294 Jun 27 17:24 nginx.conf

srcs/requirements/mariadb:
total 8
-rw-r--r--  1 zmakhkha  candidate  388 Jun 27 17:24 Dockerfile
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 22 16:10 tools

srcs/requirements/mariadb/tools:
total 8
-rw-r--r--  1 zmakhkha  candidate  488 Jun 22 16:10 script.sh

srcs/requirements/nginx:
total 8
-rw-r--r--  1 zmakhkha  candidate  402 Jun 22 16:10 Dockerfile
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 27 17:24 conf

srcs/requirements/nginx/conf:
total 8
-rw-r--r--  1 zmakhkha  candidate  608 Jun 27 17:24 ngnix.conf

srcs/requirements/wordpress:
total 8
-rw-r--r--  1 zmakhkha  candidate  545 Jun 27 17:24 Dockerfile
drwxr-xr-x  3 zmakhkha  candidate  102 Jun 26 19:37 tools

srcs/requirements/wordpress/tools:
total 8
-rw-r--r--  1 zmakhkha  candidate  714 Jun 26 19:37 script.sh

```

# Mandatory Services

## Nginx

Nginx is an open-source web server and reverse proxy renowned for its high performance, scalability, and low memory usage. It serves as a web server, handles load balancing, caching, SSL/TLS termination, and provides robust security features. Nginx is widely adopted by large-scale websites and applications due to its efficiency and versatility, Nginx propose a bunch of services at the same time :

- Web Server: Nginx efficiently serves static files (like HTML, CSS, JS) and dynamic content through integration with application servers.

- Reverse Proxy: Acts as a reverse proxy, distributing client requests to multiple backend servers, balancing loads, and ensuring high availability.

- Load Balancing: Distributes incoming traffic across servers to optimize performance and handle concurrent connections effectively.

- Caching: Stores both static and dynamic content in memory, reducing load on backend servers and improving response times.

- Security: Provides robust security features including access control, request filtering, rate limiting, and firewall capabilities to protect against web attacks.

- High Availability: Supports configurations for continuous service availability, including automatic failover mechanisms to maintain uptime even during server failures.

- SSL/TLS Termination: Handles SSL/TLS encryption and decryption, offloading this task from backend servers to enhance performance.

### Transport Layer Security (TLS)

Transport Layer Security (TLS) is a widely adopted security protocol designed to ensure privacy and data security for communications over the Internet. It encrypts communication between web applications and servers, as well as other types of communications such as email, messaging, and VoIP. Proposed by the Internet Engineering Task Force (IETF), TLS was first published in 1999, with the latest version being TLS 1.3, published in 2018.

TLS accomplishes three main tasks: encryption, authentication, and integrity.

- Encryption: Hides the data being transferred from third parties.
- Authentication: Ensures that the parties exchanging information are who they claim to be.
- Integrity: Verifies that the data has not been forged or tampered with.
### TLS vs. SSL

TLS (Transport Layer Security) evolved from SSL (Secure Sockets Layer), originally developed by Netscape. TLS version 1.0 started as SSL version 3.1 but was renamed to indicate its independence from Netscape. Despite this evolution, the terms TLS and SSL are often used interchangeably.

### TLS vs. HTTPS

HTTPS (Hypertext Transfer Protocol Secure) is the implementation of TLS encryption over the HTTP protocol. Any website using HTTPS employs TLS encryption to secure communication.

### How Does TLS Work?

A TLS connection begins with the TLS handshake between the user's device (client) and the web server. During the handshake, they:

1. Specify which version of TLS to use (e.g., TLS 1.0, 1.2, 1.3).
2. Decide on which cipher [algorithm used for encryption or decryption of data] suites to use.
3. Authenticate the server's identity using its TLS certificate.
4. Generate session keys for encrypting messages post-handshake.
5. The handshake establishes a cipher suite, specifying the algorithms and session keys for encryption. Public key cryptography allows the setting of session keys over an unencrypted channel.

Authentication involves the server proving its identity using public keys. The server’s public key, part of its TLS certificate, allows clients to verify data encrypted with the server's private key.

Encrypted and authenticated data is signed with a message authentication code (MAC) to ensure data integrity, which the recipient can verify.

#### TLS handshake

During a TLS handshake, generating session keys for encrypting messages post-handshake involves the following steps:

1. Client Hello: The client sends a "Client Hello" message to the server, specifying the TLS version, cipher suites (encryption algorithms) it supports, and a randomly generated number (client random).

2. Server Hello: The server responds with a "Server Hello" message, choosing the TLS version, a cipher suite from the list provided by the client, and another randomly generated number (server random). The server also sends its public key in the form of a digital certificate.

3. Server Certificate: The server sends its digital certificate to the client. This certificate contains the server's public key and is signed by a trusted Certificate Authority (CA). The client verifies the certificate to ensure it is authentic and that it can trust the server.

4. Client Key Exchange: The client generates a pre-master secret, a random number that will be used to create the session keys. The client encrypts the pre-master secret with the server's public key (from the server's certificate) and sends it to the server.

5. Generating the Master Secret: Both the client and the server use the pre-master secret along with the client random and server random numbers to generate the master secret. The master secret is a shared secret that both parties can use to derive the session keys.

6. Generating Session Keys: From the master secret, both the client and the server generate the session keys, which include:

    - Encryption Keys: For encrypting the data transmitted between the client and server.
    - MAC Keys: For ensuring the integrity of the data (Message Authentication Code).
    - IVs (Initialization Vectors): For certain encryption modes that require an IV.
    - Finished Messages: Both the client and server send "Finished" messages to each other, encrypted with the newly generated session keys. These messages confirm that the handshake was successful and that future communications will be encrypted.

Secure Communication: After the handshake is complete, the client and server use the session keys to encrypt and decrypt the data exchanged between them, ensuring that the communication is secure, authenticated, and maintains data integrity.

### generation of a self-signed certificate and a private key

``` bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/zmakhkha.key -out /etc/nginx/zmakhkha.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=zmakhkha.42.fr"

```

#### Explanation

* openssl: This is the command to invoke the OpenSSL tool, which is a robust, full-featured open-source toolkit implementing the Secure Sockets Layer (SSL) and Transport Layer Security (TLS) protocols.

* req: This subcommand specifies that we are using the X.509 certificate signing request (CSR) management. This command is used to create and process certificate requests.

* -x509: This option outputs a self-signed certificate instead of a certificate signing request (CSR). X.509 is a standard defining the format of public-key certificates.

* -nodes: This option tells OpenSSL to not encrypt the private key. "Nodes" stands for "no DES," meaning the private key will not be encrypted with DES (Data Encryption Standard).

* -days 365: This specifies the number of days the certificate will be valid. In this case, the certificate will be valid for 365 days.

* -newkey rsa:2048: This option generates a new certificate request and a new private key at the same time. The rsa:2048 part specifies that the RSA key should be 2048 bits long.

* -keyout /etc/nginx/zmakhkha.key: This specifies the file where the newly created private key will be saved. Here, the private key will be saved to /etc/nginx/zmakhkha.key.

* -out /etc/nginx/zmakhkha.crt: This specifies the file where the self-signed certificate will be saved. Here, the certificate will be saved to /etc/nginx/zmakhkha.crt.

* -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=zmakhkha.42.fr": This provides the subject field for the certificate in a non-interactive way. The subject includes the following fields:

C=MA: Country code (MA for Morocco).
ST=Khouribga: State or province name (Khouribga).
L=Khouribga: Locality or city (Khouribga).
O=1337: Organization name (1337).
CN=zmakhkha.42.fr: Common name, which is typically the domain name (zmakhkha.42.fr).
This command will generate a self-signed certificate and a private key for the domain zmakhkha.42.fr, valid for one year, and save them in the specified directory.
## Pulling all together
### Dockerfile

``` Dockerfile
# file : srcs/requirements/nginx/Dockerfile

# Use Debian oldstable as the base image
FROM debian:oldstable

# Update and install nginx and openssl
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install nginx -y && \
    apt-get install -y openssl

# Generate a self-signed SSL certificate for nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/zmakhkha.key -out /etc/nginx/zmakhkha.crt \
    -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=zmakhkha.42.fr"

# Copy nginx configuration file to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443 (HTTPS) to allow external connections
EXPOSE 443

# Set the command to start nginx and run it in the foreground
CMD ["nginx", "-g", "daemon off;"]
```

### nginx config

``` bash
# file : srcs/requirements/nginx/conf/ngnix.conf
worker_processes 1;  # Set the number of worker processes to 1

events {
    worker_connections 1024;  # Allow up to 1024 simultaneous connections per worker process
}

http {
    include /etc/nginx/mime.types;  # Include MIME types configuration

    server {
        listen 443 ssl;  # Listen on port 443 (HTTPS) with SSL/TLS
        server_name zmakhkha.42.fr;  # Set the server name to zmakhkha.42.fr

        ssl_certificate /etc/nginx/zmakhkha.crt;  # Path to SSL certificate
        ssl_certificate_key /etc/nginx/zmakhkha.key;  # Path to SSL certificate key

        ssl_protocols TLSv1.3;  # Use TLSv1.3 protocol
        ssl_prefer_server_ciphers off;  # Disable preferring server ciphers

        root /var/www;  # Set the root directory for requests

        location / {
            autoindex on;  # Enable directory listing if index file is absent
            index index.php index.html;  # Default index files
        }

        location ~ \.php$ {
            fastcgi_pass wordpress:9000;  # Forward PHP requests to FastCGI server on wordpress container
            include snippets/fastcgi-php.conf;  # Include FastCGI PHP configuration
        }
    }
}
```
## MariaDB

MariaDB Server is an open-source relational database management system (RDBMS) developed as a drop-in replacement for MySQL by its original creators, in response to concerns over MySQL's direction under Oracle Corporation. It aims to offer a community-driven, feature-compatible, and open alternative to MySQL.

Designed for seamless compatibility with MySQL, MariaDB supports standard SQL and provides a comprehensive set of features including ACID compliance, transactions, stored procedures, triggers, and views. This compatibility allows applications and tools developed for MySQL to work smoothly with MariaDB without requiring modifications.

### Dockerfile

``` Dockerfile

# file : srcs/requirements/mariadb/Dockerfile

FROM debian:oldstable  # Use the Debian oldstable base image

RUN apt-get update && apt-get upgrade -y \  # Update package lists and upgrade existing packages
    && apt-get install mariadb-server mariadb-client -y  # Install MariaDB Server and Client

RUN mkdir -p /var/run/mysqld && \  # Create directory for MariaDB run-time files
    chown -R mysql /var/run/mysqld && \  # Change ownership of the directory to the mysql user
    chmod -R 777 /var/run/mysqld  # Adjust permissions of the directory for mysql user

RUN sed -i "s|127.0.0.1|0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf  # Replace bind address to allow connections from any IP

COPY ./tools/script.sh /usr/script.sh  # Copy script.sh from the host to /usr/script.sh in the container
RUN chmod +x /usr/script.sh  # Make script.sh executable

CMD ["/usr/script.sh"]  # Set the script.sh as the command to run when the container starts

```

### Startup script

``` bash

# file : srcs/requirements/mariadb/tools/script.sh

#!/bin/sh

mysql_install_db  # Initialize the MariaDB data directory and create system tables
service mariadb start  # Start the MariaDB service

mysql -u root -e "DROP DATABASE IF EXISTS test;"  # Drop the 'test' database if it exists
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MDB_NAME; GRANT ALL ON $MDB_NAME.* TO '$MDB_USER'@'%' IDENTIFIED BY '$MDB_PASS';"
# Create the specified database if it doesn't exist, grant full privileges to the specified user from any host with the provided password

mysql -u root -e "FLUSH PRIVILEGES;"  # Reload the grant tables to apply changes

mysqladmin shutdown -p$MDB_PASS  # Shutdown MariaDB using the provided password for authentication

exec mysqld --user=mysql  # Start the MariaDB server process with the mysql user

```

## Wordpress

WordPress is a widely-used open-source content management system (CMS) and website creation tool, primarily written in PHP. It relies on MySQL or MariaDB databases to store and manage website content. WordPress enables users to build and maintain various types of websites, from basic blogs to sophisticated e-commerce platforms and large-scale corporate sites. Its flexibility, extensive plugin ecosystem, and user-friendly interface make it popular among both individual users and businesses looking to establish a robust online presence.

### Wordpress CLI

- Installing WordPress:

    Function: Allows downloading, installing, and configuring WordPress.
    Usage: Setup includes database configuration and site initialization.

- Managing Plugins and Themes:

    Function: Facilitates installation, activation, deactivation, update, listing, search, and deletion of plugins and themes.
    Usage: Can handle actions from WordPress.org or local files.

- Updating WordPress:

    - Function: Enables core, plugin, and theme updates.
    - Usage: Useful for managing updates across multiple sites or automating update processes.

- Configuring WordPress:

    - Function: Adjusts settings like site title, URL, admin credentials, and permalinks.
    - Usage: Provides direct access to database options without using the admin dashboard.

- Managing Users:

    - Function: Allows user management tasks such as creation, update, role assignment.
    - Usage: Efficiently handles user-related operations via command line.

- Performing Database Operations:

    - Function: Provides SQL query execution, database export/import, and other database operations.
    - Usage: Essential for handling database-related tasks directly from the command line.

- Running Maintenance Tasks:

    - Function: Executes maintenance tasks like cache clearing, database optimization, and site repair.
    - Usage: Automates routine maintenance to keep WordPress sites running smoothly.

### Dockerfile

```Dockerfile
# file : srcs/requirements/wordpress/Dockerfile

# Use the Debian oldstable image as the base
FROM debian:oldstable

# Set the working directory inside the container
WORKDIR /var/www

# Update and upgrade packages, install necessary dependencies
RUN apt update -y && apt upgrade -y \
    && apt install -y curl php-fpm php-mysql php-redis redis

# Download and install WP-CLI for managing WordPress installations
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configure PHP-FPM to listen on port 9000 instead of using a socket
RUN sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf

# Create a directory for PHP to store its runtime files
RUN mkdir -p /run/php

# Copy a script into the container's /usr directory and make it executable
COPY ./tools/script.sh /usr/script.sh
RUN chmod +x /usr/script.sh

# Specify the command to run when the container starts
CMD ["/usr/script.sh"]

```

### Startup script

``` bash
# file : srcs/requirements/wordpress/tools/script.sh

#!/bin/bash
# Shebang indicating this script should be run with Bash

# Download WordPress core files
wp core download --allow-root

# Create wp-config.php file with database configuration
wp config create --dbname=$MDB_NAME --dbuser=$MDB_USER --dbpass=$MDB_PASS --dbhost=$MDB_HOST --allow-root

# Change permissions of wp-config.php file to 777 (read, write, execute for all)
chmod 777 wp-config.php

# Install WordPress with specified site URL, title, admin credentials
wp core install --url="$URL" --title="$WP_TITLE" --admin_user="$WP_SU_USR" --admin_password="$WP_SU_PWD" --admin_email="$WP_SU_EMAIL" --allow-root

# Create a new WordPress user with specified username, email, password, and role
wp user create "$WP_USER" "$WP_MAIL" --user_pass="$WP_SEC" --role="$USER_ROLE" --allow-root

# Install and activate a specified WordPress theme
wp theme install $WP_THEME --activate --allow-root

# Update all installed plugins
wp plugin update --all --allow-root

# Install and activate the Redis Cache plugin
wp plugin install redis-cache --activate --allow-root

# Configure WordPress to use Redis for caching [Bonus Part]
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp redis enable --allow-root

# Start PHP-FPM with specified version and run it in the foreground
/usr/sbin/php-fpm7.4 -F
```

## Redis
Redis is an advanced key-value store that supports various data structures such as strings, hashes, lists, sets, and sorted sets. It operates primarily in memory but can persist data to disk, offering both high performance and data persistence. Redis is widely used as a database, cache, and message broker due to its speed, versatility, and simplicity.

Key features of Redis include:

- In-Memory Storage: Redis stores data in RAM, making it extremely fast for read and write operations. This makes it suitable for applications that require low-latency data access.

- Data Structures: Redis supports multiple data structures, including strings, hashes, lists, sets, and sorted sets. Each data type has specific operations that can be performed on it, enabling complex data manipulation and querying.

- Persistence: Although Redis is primarily in-memory, it supports different persistence options to ensure data durability. It can periodically save snapshots of the dataset to disk (snapshotting) or append each write operation to a log file (append-only file).

- Replication: Redis supports replication, allowing data to be asynchronously replicated to one or more slave Redis instances. This provides fault tolerance and scalability by distributing read operations across multiple replicas.

- Pub/Sub Messaging: Redis includes support for publish/subscribe messaging patterns. Clients can subscribe to channels and receive messages published to those channels in real-time, making Redis suitable for building real-time applications and message brokers.

- Lua Scripting: Redis allows execution of Lua scripts directly within the server, enabling atomic operations and complex data manipulation tasks that can be executed in a single round trip.

- Transactions: Redis supports transactions, allowing multiple commands to be executed sequentially as a single unit of work. This ensures atomicity and consistency for groups of related operations.

- High Performance: Due to its design and in-memory nature, Redis delivers exceptional performance for caching and data storage scenarios. It is optimized for handling millions of operations per second with low latency.

- Versatility: Redis can be used for a wide range of use cases, including caching frequently accessed data, session storage, real-time analytics, message queuing, leaderboards, and more.

Overall, Redis is valued for its simplicity, speed, and flexibility, making it a popular choice for applications requiring fast data access, caching, and real-time messaging capabilities.

### Dockerfile
``` Dockerfile
# file : srcs/requirements/bonus/redis/Dockerfile

# Use the debian:oldstable base image
FROM debian:oldstable

# Update package lists and install redis-server
RUN apt-get -y update \
    && apt install redis-server -y

# Set Redis max memory limit to 256mb in redis.conf
RUN echo "maxmemory 256mb" >> /etc/redis/redis.conf

# Set Redis eviction policy to allkeys-lru in redis.conf
RUN echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

# Comment out the bind address to allow external connections
RUN sed -i -r "s/bind 127.0.0.1/#bind 127.0.0.1/" /etc/redis/redis.conf

# Run Redis server with protected mode disabled
CMD ["redis-server", "--protected-mode", "no"]

```

## FTP Server

FTP (File Transfer Protocol):
***Overview:***
FTP is a network protocol used for transferring files between a client and a server over a TCP-based network, typically the Internet. It operates on a client-server architecture where the client initiates the connection to the server to upload or download files.

Usage:

- Legacy Support: FTP has been widely used historically and is still in use today to support legacy applications and workflows that rely on its specific features and configurations.
- Wide Compatibility: It's supported by a variety of operating systems and software, making it accessible across different platforms.
***Security Concerns:***

- Plain Text Transmission: Traditional FTP transmits data, including usernames, passwords, and file contents, in plain text, which makes it susceptible to eavesdropping and interception.
- No Encryption by Default: FTP lacks built-in encryption, necessitating additional measures (like FTPS - FTP Secure, or SFTP - SSH File Transfer Protocol) to secure data transmission.
***vsftpd (Very Secure FTP Daemon):***
Overview:
- vsftpd is a lightweight and secure FTP server software for Unix-like systems, particularly Linux distributions. It's known for its focus on security, performance, and stability.

***Key Features:***

- Security Focus: vsftpd is designed with a strong emphasis on security, aiming to mitigate common vulnerabilities found in other FTP servers.
Performance Optimization: It's optimized for high performance, making efficient use of system resources and network bandwidth.
Stability: Known for its reliability and stability, vsftpd is suitable for handling both small-scale and large-scale FTP operations.
Advanced Features:

- Virtual IP Configurations: Supports virtual IP configurations, allowing administrators to manage multiple FTP sites on a single server.
SSL/TLS Integration: Provides support for SSL (Secure Sockets Layer) and TLS (Transport Layer Security) encryption, ensuring secure data transmission over the network.
User Access Controls: Allows fine-grained control over user access permissions, enabling administrators to restrict access based on user roles and directories.
- Active and Passive Mode Support: Supports both active and passive FTP modes, providing flexibility in network configurations and firewall setups.
***Deployment Considerations:***

- Default Choice: vsftpd is often the default FTP server in many Linux distributions due to its security features and efficiency.
Configuration Flexibility: It offers extensive configuration options through its configuration file (vsftpd.conf), allowing administrators to tailor settings to meet specific security and operational requirements.
***Community and Support:***

- Being widely adopted in the Linux community, vsftpd benefits from active development, regular updates, and a supportive user community for troubleshooting and best practices.
***Conclusion:***
- While FTP remains relevant for specific use cases, its security limitations have led many organizations to adopt more secure and efficient alternatives like HTTPS for web-based downloads and SCP/SFTP for secure file transfers. For those still requiring FTP, vsftpd stands out as a robust choice, offering enhanced security, performance optimization, and stability on Unix-like systems, particularly Linux distributions. Its comprehensive feature set and strong community support make it a preferred option for many FTP server deployments.

### Dockerfile

``` Dockerfile
FROM debian:oldstable


RUN apt update -y

RUN apt install vsftpd -y

COPY ./tools/script.sh /
RUN	chmod +x script.sh


CMD ["/script.sh"]
```

### Startup script
``` bash
#!/bin/bash

adduser --home /var/www ${FTP_USER}

echo ${FTP_USER}:${FTP_PWD} | chpasswd

sed -i -r "s/#write_enable=YES/write_enable=YES/1"   /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/var/www ${FTP_USER}
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

service vsftpd stop

/usr/sbin/vsftpd /etc/vsftpd.conf
```

## Static WebSite
### Dockerfile
``` Dockerfile
# file : srcs/requirements/bonus/static/Dockerfile
# Use the debian:oldstable base image
FROM debian:oldstable

# Update and upgrade packages, then install nginx
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install nginx -y

# Set the working directory to /etc/nginx
WORKDIR /etc/nginx

# Copy nginx.conf from local /conf/ directory to /etc/nginx/
COPY /conf/nginx.conf .

# Set the working directory to /var/www
WORKDIR /var/www

# Copy index.html from local /conf/ directory to /var/www/
# (Note: the commented out line was intended for removing existing contents, which is not executed due to the comment)
COPY /conf/index.html .

# Expose port 2100
EXPOSE 2100

# Start nginx with daemon off for foreground execution
CMD ["nginx", "-g", "daemon off;"]

```

### nginx.conf
```bash
# file : srcs/requirements/bonus/static/conf/nginx.conf
worker_processes 1;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    server {
        listen 2100;
        server_name zmakhkha.42.fr;

        root /var/www;

        location / {
            autoindex on;
            index index.html;
        }
    }
}

```

### static HTML Page
<!-- file  : srcs/requirements/bonus/static/conf/index.html -->
``` HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Static Webste</title>
</head>
<body>
    <div style="justify-content: center;">
        <h1>Click on the button bellow to listen to surah al baqarah</h1>
        <a href="https://www.youtube.com/watch?v=X2YnP50cwNU">
            <button>Click me</button>
        </a>
    </div>
</body>
</html>
```



## Adminer
Adminer, formerly known as phpMinAdmin, is a PHP-based, open-source database management tool designed for simplicity and ease of deployment on web servers. Here’s a detailed explanation of its key features and capabilities:

### Overview:
Adminer is a lightweight yet powerful alternative to tools like phpMyAdmin for managing databases. It stands out for its single-file deployment model, where you only need to upload a single PHP file to your server and access it through a web browser to start managing your databases.

### Key Features:
Database Support:

Adminer supports a wide range of database management systems beyond MySQL and MariaDB, including:
- PostgreSQL
- SQLite
- MS SQL
- Oracle
- SimpleDB
- Elasticsearch
- MongoDB
- Firebird
    This versatility makes it a valuable tool for developers and administrators working with various database systems within the same interface.

1. Ease of Deployment:

    Unlike many database management tools that require complex setups or installations, Adminer’s deployment is straightforward. You simply upload the PHP file to your server, configure access credentials, and start using it immediately.

2. User Interface:

    Adminer offers an intuitive and user-friendly web interface for managing databases. It provides easy access to essential database operations such as querying, table management, user permissions, and more.
The interface is designed to be responsive and accessible across different devices and screen sizes.

3. Performance:

    Adminer is noted for its performance optimization, providing efficient handling of database operations. This is beneficial for managing large datasets and complex queries without significant overhead.

4. Security:

    Security is prioritized in Adminer’s design. It supports encrypted connections to databases (e.g., SSL/TLS for MySQL), ensuring data transmission between the web interface and the database server is secure.
Additionally, Adminer’s single-file deployment model reduces the attack surface compared to more complex setups, potentially enhancing security.
5. Localization:

    Adminer is available in 43 languages, making it accessible to a global audience. Users can select their preferred language for the interface, facilitating ease of use for non-English speakers.
### Advantages Over phpMyAdmin:
- Ease of Setup: Adminer’s single PHP file deployment simplifies setup compared to phpMyAdmin, which typically requires installation on the server and configuration of a web server environment.
- Database Support: Adminer’s support for multiple database systems expands its utility beyond MySQL and MariaDB, catering to diverse database management needs.
- Performance and Security: Adminer is praised for its performance optimizations and security features, offering a robust platform for managing databases securely and efficiently.
### Dockerfile
``` Dockerfile
# Use the debian:oldstable base image
FROM debian:oldstable

# Set the working directory to /var/www
WORKDIR /var/www

# Update package lists, upgrade existing packages, and install nginx, wget, PHP, and PHP MySQLi extension
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install nginx -y && \
    apt install -y wget php php-mysqli

# Download Adminer v4.8.1 PHP file from GitHub and save it as index.php in /var/www/
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/index.php

# Command to run when the container starts: start PHP's built-in web server
CMD [ "php", "-S", "0.0.0.0:2200" , "-t", "/var/www" ]
```

## Extra Service [Portainer]
Portainer is a robust open-source management tool designed specifically for Docker environments, offering a comprehensive graphical user interface (GUI) to facilitate Docker container management, monitoring, and orchestration. Here's a detailed explanation of its key features and capabilities:

### Overview:
Portainer simplifies Docker container management through its intuitive web-based interface, providing users with tools to deploy, manage, monitor, and scale Docker containers and resources effectively.

### Key Features:

1. Docker Management:

    - Container Management: Portainer allows users to manage Docker containers, including creating, starting, stopping, and removing containers. It provides a user-friendly interface to interact with container processes and configurations.
    - Image Management: Users can browse Docker images, pull new images from registries, and manage existing images within Portainer.
    - Network and Volume Management: It facilitates the creation and management of Docker networks and volumes, essential for configuring container connectivity and persistent storage.

2. Container Templates and Stacks:

    - Portainer offers a built-in catalog of templates and application stacks. These templates enable users to deploy popular applications and services as Docker containers quickly. It streamlines the deployment process by eliminating manual setup and configuration tasks.

3. User and Access Management:

    - Role-Based Access Control (RBAC): Portainer supports RBAC, allowing administrators to define user roles and permissions. This ensures that access to Docker resources and functionalities is restricted based on assigned roles, enhancing security and governance.
    - LDAP/AD Integration: It supports integration with LDAP (Lightweight Directory Access Protocol) and Active Directory for centralized user authentication and access management.

4. Resource Monitoring:

    - Portainer provides real-time monitoring of Docker container resources, including CPU usage, memory usage, and network statistics. This feature helps users monitor container performance, identify resource bottlenecks, and optimize resource allocation.

5. Container Logs and Exec Console:

    - Log Management: Users can view and search container logs directly from the Portainer interface. This capability simplifies troubleshooting and debugging by providing easy access to container logs.
    - Exec Console: Portainer allows users to access an interactive terminal console within running containers. This feature facilitates real-time execution of commands for diagnostic purposes or managing applications inside containers.

6. Docker Swarm Support:

    - Portainer supports Docker Swarm mode, enabling users to manage and orchestrate multi-node Docker clusters. It offers tools to create and manage Swarm services, deploy application stacks, monitor Swarm node health, and scale services horizontally.

7. Multi-Platform Support:

    - Portainer is platform-agnostic and can be deployed on various operating systems and environments, including Linux, Windows, macOS, and ARM-based devices. This flexibility ensures compatibility across different infrastructure setups, making it accessible for diverse deployment scenarios.
### Advantages:

- User-Friendly Interface: Portainer's GUI simplifies Docker operations, making it accessible to both novice and experienced Docker users.
- Efficiency and Automation: Templates and stacks streamline application deployment, reducing setup time and operational complexity.
- Security and Access Control: RBAC and integration options enhance security by controlling access to Docker resources based on user roles.
- Monitoring and Troubleshooting: Real-time monitoring, log management, and exec console tools aid in performance monitoring, debugging, and issue resolution within Docker containers.

### Dockerfile
``` Dockerfile
# Use the debian:oldstable base image
FROM debian:oldstable

# Update package lists, upgrade existing packages, and install wget and tar
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y wget tar

# Create directory /var/lib/portainer
RUN mkdir -p /var/lib/portainer

# Create a user 'portainer' with home directory /var/lib/portainer
RUN adduser --home /var/lib/portainer portainer

# Download Portainer release v2.19.4 for Linux AMD64, extract, and move to /usr/local
RUN wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -O portainer.tar.gz \
    && tar -xf portainer.tar.gz \
    && rm portainer.tar.gz \
    && mv portainer /usr/local

# Set the command to run when the container starts: start Portainer
CMD ["/usr/local/portainer/portainer"]

```
## Docker compose

Docker Compose is a tool for defining and managing multi-container Docker applications. It allows you to use a YAML file to configure your application's services, networks, and volumes, making it easier to orchestrate multiple Docker containers that work together.

### Key Concepts and Features of Docker Compose:
1. YAML Configuration: Docker Compose uses a YAML file (docker-compose.yml) to define the services, networks, volumes, and other configurations for your application.

2. Services: Each containerized application component (e.g., web server, database, cache) is defined as a service in the docker-compose.yml file. Services are isolated, have their own configurations, and can be scaled independently.

3. Networking: Docker Compose automatically creates a default network for your application, allowing services to communicate with each other using service names as hostnames. You can also define custom networks to control communication and isolation between services.

4. Volumes: Docker volumes can be defined in docker-compose.yml to persist data beyond the container's lifecycle. Volumes allow you to share data between containers or with the host machine.

5. Environment Variables: Docker Compose supports loading environment variables from .env files or directly in the docker-compose.yml. This makes it easy to configure different environments (e.g., development, production) without modifying the application's source code.

6. Build Contexts: You can specify build contexts for services that need to build custom Docker images. This allows you to include Dockerfile instructions or build scripts within your project directory.

7. Dependencies and Order: Dependencies between services can be defined using depends_on, ensuring that services start in the correct order. However, depends_on does not wait for services to be "ready" before starting another service.

8. Scaling: Docker Compose supports scaling services to run multiple instances of the same service. You can scale services manually using the docker-compose scale command or automatically with orchestration tools like Docker Swarm or Kubernetes.

9. Healthchecks: You can define health checks for services in docker-compose.yml, specifying conditions that must be met for the service to be considered healthy. This helps in automatic recovery and management of containerized applications.

10. Overrides and Profiles: Docker Compose allows you to override configurations using multiple docker-compose.yml files (docker-compose.override.yml, docker-compose.prod.yml, etc.) or using the docker-compose config command to generate and display the effective configuration.

11. Typical Workflow with Docker Compose:
Define docker-compose.yml: Create a YAML file (docker-compose.yml) in your project directory, defining all the services, networks, volumes, and configurations required for your application.

12. Build and Run: Use docker-compose build to build or rebuild services if necessary, and docker-compose up to start and run your application. Add -d to run in detached mode.

13. Manage Containers: Use commands like docker-compose ps to list running containers, docker-compose logs to view container logs, docker-compose stop to stop containers, and docker-compose down to stop and remove containers, networks, and volumes.

14. Environment Management: Manage environment-specific configurations using .env files or environment variables specified in the docker-compose.yml.

15. Scaling and Orchestration: Scale services using docker-compose scale, or use Docker Swarm or Kubernetes for orchestration in production environments.

### Advantages of Using Docker Compose:
- Simplified Development: Quickly set up and tear down complex development environments.
- Consistent Deployment: Ensure consistency between development, testing, and production environments.
- Resource Efficiency: Efficiently manage resources by defining and scaling containers as needed.
- Isolation and Security: Containers provide process isolation, enhancing security and preventing conflicts between applications.
- Community Support: Docker Compose is widely adopted with extensive community support and integrations.

### Limitations and Considerations:

- Single Host Limitation: Docker Compose manages containers on a single host. For multi-host deployments, consider Docker Swarm or Kubernetes.
- Dependency Management: depends_on only controls startup order, not service readiness. Additional tools or scripts may be needed for health checks.
- Complexity: Managing multiple containers and configurations can become complex, requiring careful planning and documentation.
``` yaml
#file : srcs/docker-compose.yml
version: '3.3'  # Specifies Docker Compose file format version

services:
  nginx:
    container_name: nginx  # Sets the container name for Nginx service
    build: ./requirements/nginx  # Specifies the build context for Nginx service
    image: nginx:v1.0  # Specifies the Docker image and tag for Nginx service
    ports:
      - 443:443  # Maps host port 443 to container port 443 for HTTPS
    volumes:
      - /home/zmakhkha/data/wp:/var/www  # Mounts host directory to container directory
    networks:
      - wp_network  # Attaches Nginx service to the 'wp_network' network
    depends_on:
      - wordpress  # Ensures Nginx starts after the 'wordpress' service
    restart: always  # Restarts Nginx container automatically on failure
    env_file:
      - .env  # Loads environment variables from .env file for Nginx

  wordpress:
    container_name: wordpress  # Sets the container name for WordPress service
    build: ./requirements/wordpress  # Specifies the build context for WordPress service
    image: wordpress:v1.0  # Specifies the Docker image and tag for WordPress service
    depends_on:
      - mariadb  # Ensures WordPress starts after the 'mariadb' service
    volumes:
      - /home/zmakhkha/data/wp:/var/www  # Mounts host directory to container directory
    networks:
      - wp_network  # Attaches WordPress service to the 'wp_network' network
    restart: always  # Restarts WordPress container automatically on failure
    env_file:
      - .env  # Loads environment variables from .env file for WordPress

  mariadb:
    container_name: mariadb  # Sets the container name for MariaDB service
    build: ./requirements/mariadb  # Specifies the build context for MariaDB service
    image: mariadb:v1.0  # Specifies the Docker image and tag for MariaDB service
    volumes:
      - /home/zmakhkha/data/mdb:/var/lib/mysql  # Mounts host directory to MariaDB data directory
    networks:
      - wp_network  # Attaches MariaDB service to the 'wp_network' network
    restart: always  # Restarts MariaDB container automatically on failure
    env_file:
      - .env  # Loads environment variables from .env file for MariaDB

# Bonus services (additional services below)

  website:
    build: ./requirements/bonus/static/  # Specifies the build context for 'website' service
    image: static:v1.0  # Specifies the Docker image and tag for 'website' service
    container_name: static  # Sets the container name for 'website' service
    ports:
      - 2100:2100  # Maps host port 2100 to container port 2100
    networks:
      - wp_network  # Attaches 'website' service to the 'wp_network' network
    restart: always  # Restarts 'website' container automatically on failure

  adminer:
    container_name: adminer  # Sets the container name for Adminer service
    build: ./requirements/bonus/adminer/  # Specifies the build context for Adminer service
    image: adminer:v1.0  # Specifies the Docker image and tag for Adminer service
    volumes:
      - /home/zmakhkha/data/mdb:/var/lib/mysql  # Mounts host directory to Adminer container
    ports:
      - 2200:2200  # Maps host port 2200 to container port 2200 for Adminer
    networks:
      - wp_network  # Attaches Adminer service to the 'wp_network' network
    restart: always  # Restarts Adminer container automatically on failure

  portainer:
    container_name: portainer  # Sets the container name for Portainer service
    build: ./requirements/bonus/portainer/  # Specifies the build context for Portainer service
    image: portainer:v1.0  # Specifies the Docker image and tag for Portainer service
    ports:
      - 2300:9443  # Maps host port 2300 to container port 9443 for Portainer
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"  # Mounts Docker socket for Portainer
    networks:
      - wp_network  # Attaches Portainer service to the 'wp_network' network
    restart: always  # Restarts Portainer container automatically on failure

  ftp:
    container_name: ftp  # Sets the container name for FTP service
    build: ./requirements/bonus/ftp/  # Specifies the build context for FTP service
    image: ftp:v1.0  # Specifies the Docker image and tag for FTP service
    depends_on:
      - wordpress  # Ensures FTP starts after the 'wordpress' service
    volumes:
      - /home/zmakhkha/data/wp:/var/www  # Mounts host directory to FTP container
    env_file:
      - .env  # Loads environment variables from .env file for FTP
    ports:
      - "21:21"  # Maps host port 21 to container port 21 for FTP control
      - "20:20"  # Maps host port 20 to container port 20 for FTP data
    networks:
      - wp_network  # Attaches FTP service to the 'wp_network' network
    restart: always  # Restarts FTP container automatically on failure

  redis:
    container_name: redis  # Sets the container name for Redis service
    build: ./requirements/bonus/redis/  # Specifies the build context for Redis service
    image: redis:v1.0  # Specifies the Docker image and tag for Redis service
    ports:
      - 6379:6379  # Maps host port 6379 to container port 6379 for Redis
    volumes:
      - /home/zmakhkha/data/wp:/var/www  # Mounts host directory to Redis container
    networks:
      - wp_network  # Attaches Redis service to the 'wp_network' network
    restart: always  # Restarts Redis container automatically on failure

networks:
  wp_network:
    driver: bridge  # Specifies the network driver for 'wp_network' as bridge

```