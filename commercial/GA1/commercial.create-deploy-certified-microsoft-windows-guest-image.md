---
layout: default
title: "How to build a certified Microsoft Windows 2012 guest image for HP Helion OpenStack "
permalink: /helion/openstack/create-deploy/certified-microsoft-windows/guest-image/
product: commercial.ga

---
<!--UNDER REVISION-->


<script>

function PageRefresh {
onLoad="window.refresh"
}

PageRefresh();

</script>

<!---
<p style="font-size: small;"> <a href="/helion/openstack/install-beta/kvm/">&#9664; PREV</a> | <a href="/helion/openstack/install-beta-overview/">&#9650; UP</a> | <a href="/helion/openstack/install-beta/esx/">NEXT &#9654;</a> </p> -->


# How to build a certified Microsoft Windows 2012 guest image for HP Helion OpenStack 

This page describes the procedure to create and deploy Microsoft Windows 2012 Server on HP Helion OpenStack.

## HP Helion OpenStack with Microsoft Windows Server Reference Architecture (RA)


HP Helion OpenStack is HPs hardened, tested, enterprise-grade distribution of OpenStack cloud software, designed to deliver the best open source cloud computing technology in a stable, maintainable and manageable package. It offers a number of value-added services that complement and enhance OpenStack technologies.
This document describes how to create a Microsoft Windows Server 2012 or 2012 R2 image for deployment within HP Helion OpenStack. This paper also introduces you to the software architecture of HP Helion OpenStack.
The Microsoft Windows Server images can be created on a 64-bit workstation running Ubuntu 13.10 or higher on physical hardware that supports KVM.

For more information about how to deploy HP Helion OpenStack, see: [http://docs.hpcloud.com/helion/openstack/.](http://docs.hpcloud.com/helion/openstack/.)

##Create and deploy a Microsoft Windows 2012 Server on HP Helion OpenStack

To create a Microsoft Windows Server 2012 guest image, follow these steps:

1.	**Download Windows Server 2012 or Windows Server 2012 R2** <br> 
Download the Windows Server 2012 or Windows Server 2012 R2 installation ISO. Evaluation images are available on the [Microsoft website]([http://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2012](http://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2012)) (registration required).

2.	**Create the qcow2 image file** <br>
You can use the `qemu-img` command with the create switch to create the initial image file, for example:

		qemu-img create -f qcow2 ws2012.qcow2 15G

	In this example, a 15GB qcow2 disk image file is created and is named ws2012.qcow. In most cases 15GB is adequate for an operating system only install. If you expect the Windows Server 2012 disk image to increase in size, you can specify a larger value.


3.	**Start the Windows Server 2012 installation with the virt-install command** <br>
The `virt-install` command can be used to install a new guest operating system on a disk image file. `virt-install` is part of the `virtinst` package. To install the `virtinst` package, type the following command, and then press Enter:

		Sudo apt-get install virtinst

	In the following example, the `virt-install` command is used to install Windows Server 2012 on the disk image that you created earlier in Step 2:

		virt-install --connect qemu:///system --name ws2012 --ram 2048 --vcpus 2 --network network=default,model=rtl8139 --disk path=ws2012.qcow2,format=qcow2,device=disk,bus=ide --cdrom <path_to_windows_2012_r2_iso> --vnc --os-type windows --os-variant win2k8

	Where:<br>
 	--name: The name of the Windows Server 2012 virtual machine.<br>
	--ram: The amount of RAM. <br>
	--vcpus: The number of virtual cpus. <br>
	--network: The type of network interface. <br>
	--disk: Path to the disk image (ide bus in the example above). <br>
	--cdrom: Path to operating system .iso file. <br>
	--vnc: Used for console connections. <br>
	--os-type: Operating system type. <br>
	--os-variant: (Optional) Used to specify an operating system variant. <br>

	You can use `virt-manager` or `virt-viewer` to connect to the VMs console and start the windows installation. Make sure that you shut down the windows guest image after the installation is complete.


4.	**Upload the qcow2 image to glance**<br>
You can use the glance `image-create` command to upload the Windows Server 2012 image to glance, for example:

		glance image-create --name WS2012 --disk-format qcow2 --container-format bare -is-public true --file ws2012.qcow2

5.	**Set metadata properties to the glance image**<br>
You can add useful metadata information to the image, such as operating system information or hardware details by using the glance image-update command, for example:

		glance image-update WS2012 --property os_type=windows --property hw_disk_bus=ide --property hw_vif_model=rtl8139


##More information

HP Helion Professional Services are available to assist you along each step of your cloud journey, from helping you define your business needs to deploying Microsoft Windows Server compute nodes within your HP Helion OpenStack cloud. As your trusted advisor, we will show you how to get started, the steps you will take to achieve your desired business outcomes, and - once it's up and running - we will show you how to support and scale your cloud based on best practices gained in operating one of the world’s largest OpenStack clouds and thousands of customer cloud deployments.

###Learn more at:

* [hp.com/helion/](http://www8.hp.com/us/en/cloud/helion-overview.html)
* [docs.hpcloud.com/helion/openstack/](http://docs.hpcloud.com/helion/openstack/)
* [docs.openstack.org/](http://docs.openstack.org/)



<a href="#top" style="padding:14px 0px 14px 0px; text-decoration: none;"> Return to Top &#8593; </a>

----