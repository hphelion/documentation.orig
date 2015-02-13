---
layout: default
title: "HP Helion OpenStack&#174; Edition: HP Helion Ceph"
permalink: /helion/openstack/ceph/prerequisite/
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


# HP Helion OpenStack Enterprise Edition 1.1 Ceph Firefly 80.7 Storage Solution: Prerequisites

Before you begin the Ceph installation process, take a few minutes to read this page for information about:

* [Hardware Requirement for Ceph Cluster](#hardware-requirement)
* [Download and Access to the Solution Files and Documents](#Download-and-access)


###Hardware Requirement for Ceph Cluster {#hardware-requirement}

####Virtual Environment

Ceph can run on commodity hardware, that makes building and maintaining petabyte-scale data clusters economically viable. When planning for the performance, capacity and resiliency of the Ceph cluster, review sizing with HP to make sure the solution will fit the SLA. Ceph can run on HP SL230s, HP SL4540s and HP DL580s - sizing is completely driven the SLAs. Small proof-of-concept clusters and development clusters can run successfully on Virtual Machines with minimal system requirements.  For example, you can configure 1 VM running Admin, 1 VM running radosgw, 3 VMs running Ceph OSD, and 1 VM running Monitor.
 

<**need** **to fix the table as per the document>**

<table>
<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
	<th rowspa="4"> Process</th>
<th>Criteria </th>
	<th>Minimum Recommended </th>
</tr>
	<tr>
<td>ceph-osd</td>
<td>Processor</td>
<td>4vCPU</td>
</tr>
<tr>
<td>ceph-mon</td>
<td>RAM</td>
<td>4G </td>
</tr>
<tr>
<td>ceph rados gateway</td>
<td>Disk Space</td>
<td>100 GB</td>
</tr>
<tr>
<td>ceph admin</td>
<td>Network</td>
<td>2x 1GB Ethernet vNICs</td>
</tr>
  </table>

####Production Environment

HP recommends the following hardware for the production environment:

<table>
<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
	<th> Process</th>
	<th>Criteria </th>
	<th>Minimum Recommended Server Quantity</th>
</tr>
	<tr>
<td>Ceph-OSD</td>
<td>3 x 15 HP ProLiant SL4540 Gen8 Servers</td>
<td>5</td>
</tr>
<tr>
<td>Ceph-Mon</td>
<td>HP ProLiant DL360p Gen8 Servers</td>
<td>3 </td>
</tr>
<tr>
<td>Ceph-Admin</td>
<td>HP ProLiant DL360p Gen8 Servers</td>
<td>1&#42;</td>
</tr>
<tr>
<td>Ceph-RADOSGW</td>
<td>HP ProLiant DL360p Gen8 Servers</td>
<td>1&#42;</td>
</tr>
<tr>
<td>**need infor**</td>
<td>10 GbE Networking running on HP 5900AF switches</td>
<td>1</td>
</tr>
<tr>
<td>**need info**</td>
<td>1 GbE Networking running on an HP 2920 switch</td>
<td>1</td>
</tr>
</table>

**Note**: If the resiliency SLA for the User Archive or Backup use cases cannot tolerate downtime of the Ceph RADOS Gateway, then consider adding additional servers with an external Load Balancer.


The following table shows an example of a detailed deployment scenario:

 <table>
<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
	<th> HP Helion OpenStack</th>
	<th>CEPH Monitor/GateWays </th>
	<th>OSDs (6x15 SL4540)</th>
</tr>
	<tr>
<td>12 ProLiant DL360p Gen8 with 12 cores each</td>
<td>4x HP ProLiant DL360p Gen8 with 12 cores</td>
<td>6 x HP 3xSL4540 Gen8 with 16 cores each</td>
</tr>
<tr>
<td>2 x E5-2667 (Intel Xeon 2.9GHz 15M Cache)</td>
<td>2 x E5-2667 (Intel Xeon 2.9GHz 15M Cache)</td>
<td>2 x E5-2470 (Intel Xeon 2.3GHz 20M Cache) </td>
</tr>
<tr>
<td>64 GB - 8 x HP 8GB 1Rx4 PC3-12800R</td>
<td>64 GB - 8 x HP 8GB 1Rx4 PC3-12800R</td>
<td>96 GB - 12 x HP 8GB 2Rx4 PC3L-10600R</td>
</tr>
<tr>
<td>3.6 TB - 4 x HP 900GB 6G SAS 10K 2.5in SC ENT HDD</td>
<td>1 TB - 2 x HP 500GB 6G SAS 10K 2.5in SC ENT HDD</td>
<td>45 TB - 15 x HP 3TB 6G SAS 7.2K 3.5in SC MDL HDD</td>
</tr>
<tr>
<td>1 x HP 512MB FBWC for P-Series Smart Array</td>
<td>1 x HP 512MB FBWC for P-Series Smart Array</td>
<td>1TB - 2 x HP 500GB 6G SATA 7.2K 2.5in SC MDL HDD</td>
</tr>
<tr>
<td>2 x HP dual port 10GbE</td>
<td>2 x HP dual port 10GbE</td>
<td>2 x HP 2GB P-series Smart Array FBWC</td>
<tr><td>
<td></td>
<td>2 x HP Smart Array P420i Mez Ctrllr FIO Kit</td>
</tr>
<tr><td>
<td></td>
<td>1 x HP 10G IO Module (2x1GbE 2x10GbE)</td>
</tr>
<table>


For more examples on Ceph Production Clusters, refer to: [http://www8.hp.com/h20195/v2/GetPDF.aspx/4AA5-2799ENW.pdf](http://www8.hp.com/h20195/v2/GetPDF.aspx/4AA5-2799ENW.pdf)


The following diagram depicts an example for the deployment of Helion OpenStack with Ceph Cluster 


<img src="media/helion-openstack-ceph-cluster-deployment-example"/)>



###Download and Access to the Solution Files and Documents {#Download-and-access}

[CODN](https://helion.hpwsportal.com) is a remote web catalog containing a repository of software that HP OpenStack Enterprise Customers can purchase.

To purchase software, register yourself (if this is your first time) to the CODN portal and then log in to download the required Helion OpenStack Ceph Storage Solution packages.

If you have any access issues with CODN, contact the HP sales team. 

Once you have the necessary permissions, log in with your credentials. Select the Category **Workloads**, and the Sub-Category **Storage** to find the HP Helion OpenStack Ceph Storage solution.

Each Ceph-related file is identified with the following description:

* Helion OpenStack Commercial integration with InkTank Ceph for Glance, Nova, and Cinder storage.



<a href="#top" style="padding:14px 0px 14px 0px; text-decoration: none;"> Return to Top &#8593; </a>