# docker-ubuntu-ssh


This Docker image provides a lightweight Ubuntu-based environment with SSH access enabled. It allows you to securely connect to the containerized environment via SSH. The image is designed to be customizable by allowing you to set a root password and create a non-root user with sudo privileges.

## Usage:

```javascript
docker run -d -p <host_port>:22 --name <container_name> -e ROOT_PASSWORD=<password> -e USERNAME=<username> ubuntu-ssh
```

Replace <host_port> with the desired host port for SSH access, <container_name> with your chosen container name, <password> with your desired root password, and <username> with the non-root username you want to create.

## Connecting via SSH:

```javascript
ssh <username>@localhost -p <host_port>
```

Replace <username> with the non-root username you specified and <host_port> with the host port you mapped when running the container.

## Example

Run a Docker container using the newly built image:

```javascript
docker run -d -p 1234:22 --name ssh-container -e ROOT_PASSWORD=myrootpass -e USERNAME=myuser ubuntu-ssh
```
### In this command:

-d: Run the container in the background (detached mode).
-p 1234:22: Map port 1234 on the host to port 22 in the container for SSH access.
--name ssh-container: Assign the name "ssh-container" to the running container.
-e ROOT_PASSWORD=myrootpass: Set the root password to "myrootpass".
-e USERNAME=myuser: Create a non-root user named "myuser".

Step 3: Connect via SSH

Now you can connect to the running container using SSH:

```javascript
ssh myuser@localhost -p 1234
```
Provide the password when prompted (in this example, use "myrootpass").

Note: Since port 1234 was mapped on the host, you can also connect to the container using a different machine on your network by replacing "localhost" with the IP address or hostname of the host machine.

#### Cleaning Up:

To stop and remove the container, you can use the following commands:

```javascript
docker stop ssh-container
docker rm ssh-container
```
This example demonstrates how to create a Docker image with SSH access, run a container from the image, and connect to the container using SSH. You can customize the root password, username, and other configurations as needed for your specific use case.

#### Dockerfile Description:

This Dockerfile creates an Ubuntu-based image with SSH server functionality. It performs the following steps:

- Installs the OpenSSH server and essential utilities.
- Configures SSH to allow root login and disables PAM (Pluggable - Authentication Module) for SSH.
- Sets default environment variables for the root password and username.
- Creates a user with the provided username and password, granting them sudo privileges.
- Exposes port 22 to enable SSH access.
- Copies an entrypoint.sh script to the image and makes it executable.
- Specifies the entrypoint.sh script as the entry point for the container.

#### entrypoint.sh Description:

This script is executed when the container starts. It performs the following tasks:

- Sets default values for the root password and username if not - provided.
- Sets the root password using the provided value.
- Creates a user with the provided username and password.
- Adds the user to the sudo group.
- Starts the SSH server, allowing SSH connections to the container.

Note: For enhanced security, it's recommended to avoid using well-known port numbers like 2222 for SSH. Instead, you can use the -P option with docker run to let Docker choose a random host port for mapping to the container's SSH port (22).

This Docker image is designed to provide a flexible and secure SSH-accessible environment for various use cases. Customize the image by setting the root password, username, and any other configurations you require.
