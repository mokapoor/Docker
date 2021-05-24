FROM oraclelinux:7-slim

# Default to UTF-8 file.encoding
ENV JAVA_PKG=jdk-8u291-linux-x64.tar.gz \
    JAVA_HOME=/usr/java/jdk1.8.0_291/
ADD $JAVA_PKG /usr/java/

RUN export JAVA_DIR=$(ls -ld /usr/java/*) && \
    alternatives --install "/usr/bin/java" "java" "/usr/java/bin/java" 20000 && \
    alternatives --install "/usr/bin/javac" "javac" "/usr/java/bin/javac" 20000 && \
    alternatives --install "/usr/bin/jar" "jar" "/usr/java/bin/jar" 20000 && \
    update-alternatives --set java /usr/java/bin/java && \
    update-alternatives --set javac /usr/java/bin/javac && \
    update-alternatives --set jar /usr/java/bin/jar

#RUN useradd -ms /bin/bash devops && yum install -y vi wget && mkdir /data && chmod -R 777 /data /usr/java/ && chown -R devops. /usr/java /data && echo "devops ALL=(ALL)  ALL" >> /etc/sudoers
RUN useradd -ms /bin/bash devops
RUN yum install -y vi wget && mkdir /data && chmod -R 777 /data
RUN echo "devops ALL=(ALL)  ALL" >> /etc/sudoers
COPY pack/* /data/
#ADD /oracle/web12/weblogic.txt /data/

USER devops
RUN wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=14Lx8mx7NeBgJqMtj-K2ODyuwDPkttluO' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=14Lx8mx7NeBgJqMtj-K2ODyuwDPkttluO" -O /data/fmw_14.1.1.0.0_wls_lite_generic.jar && rm -rf /tmp/cookies.txt && /usr/java/jdk1.8.0_291/bin/java -Xms1024m -Xmx1024m -jar /data/fmw_14.1.1.0.0_wls_lite_generic.jar -silent -responseFile /data/weblogic.txt -invPtrLoc /data/oraInst.loc && rm -rf /data/fmw_14.1.1.0.0_wls_lite_generic.jar && /data/domain_creation.sh
#RUN /data/domain_creation.sh
CMD ["/data/Oracle/Middleware/Oracle_Home/user_projects/domains/sit_domain/bin/startWebLogic.sh"]
