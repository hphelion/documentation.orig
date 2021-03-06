---
layout: default-devplatform
title: "HP Helion 1.2 Development Platform: Windows Overview"
permalink: /helion/devplatform/preview/
product: devplatform
product-version1: HP Helion Development Platform
product-version2: HP Helion Development Platform 1.2
role1: Systems Administrator 
role2: System Engineer
role3: Cloud Administrator
role4: Network Administrator
role5: Application Developer
Role6: Security Engineer
role7: Application Developer 
role8: ISV Developer
role9: Service Developer
authors: Patrick F
publish: false
---
<!--PUBLISHED-->

# HP Helion 1.2 Development Platform Preview: Windows Overview

<span style="font-size:70%">*Windows, .NET, SQL Server, and IIS are either registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.*</span>

<span style="color:red">**Note**: Helion Development Platform 1.2 is currently only available on HP Helion Public Cloud as part of the Developer Preview</span>

Helion Development Platform  version 1.2 includes a full end-to-end solution for creating and deploying .NET Framework applications. Windows developers can now leverage their knowledge and use the tools they are accustomed to in order to leverage the power of Helion Development Platform. HTTP-based .NET applications that follow the <a href="http://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html">Cloud Foundry application model</a> are a great fit for this feature support.

This document contains the following sections:

* [Overview](#overview)
* [Supported .NET Application Types](#apps)
* [SQL Server Support](#sql)
* [Windows Tools](#tools)
* [Process](#process)
* [Software Requirements](#softwarerequirements)
* [Next Steps](#nextsteps)

## Overview {#overview}

Helion Development Platform version 1.2 adds tools for creating instances of Windows Server 2012 R2 to a Helion OpenStack environment, and Visual Studio components for deploying .NET HTTP-based applications to those server instances. Benefits of Windows/.NET support include:

* Organizations can run their .NET server applications in the same Helion OpenStack environment as their Linux applications.
* A consistent tooling experience for deploying Windows and Linux applications: The same <a href="/helion/devplatform/preview/tools_guide#helion">application deployment tools</a> can be used for both Windows and Linux deployments.
* Additional developer tools, including an SDK for programmatic access to services, and a <a href="/helion/devplatform/preview/tools_guide#cloudfoundryexplorer">Visual Studio extension</a> for deploying and managing applications.
* Feature-rich application sandboxing, including memory and CPU management, and application isolation. This allows applications to coexist within a single ALS cluster, saving the overhead of running a separate operating system for each application.
* Support for creating Windows instances that include Microsoft SQL Server Express. 
* Integrated buildpack support for building applications with dependencies and services.

Windows and .NET support is enabled by adding this functionality to an existing Helion Development Platform 1.2 installation.

For the 1.2 release, we support creating the following types of instances:

* Windows Server 2012 R2 with DEA (Droplet Execution Agent) role
* Windows Server 2012 R2 with SQL Server 2012 Express
* Windows Server 2012 R2 with SQL Server 2014 Express

Helion Development Platform treats deployment of .NET applications in the same way as Linux applications (such as Java or PHP appplications). .NET applications require a <a href="/helion/devplatform/1.2/windows/buildpack/">buildpack</a> to specify the dependencies and <a href="/helion/devplatform/preview/adding_services/">services</a> that can be bound to the application. .NET applications are deployed into a sandbox environment similar to Warden in Cloud Foundry. 

## Supported .NET Application Types {#apps}

Helion Development Platform supports HTTP-based applications, including ASP.NET and WCF. Design considerations for Windows DEA applications are the same as for <a href="http://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html">Cloud Foundry</a> applications. 

Helion Development Platform provides an integrated IIS buildpack which supports the following technologies:

* IIS 8
* .NET 2.0-4.5.2
* ASP.NET Web Forms
* ASP.NET WebAPI v1 and v2
* ASP.NET MVC 2 through 5 with Entity Framework 6
* ASP.NET SignalR
* WCF services

## SQL Server Support {#sql}

Helion Development Platform 1.2 supports SQL Server Express 2012 and SQL Server Express 2014. SQL Server support is enabled by creating a SQL Server service using the SQL Server broker. Each application that binds to the SQL Server service will create a new database and service credentials. The service credentials get created and can be accessed either from the <code>web.config</code> file, or programatically through the <code>VCAP_SERVICES</code> environment variable.

## Windows Tools {#tools}

In order to run .NET framework applications, Helion Development Platform requires that Windows DEA nodes be deployed. The tools used to create and deploy Windows DEA nodes, and to deploy .NET Framework applications, include the following:

### Management tool set:

* ALS Client (*helion*): This tool deploys .NET applications (run with the <code>--stack win2012r2</code> switch). The ALS client can deploy Windows applications from Windows, Linux, or MacOS X environments.

### .NET tool set: 

* Cloud Foundry Explorer: This Visual Studio extension performs simple management tasks such as starting or stopping an application, deleting a service, or renaming a route.
* Cloud Foundry MSBuild tasks: These MSBuild processes allow you to build and deploy .NET applications as part of the usual build process for your application.
* Cloud Foundry .NET SDK: These libraries allow you to programmatically interact with the Cloud Foundry APIs.

For more information about downloading and using these tools, see <a href="/helion/devplatform/preview/tools_guide">Windows and .NET Tools Guide</a>.

## Process {#process}

At a high level, running .NET applications in Helion Development Platform involves the following process:

1. Install the Cloud Foundry Explorer in Visual Studio for deploying and managing applications. Alternately, the Cloud Foundry MSBuild tasks or Helion Client can be used for deployment instead.
2. Build your application.
3. Deploy your application using either Visual Studio, the MSBuild tasks, or the Helion client.

## Software Requirements {#softwarerequirements}

Windows support in Helion Development Platform has software requirements including the following:

* An HP Helion Public Cloud account. To try HP Helion Public Cloud, see <a href="http://www.hpcloud.com/cloud-credit">HP Cloud Signup</a>.
* If applications are to be deployed and managed from the development environment, any edition of Visual Studio 2013, including the Community (free) edition, is needed.
* The <a href="/helion/devplatform/preview/tools_guide/#cloudfoundryexplorer">Cloud Foundry  Visual Studio extension</a>. This extension can be found by searching for **Cloud Foundry Explorer** in the *Extensions and Updates* module of Visual Studio.

## Next Steps {#nextsteps}

* <a href="/helion/devplatform/preview/deployingnet">Deploying your first .NET application</a> 
* <a href="/helion/devplatform/preview/tools_guide">Windows and .NET Tools Guide</a>
* <a href="/helion/devplatform/preview/adding_services/">Adding Services to a Windows Application</a> 
* <a href="/helion/devplatform/preview/buildpack/">Deploying Windows Applications with the IIS Buildpack</a>











