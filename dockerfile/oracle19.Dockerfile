FROM centos:centos7

# yum update
RUN yum -y update && yum clean all && \
    sed -i -e '/override_install_langs/s/$/,ja_JP.utf8/g' /etc/yum.conf && \
    yum reinstall -y glibc-common && \
    echo 'LANG="ja_JP.UTF-8"' >> /etc/locale.conf && \
    yum install -y tzdata && \
    echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock && \
    echo 'UTC=false' >> /etc/sysconfig/clock && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    yum -y install ncurses-devel make gcc git curl wget unzip && \
    yum clean all

# copy RPM binary
COPY rpm_19c/ /tmp/

# install oracle rpm
## sed command see : https://github.com/oracle/docker-images/issues/1544
RUN cd /tmp && \
    env ORACLE_DOCKER_INSTALL=true && \
    curl -o oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm && \
    yum -y localinstall oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm && \
    sed -i -r 's/^(session\s+required\s+pam_limits.so)/#\1/' /etc/pam.d/* && \
    yum -y localinstall oracle-database-ee-19c-1.0-1.x86_64.rpm && \
    yum clean all && \
    rm oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm && \
    rm oracle-database-ee-19c-1.0-1.x86_64.rpm

# configure oracle 19c
## transparent_hugepage see : https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/7/html/performance_tuning_guide/sect-red_hat_enterprise_linux-performance_tuning_guide-configuring_transparent_huge_pages
# RUN echo never > /sys/kernel/mm/transparent_hugepage/enabled && \
## edit conf see : https://www.scpepper.tokyo/2019/06/03/oracle-database-19c-installation/
RUN cp -a /etc/sysconfig/oracledb_ORCLCDB-19c.conf /etc/sysconfig/oracledb_CDB-19c.conf && \
    sed -e s/ORCLCDB/CDB/g -e s/ORCLPDB1/PDB1/g /etc/init.d/oracledb_ORCLCDB-19c > /etc/init.d/oracledb_CDB-19c && \
    chmod 755 /etc/init.d/oracledb_CDB-19c && \
    env ORACLE_DOCKER_INSTALL=true && \
    /etc/init.d/oracledb_CDB-19c configure

# copy setup files
COPY --chown=oracle:oinstall setup_19c/ /tmp/

# setup
RUN cd /tmp && \
    mv /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora.bk && \
    mv tnsnames.ora /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora && \
    mv /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora.bk && \
    mv listener.ora /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora && \
    cat add_glogin.lst >> /opt/oracle/product/19c/dbhome_1/sqlplus/admin/glogin.sql && \
    cat add_bashrc.lst >> /home/oracle/.bashrc && \
    mv startOracle.sh /home/oracle/startOracle.sh && \
    mv stopOracle.sh /home/oracle/stopOracle.sh && \
    mv firstSetup.sh /home/oracle/firstSetup.sh && \
    mv checkStatus.sh /home/oracle/checkStatus.sh && \
    chmod +x /home/oracle/startOracle.sh /home/oracle/stopOracle.sh /home/oracle/firstSetup.sh /home/oracle/checkStatus.sh

ENV LANG=ja_JP.UTF-8 \
    LC_ALL=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja

# CMD ["/sbin/init"]
