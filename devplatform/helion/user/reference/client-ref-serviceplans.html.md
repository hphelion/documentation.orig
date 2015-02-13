---
layout: default-devplatform
title: "Application Lifecycle Service Client Command Reference"
permalink: /als/v1/user/reference/client-ref/serviceplans/
title: "Application Lifecycle Service Command Line Client Reference: Service Plans"
product: devplatform
product-version1: HP Helion Development Platform
product-version2: HP Helion Development Platform 1.1
role1: Application Developer 
role2: ISV Developer
role3: Service Developer
role4: Systems Administrator
writer: Jayme P

---
<!--UNDER REVISION-->

# HP Helion Development Platform: ALS Command Reference: Service Plans

- [helion hide-service-plan](#command-hide-service-plan): Hide the specified service-plan from the named organization.
- [helion service-plan](#command-service-plan): Show the details of the specified service plan
- [helion service-plans](#command-service-plans): List all available plans of the supported services
- [helion show-service-plan](#command-show-service-plan): Make the specified service plan visible to the named organization.
- [helion update-service-plan](#command-update-service-plan): Update the target's knowledge of the named service plan.

##Syntax

	helion [options] command [arguments] [command-options]
For more information, use the **helion help**, **helion help [*command*]**, or **helion options** commands.

<hr>
      
## helion hide-service-plan  <*name*> <*organization*> {#command-hide-service-plan}      
Hide the specified service-plan from the named organization.
	    
<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
<td style="width: 200px;"><b>Option</b></td><td><b>Description</b></td>
</tr>
<tr><td>--provider</td><td>The service provider. Use this to disambiguate between multiple providers of the same vendor/type.</td></tr>
<tr><td>--target</td>
<td>The once-off target to use for the current operation.</td>
</tr>    <tr><td>--token</td>
<td>The once-off authentication token to use for the current
operation.</td>
</tr>    <tr><td>--token-file</td>
<td>Path to an existing and readable file containing the targets and
authorization tokens.</td>
<tr><td>--vendor</td><td>Name of the service type the specified plan belongs to.</td></tr>
<tr><td>--version</td><td>The service version. Use this to disambiguate between multiple versions of the same vendor/type.</td></tr>
</tr>
</table>

## helion service-plan <*name*> {#command-service-plan}       
Show the details of the specified service plan.

<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
<td style="width: 200px;"><b>Option</b></td><td><b>Description</b></td>
</tr><tr><td>--json</td><td>Print raw json as output, not human-formatted data.</td></tr>
<tr><td>--provider</td><td>The service provider. Use this to disambiguate between multiple providers of the same vendor/type.</td></tr><tr><td>--target</td>
<td>The once-off target to use for the current operation.</td>
</tr>    <tr><td>--token</td>
<td>The once-off authentication token to use for the current
operation.</td>
</tr>    <tr><td>--token-file</td>
<td>Path to an existing and readable file containing the targets and
authorization tokens.</td>
</tr>
<tr><td>--vendor</td><td>Name of the service type the specified plan belongs to.</td></tr>
<tr><td>--version</td><td>The service version. Use this to disambiguate between multiple versions of the same vendor/type.</td></tr>
</table>

## helion service-plans {#command-service-plans}     
List all available plans of the supported services.

<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
<td style="width: 200px;"><b>Option</b></td><td><b>Description</b></td>
</tr><tr><td>--json</td><td>Print raw json as output, not human-formatted data.</td></tr>
<tr><td>--target</td>
<td>The once-off target to use for the current operation.</td>
</tr>    <tr><td>--token</td>
<td>The once-off authentication token to use for the current
operation.</td>
</tr>    <tr><td>--token-file</td>
<td>Path to an existing and readable file containing the targets and
authorization tokens.</td>
</tr>
</table>

## helion show-service-plan <*name*> <*organization*> {#command-show-service-plan}       
Make the specified service plan visible to the named organization.

<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
<td style="width: 200px;"><b>Option</b></td><td><b>Description</b></td>
</tr><tr><td>--provider</td><td>The service provider. Use this to disambiguate between multiple providers of the same vendor/type.</td></tr>
<tr><td>--target</td>
<td>The once-off target to use for the current operation.</td>
</tr>    <tr><td>--token</td>
<td>The once-off authentication token to use for the current
operation.</td>
</tr>    <tr><td>--token-file</td>
<td>Path to an existing and readable file containing the targets and
authorization tokens.</td>
</tr>
<tr><td>--vendor</td><td>Name of the service type the specified plan belongs to.</td></tr>
<tr><td>--version</td><td>The service version. Use this to disambiguate between multiple versions of the same vendor/type.</td></tr>
</table>

## helion update-service-plan <*name*> <*NewName*> {#command-update-service-plan}     
Update the target's knowledge of the named service plan.
	
<table style="text-align: left; vertical-align: top; width:650px;">
<tr style="background-color: #C8C8C8;">
<td style="width: 200px;"><b>Option</b></td><td><b>Description</b></td>
</tr>
<tr><td>--description</td><td>Change the plan's description.</td></tr>
<tr><td>--free</td><td>Mark the plan as free.</td></tr>
<tr><td>--no-free</td><td>Complementary alias of --free.</td></tr>
<tr><td>--no-public</td><td>Complementary alias of --public.</td></tr>
<tr><td>--public</td><td>Mark the plan as globally public.</td></tr>
<tr><td>--provider</td><td>The service provider. Use this to disambiguate between multiple providers of the same vendor/type.</td></tr>
<tr><td>--target</td>
<td>The once-off target to use for the current operation.</td>
</tr>    <tr><td>--token</td>
<td>The once-off authentication token to use for the current
operation.</td>
</tr>    <tr><td>--token-file</td>
<td>Path to an existing and readable file containing the targets and
authorization tokens.</td>
</tr>
<tr><td>--vendor</td><td>Name of the service type the specified plan belongs to.</td></tr>
<tr><td>--version</td><td>The service version. Use this to disambiguate between multiple versions of the same vendor/type.</td></tr>
</table>