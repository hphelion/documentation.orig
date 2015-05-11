---
layout: default
title: "HP Helion OpenStack&#174; Carrier Grade (Alpha): Administrators Guide"
permalink: /helion/openstack/carrier/admin/
product: carrier-grade
product-version1: HP Helion OpenStack
product-version2: HP Helion OpenStack 1.1
role1: All

authors: Paul F

---
<!--UNDER REVISION-->

<script>

function PageRefresh {
onLoad="window.refresh"
}

PageRefresh();

</script>

<!-- <p style="font-size: small;"> <a href="/helion/openstack/1.1/3rd-party-license-agreements/">&#9664; PREV</a> | <a href="/helion/openstack/1.1/">&#9650; UP</a> | NEXT &#9654; </p> -->

# HP Helion OpenStack&#174; Carrier Grade (Alpha): Administrators Guide 

Use the following links for information on administrative tasks you can perform for the HP Helion OpenStack Carrier Grade:

## Administering the HP Helion OpenStack Region

For information on the administrative tasks you can perform in the HP Helion OpenStack region, see [Administering the HP Helion OpenStack Region](/helion/commercial/carrier/dashboard/managing/admin/)

<!-- Hiding for alpha
(/helion/openstack/carrier/admin/helion/).
-->

## Adding Cinder Storage

You can install 

## Migrating Virtual Machines

Live migration occurs when a virtual machine is transferred to execute on a different compute node with minimal disruption of the guest applications. This can happen automatically, or upon request by the system administrator.

For more information, see [Cold Migrate an Instance](/helion/commercial/carrier/dashboard/managing/instances/migrate/cold/) and [Live Migration of Virtual Machines](/helion/commercial/carrier/dashboard/managing/instances/migrate/live/).

## Scaling Virtual Machine Resources

You can scale the resources of individual instances up or down. Currently, the CPU resources for an instance are scalable.

For more information, see [Scaling Virtual Machine Resources](/helion/commercial/carrier/dashboard/managing/instances/scaling/).

## Virtual Machines and Carrier-Grade Availability

The Wind River Linux servers in HP Helion OpenStack Carrier Grade provide a health monitoring mechanism that can be used to implement and support the deployment of guest applications in Carrier-Grade High Availability (HA) mode.

<hr>
**Note:** This feature applies to the Wind River Linux servers only.
<hr>

For more information, see [Virtual Machines and Carrier-Grade Availability](/helion/openstack/carrier/admin/carrier-grade-avail/).

## Managing Stacks

You can create and manage collections of resources, or services (also known as stacks), using the Orchestration (Heat) service. 

With Heat, you can define a service configuration in a template file, and then apply the template to create or modify the service resources and connections.

The Orchestration layer includes life-cycle management features to simplify the addition, modification, and deletion of services.

The Wind River Linux servers include extensions for enhanced scope and reliability.

For more information, see 


<!-- Hide for alpha
- [Troubleshooting](/helion/openstack/carrier/services/troubleshooting/)

## Administering the HP Helion OpenStack Carrier Grade using Helion Lifecycle Management

Using HLM, you can install and upgrade HP Helion OpenStack Carrier Grade and do....

For information on the administrative tasks you can perform using HLM, see [Using Helion Lifecycle Management](/helion/openstack/carrier/admin/hlm/).

## Administering HP Helion OpenStack Carrier Grade

For information on the administrative tasks you can perform in the HP Helion OpenStack region, see [Administering the HP Helion OpenStack Region](/helion/openstack/carrier/admin/helion/)



## Administering HP Distributed Cloud Networking (DCN)

Using DCN, you can install and upgrade HP Helion OpenStack Carrier Grade and do...

For information on the administrative tasks you can perform using DCN, see [Administering HP Distributed Cloud Networking (DCN)](/helion/openstack/carrier/admin/dcn/).

## Administering the Wind River Linux Region

For information on the administrative tasks you can perform in the WindRiver region, see [Administering the WindRiver Region](/helion/openstack/carrier/admin/wr/)

-->

<a href="#top" style="padding:14px 0px 14px 0px; text-decoration: none;"> Return to Top &#8593; </a>
 
----