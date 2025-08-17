
##  Get started
add the `docker-compose.yml`, `backup.sh` and `restore.sh` files to `/etc/docker/nextcloud/` folder

### startup
```bash
docker compose up -d
```

### backup 
requirement: `nextcloud` and `db` containers are running
```bash
sudo bash backup.sh

```

### restore
copy the `backups` to the folder which is need to reinstall `nextcloud`
```bash
sudo bash restore.sh ./backups/2025_80180
```
