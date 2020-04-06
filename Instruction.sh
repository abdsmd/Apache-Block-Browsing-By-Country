# Update The Repo for CentOS 5 (32bit) US Server

> /etc/yum.repos.d/CentOS-Base.repo
nano /etc/yum.repos.d/CentOS-Base.repo

[base]
name=CentOS-$releasever - Base
baseurl=http://vault.centos.org/5.11/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

[updates]
name=CentOS-$releasever - Updates
baseurl=http://vault.centos.org/5.11/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5


[extras]
name=CentOS-$releasever - Extras
baseurl=http://vault.centos.org/5.11/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5


[centosplus]
name=CentOS-$releasever - Plus
baseurl=http://vault.centos.org/5.11/os/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5


[contrib]
name=CentOS-$releasever - Contrib
baseurl=http://vault.centos.org/5.11/os/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

`````````````````````````````````````````````````````````````````````````


yum install -y epel-release
yum install -y GeoIP GeoIP-GeoLite-data geoipupdate mod_geoip

cat <<EOF >/etc/httpd/conf.d/geoip.conf
LoadModule geoip_module modules/mod_geoip.so

<IfModule mod_geoip.c>
  GeoIPEnable On
  GeoIPDBFile /usr/share/GeoIP/GeoIP.dat


<Location />
SetEnvIf GEOIP_COUNTRY_CODE BD AllowCountry
SetEnvIf GEOIP_COUNTRY_CODE PK AllowCountry
Allow from env=AllowCountry
Deny from All
</Location>

</IfModule>

EOF

service httpd restart
