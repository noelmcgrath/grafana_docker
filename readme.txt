https://registry.hub.docker.com/u/cazcade/docker-grafana-graphite/dockerfile/


docker build -t nmcg/grafana:1.0 .
docker run -d -p 80:80 -p 8000:8000 -p 9200:9200 -p 8125:8125/udp -p 8126:8126 nmcg/grafana:2.0 /usr/bin/supervisord
docker run -d -p 80:80 -p 8000:8000 -p 9200:9200 -p 8125:8125/udp -p 8126:8126 nmcg/grafana:2.0



echo "stats" | nc localhost 8126   -q 2
echo "mycount:1|c" | nc -w 1 -u localhost 8125

curl http://localhost/
curl http://localhost/graphite/
curl http://localhost/elasticsearch/


docker rmi $(docker images | grep "^<none>" | awk "{print $3}")


docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)


====================================
docker exec -it [container-id] bash



====================================
Notes
Removed cabot - doesnt work
Updated version of grafana


====================================
Volumes
elasticserach https://github.com/dockerfile/elasticsearch
graphite https://github.com/nickstenning/docker-graphite

# Create a data container - 2 volumes /data and /var/lib/graphite/storage/whisper
docker run -i -t --name metrics_data1 -v /var/lib/graphite/storage/whisper busybox /bin/sh
docker run --name metrics_data3 -v /data -v /var/lib/elasticsearch -v /var/lib/graphite/storage/whisper busybox true

# Run docker worker 1 that can see the volumes from nmcg_data data container
docker build -t nmcg/grafana:1.0 .
docker run -d -p 80:80 -p 8000:8000 -p 9200:9200 -p 8125:8125/udp -p 8126:8126 --name nmcg_grafana --volumes-from metrics_data2 nmcg/grafana:2.0

docker run -d -p 9200:9200 -p 9300:9300 -v <data-dir>:/data dockerfile/elasticsearch /elasticsearch/bin/elasticsearch -Des.config=/data/elasticsearch.yml

docker run -t -i -h nmcg1 --name nmcg_worker1 --volumes-from nmcg_data ubuntu bash
	hostname > /var/data1/host_from_container

# Run docker worker 1 that can see the volumes from nmcg_data data container
docker run -t -i -h nmcg2 --name nmcg_worker2 --volumes-from nmcg_data ubuntu bash
	hostname > /var/data2/host_from_container







# Software content
mkdir -p /opt/elk
cd /opt/elk

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.tar.gz
tar xvzf elasticsearch-1.4.0.tar.gz && mv elasticsearch-1.4.0 elasticsearch
rm -f elasticsearch-1.4.0.tar.gz

# Alter the elastic search config file
ADD ./elasticsearch/elasticsearch.yml /opt/elk/elasticsearch/config/elasticsearch.yml

# Add user and set ownership of content
add_user elasticsearch elasticsearch
chown -R elasticsearch:elasticsearch /opt/elk/elasticsearch














=====================================
Pat
# Create a data container - 2 volumes /var/data1 and /var/data2
docker run --name nmcg_data -v /var/data1 -v /var/data2 busybox true

# Run docker worker 1 that can see the volumes from nmcg_data data container
docker run -t -i -h nmcg1 --name nmcg_worker1 --volumes-from nmcg_data ubuntu bash
	hostname > /var/data1/host_from_container

# Run docker worker 1 that can see the volumes from nmcg_data data container
docker run -t -i -h nmcg2 --name nmcg_worker2 --volumes-from nmcg_data ubuntu bash
	hostname > /var/data2/host_from_container


To see carbon aggregator inclusion see sha a1d236a853ea5c2c813b44ea8b5ca9cb9ec62ace

docker build -t pmcg/graphite1:2.0 .

docker run -d -p 80:80 -p 8125:8125/udp -p 8126:8126 pmcg/graphite1:1.0 /usr/bin/supervisord
docker run -d -p 80:80 -p 8125:8125/udp -p 8126:8126 pmcg/graphite1:2.0 /usr/bin/supervisord

echo stats | nc localhost 8125								# Issue if running this on the host, where no issue if within the container or on another machine
echo counters | nc localhost 8125							# Issue if running this on the host, where no issue if within the container or on another machine
echo "mycount:1|c" | nc -w 1 -u localhost 8125
