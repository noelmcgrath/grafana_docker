https://registry.hub.docker.com/u/cazcade/docker-grafana-graphite/dockerfile/


echo "stats" | nc localhost 8126   -q 2
echo "mycount:1|c" | nc -w 1 -u localhost 8125

curl http://localhost/
curl http://localhost/graphite/
curl http://localhost/elasticsearch/


docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
docker rmi $(docker images | grep "^n" | awk "{print $3}")

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)


====================================
Notes
Removed cabot - doesnt work
Updated version of grafana


====================================
Volumes
elasticserach https://github.com/dockerfile/elasticsearch
graphite https://github.com/nickstenning/docker-graphite

# container volume
# Works for graphite only
docker run -i -t --name metrics_data1-v /var/lib/graphite/storage/whisper busybox /bin/sh
docker build -t nmcg/grafana:1.0 .
docker run -d -p 80:80 -p 8000:8000 -p 9200:9200 -p 8125:8125/udp -p 8126:8126 --name nmcg_grafana11 --volumes-from metrics_data1 nmcg/grafana:11.0


# host volume
docker build -t nmcg/grafana:1.0 .
docker run -d -p 80:80 -p 8000:8000 -p 9200:9200 -p 8125:8125/udp -p 8126:8126 --name nmcg_grafana1 -v /vagrant/noeltest:/data nmcg/grafana:1.0
docker run -d -p 80:80 -p 8000:8000 -p 9200:9200 -p 8125:8125/udp -p 8126:8126 --name nmcg_grafana1 -v /vagrant/noeltest:/data -v /vagrant/noeltest:/var/lib/graphite/storage/whisper nmcg/grafana:1.0


# Run docker worker 1 that can see the volumes from nmcg_data data container
docker run -t -i -h nmcg2 --name nmcg_worker2 --volumes-from nmcg_data ubuntu bash
	hostname > /var/data2/host_from_container



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
