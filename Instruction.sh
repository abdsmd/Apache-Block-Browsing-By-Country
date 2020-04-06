
wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/abdsmd/Apache-Block-Browsing-By-Country/master/CentOS-Base.repo   --no-check-certificate  
yum update -y
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
