1) Docker only:

docker build -t my-nginx .

docker run -d --name storage-demo `
  -v my_nginx_volume:/usr/share/nginx/volume_data `
  -v C:\Users\cvv\Documents\Neoversity\Examples\04_Docker_data_storages\docker-demo-bind-data:/usr/share/nginx/bind_data `
  --tmpfs /usr/share/nginx/tmpfs_data `
  my-nginx

2) Docker composer:
docker compose up -d

3) Where to check?
Container layer: docker -it storage-demo cat /usr/share/nginx/html/index.html
tmpfs:
    Fix wsl RAM in windows or docker stats storage-demo
    dd if=/dev/zero of=/usr/share/my-data/tmpfs_data/1gb_file.txt bs=1M count=1024
    ls -lh /usr/share/my-data/tmpfs_data/
    Fix wsl RAM in windows or docker stats storage-demo. 
        Must be +1Gb
    
    check: docker compose restart
    Fix wsl RAM in windows or docker stats storage-demo. 
        Must be -1Gb
Volumes:
    Windows wsl:
        \\wsl.localhost\docker-desktop\mnt\docker-desktop-disk\data\docker\volumes
        C:\Users\cvv\AppData\Local\Docker\wsl

    Linux:
        /var/lib/docker/volumes/Volumes
Mount:
    ./docker-demo-bind-data
