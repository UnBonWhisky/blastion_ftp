# blastion_ftp
A high interaction FTP honeypot using pure-ftpd edited version.  
On github, you will only have edited files, but on the honeypot itself, you will get every commands and every login tries done.

[Here](https://hub.docker.com/r/unbonwhisky/blastion_ftp) is the link to the Docker Hub page

## Application Setup

Access the honeypot at `<your-ip>:21`.

## Usage

To help you get started creating a container from this image you can use docker-compose.

### docker-compose (recommended)

```yaml
version: "3.7"
services:
  blastion:
    container_name: blastion_ftp
    environment:
      #- Example :
      # - USERNAME=ubuntu
      # - PASSWORD=ubuntu
      - USERNAME=<username you want to use for the login to container ftp>
      - PASSWORD=<password you want to use for the login to container ftp>
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Paris
    image: unbonwhisky/blastion_ftp:latest
    hostname: <hostname you want for the honeypot in FTP>
    ports:
      - 0.0.0.0:21:21
      - 0.0.0.0:30000-30100:30000-30100
    restart: unless-stopped
    volumes:
      - "/path/to/container/homedir:/home/<username you have set on top>"
```

## Contributors
This project have been made with [@Marokingu](https://github.com/Marokingu) and [@alexilrx](https://github.com/alexilrx)