FROM nginx

RUN echo "<h1>Container layer data</h1>" > /usr/share/nginx/html/index.html 

RUN mkdir -p /usr/share/my-data/volume_data && \
    echo "Data in Volume" > /usr/share/my-data/volume_data/data.txt

RUN mkdir -p /usr/share/my-data/bind_data && \
    echo "Data in Bind Mount" > /usr/share/my-data/bind_data/data.txt

RUN mkdir -p /usr/share/my-data/tmpfs_data && \
    echo "Data in tmpfs" > /usr/share/my-data/tmpfs_data/data.txt

