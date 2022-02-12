FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget npm apache2 php php-curl php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring  php-xml php-pear php-bcmath  -y
RUN  npm install -g wstunnel
RUN mkdir /run/sshd 
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel
RUN a2enmod  rewrite
RUN rm /etc/apache2/sites-available/000-default.conf
RUN wget https://raw.githubusercontent.com/thomasfernandas/oketo-test/main/000-default.conf
RUN mv 000-default.conf /etc/apache2/sites-available
RUN echo 'You can play the awesome Cloud NOW! - Message from berbagi cara setting!' >/var/www/html/index.html
RUN echo 'wstunnel -s 0.0.0.0:8989 & ' >>/luo.sh
RUN echo 'service mysql restart' >>/luo.sh
RUN echo 'service apache2 restart' >>/luo.sh
RUN echo '/usr/sbin/sshd -D' >>/luo.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.tgz && tar -xvf ngrok-stable-linux-amd64.tgz && ./ngrok authtoken 1o79XtSYTbApvdYruCJwpX5kyVJ_4fQ28refmFoEc36iQvgPc
RUN echo root:123456|chpasswd
RUN chmod 755 /luo.sh
EXPOSE 80
CMD  ./ngrok tcp 22 & curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url && /luo.sh
