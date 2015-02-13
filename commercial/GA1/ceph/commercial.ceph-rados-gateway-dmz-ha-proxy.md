---
layout: default
title: "HP Helion OpenStack&#174; Edition: HP Helion Ceph"
permalink: /helion/openstack/ceph-rados-gateway-dmz-ha-proxy/
product: commercial

---
<!--UNDER REVISION-->


<script>

function PageRefresh {
onLoad="window.refresh"
}

PageRefresh();

</script>
<!--
<p style="font-size: small;"> <a href="/helion/openstack/install-beta/kvm/">&#9664; PREV</a> | <a href="/helion/openstack/install-beta-overview/">&#9650; UP</a> | <a href="/helion/openstack/install-beta/esx/">NEXT &#9654;</a> </p>
-->


# HP Helion Ceph RADOS Gateway - DMZ HAProxy

As discussed in previous sections, the Ceph storage system is successfully integrated with HP Helion OpenStack. Ceph has a RADOS gateway that is a public facing interface and is vulnerable. Hence, any end user can gain access into a Helion system with this integration. To minimize risks, an external HAProxy is built in a DMZ environment behind a firewall. HAProxy is commonly used as a load balancer for TCP- and HTTP-based applications. It works as a reverse-proxy, which means it maintains two connections when allowing a client to cross it: a connection between HAProxy and the client, and  another between HAProxy and the server. 
 
To ensure secured connectivity, the connections should use HTTPS (SSL over HTTP). Stunnel is used as an intermediate between the client with an HTTPs request and the HAProxy.  During normal operation, Stunnel receives the HTTPS request from client and hands  the request to a HAProxy instance that is bound to the loopback address (127.0.0.1) on the same box. HAProxy now forwards the HTTPs request to gateway nodes listening on port 443.

The following diagram illustrates the communication flow between Helion-Ceph-DMZ and the HAProxy-Ceph Gateway

<img src="media/commercial-ceph-communication-flow-between-helion-Ceph-DMZ-HAProxy-Ceph Gateway.png"/)>

####Assumptions
This illustration relies on the following assumptions:

1.	Dual-homed Proxy server in the DMZ. The public facing address for Internet clients and a private address to connect to gateway nodes.
2.	Gateway nodes are in a private network - 192.0.2.x
3.	The client node is in a public network - 192.168.122.x

###Install General Packages

To install the general packages in the proxy server, enter:

* Install curl, openssl and libnss3-tools
* apt-get install curl
* apt-get install openssl ssl-cert
* apt-get install libnss3-tools


####Stunnel Install and Configuration

To install and configure Stunnel, enter:

1.	To install stunel4, enter:

		apt-get install stunnel4

2. To create a local CA and HAProxy certificates in the `/etc/ssl/certs` directory, perform the following step.

   * To create the CA key and certificate, enter:
  
			openssl genrsa -out ca.key 1024
			openssl req -x509 -new -nodes -key ca.key -days 1024 -out ca.crt
	
	* To create the HAProxy key, CSR, and certificate (as shown below), enter:
			
			openssl genrsa -out ha.key 1024
			openssl req -new -key ha.key -out ha.csr
			openssl x509 -req -in ha.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out ha.crt -days 1023


	* To view the files, enter:

			cat /etc/ssl/certs/ha.key /etc/ssl/certs/ha.crt > /etc/stunnel/ha.pem

	* To copy the CA certificate to the client node making requests, enter:
	* 
	** [[Command is required?**

3.	To configure the Stunnel, edit the `stunnel.cfg` file at `/etc/stunnel/stunnel.cfg`. Note the `radosgw` section where the IP address is for the proxy server. The proxy server certificate generated above is used for authentication.
		
		sslVersion = all
		cert = /etc/ssl/certs/ha.pem
		pid = /var/run/stunnel4/stunnel4.pid
		debug = 7
		output = /var/log/stunnel4/stunnel.log
		verify = 0

		[radosgw]	
		accept = 192.168.122.152:443
		connect = 127.0.0.1:81

4.	To enable automatic Stunnel startup, edit `/etc/default/stunnel4` by entering: 

		ENABLED=1 

5.	To restart the Stunnel service, enter:

	       /etc/init.d/stunnel4 restart 


####HAProxy Install and Configuration

To install and configure HAProxy, perform the following steps.

1.	To install HAProxy, enter:
        
		apt-get install haproxy

2.	To configure HAProxy, edit `haproxy.cfg` at `/etc/haproxy/haproxy.cfg`.  Note the RADOSGW section where address to listen on and the addresses of the gateway nodes are specified as per the test setup.
		   

		global   
			log /dev/log    local0
			log /dev/log    local1 notice
	   		 chroot /var/lib/haproxy
			stats socket /run/haproxy/admin.sock mode 660 level admin
			stats timeout 30s
			user haproxy
			group haproxy
			daemon
			# Default SSL material locations
			ca-base /etc/ssl/certs
			crt-base /etc/ssl/private
			# Default ciphers to use on SSL-enabled listening sockets.
			# For more information, see ciphers(1SSL).
		    ssl-default-bind-ciphers kEECDH+aRSA+AES:kRSA+AES:+AES256:RC4-SHA:!kEDH:!LOW:!EXP:!MD5:!aNULL:!eNULL
		    ssl-default-bind-options no-sslv3
		defaults
        	log     global
        	option  dontlognull
        	timeout  http-request 10s
        	timeout  queue 1m
        	timeout  connect 10s
        	timeout  client 10m
        	timeout  server 10m
        	timeout  check 10s
        	mode  tcp
        	option  tcpka
        	option  tcplog
        	balance source
        	errorfile 400 /etc/haproxy/errors/400.http
        	errorfile 403 /etc/haproxy/errors/403.http
        	errorfile 408 /etc/haproxy/errors/408.http
        	errorfile 500 /etc/haproxy/errors/500.http
        	errorfile 502 /etc/haproxy/errors/502.http
        	errorfile 503 /etc/haproxy/errors/503.http
        	errorfile 504 /etc/haproxy/errors/504.http

		listen radosgw 127.0.0.1:81 ssl crt /etc/ssl/certs/ha.pem
        	balance roundrobin
        	server hrados 192.0.2.215:443 maxconn 1500 ssl verify none
        	server hrados1 192.0.2.216:443 maxconn 1500 ssl verify none
        	reqadd X-Forwarded-Proto:\ https
	listen haproxy.stats :1993
  			mode http
 			stats enable
  			stats uri /

3.	To restart haproxy service, enter:

        /etc/init.d/haproxy restart

####Validating the Installation
To validate the Ceph RADOS Gateway - DMZ HAProxy installation, consider: 

* Validation is performed from client node. 
* Swift requests are purely v1 as the Identity service (Keystone) is not integrated into this system. Therefore, make sure that S3 and the Swift user are created using the `radosgw-admin` commands.
* Make sure the CA certificate is available in `/usr/local/share/ca-certificates`
* Execute `update-ca-certificates`
* cURL or Swift calls as shown below must succeed.
		
		curl  https://192.168.122.152 
		swift -V 1.0 -A https://HA.ex.com/auth/v1.0 -U s3User:swiftUser -K Ks0qeIDJz5SBU7WuVi6RattjaXign54seoNqAh1O list


<a href="#top" style="padding:14px 0px 14px 0px; text-decoration: none;"> Return to Top &#8593; </a>