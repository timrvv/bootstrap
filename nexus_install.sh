#nexus bootstrap


sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install oracle-java8-set-default

wget http://download.sonatype.com/nexus/3/nexus-3.1.0-04-unix.tar.gz
sudo -i
cp ~/nexus-3.1.0-04-unix.tar.gz /usr/local/
cd /usr/local/
tar -xvzf nexus-3.1.0-04-unix.tar.gz
ln -s nexus-3.1.0-04-unix nexus

adduser --disabled-password --disabled-login nexus
chown -R nexus:nexus ./nexus-3.1.0-04-unix/
chown -R nexus:nexus ./sonatype-work/

cp nexus/bin/nexus /etc/init.d/nexus
chmod 755 /etc/init.d/nexus
chown root /etc/init.d/nexus
update-rc.d nexus defaults


#В файле /etc/init.d/nexus кое-что нужно поправить:
NEXUS_HOME="/usr/local/nexus"
RUN_AS_USER="nexus"
PIDDIR="/usr/local/nexus/tmp"

sudo service nexus start
tail -f /usr/local/nexus/logs/wrapper.log

