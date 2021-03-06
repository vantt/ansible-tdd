FROM nguyenphuongthanhf/docker-ansible2:latest

# Add default atdd user    
RUN useradd -u 1000 -m --shell /bin/bash atdd && \
    echo "atdd:P@ssw0rd!@#$%^" | chpasswd

RUN apt-get update \
&& easy_install pip \
&& pip install boto \
&& chown atdd:atdd /etc/ansible/roles \
&& apt-get install -y git \
&& apt-get install -y rubygems \
&& gem install serverspec 

COPY src/ /ansible-tdd/
COPY docker-entrypoint.sh /
COPY config.sh /

ENV ATDD_HOME /ansible-tdd

RUN /config.sh \
&& chown atdd:atdd /ansible-tdd -R



USER atdd
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/bin/bash"]
