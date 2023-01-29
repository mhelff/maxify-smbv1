# maxify-smbv1
Samba v1 image for Canon Maxify scanners

# Motivation
Canon Maxify MFPs like the Maxify MB5150 have a excellent duplex scanning engine, but are - beside sending eMails - limited to store scans on SMB v1 shares.
This is no longer supported in modern OS.

To use these devices to scan directly to DMS like [paperless-ngx](https://github.com/paperless-ngx/paperless-ngx): Here is what you are looking for. 

# Environment variables / configuration

- `NETBIOS_NAME`: The Netbios name of the samba server, defaults to `MAXIFYSMBV1`
- `WORKGROUP`: The samba workgroup, defaults to `WORKGROUP`
- `SHARE1`: The name of the first share. Defaults to `SHARE1`. Files will be stored in `/media/NAME_OF_THE_SHARE`
- `SHARE1_COMMENT`: The samba comment for the share
- `SHARE2`: The name of the second share. Defaults to `SHARE2`. Files will be stored in `/media/NAME_OF_THE_SHARE`
- `SHARE2_COMMENT`: The second share comment


# docker-compose.yml

Sample showing how to use as a consume directory for paperless 

```
maxify-smbv1:
    image: ghcr.io/mhelff/maxify-smbv1:latest
    ports:
      - 139:139
    restart: unless-stopped   
    environment:
      - NETBIOS_NAME=paperless_smb
      - WORKGROUP=YOURWORKGROUP
      - SHARE1=consume
      - SHARE1_COMMENT="Paperless consume smbv1 share"
    volumes:
      - ./data/paperless/consume:/media/consume:rw
      # the default share path of second share, uncomment if needed
      # - ./data/somefolder:/media/SHARE2:rw
```

# Security
There is none. This container is build to have the easiest possible way to scan from a Canon Maxify MFP to your network. Make sure it is not accessible from outside. Also keep in mind that the Samba version is (has to be) quite old and is no longer maintained. Use at your own risk.

# Special thanks
This container is heavily inspired by [luizoti/docker-smb](https://github.com/luizoti/docker-smb)
