---
layout: default
title: "HP Helion OpenStack: Verifying the Install Using Embedded Tests"
permalink: /helion/openstack/install/tempest-tests/
product: commercial.ga
product-version1: HP Helion OpenStack 1.1
role1: Storage Administrator
role2: Storage Architect
authors: Michael B, Andrea F,


---
<!--UNDER REVISION-->


<script>

function PageRefresh {
onLoad="window.refresh"
}

PageRefresh();

</script>


<p style="font-size: small;"> &#9664; <a href="/helion/openstack/install/prereqs/#envars">Prerequisites | <a href="/helion/openstack/install/overview/test/"> &#9650; Installation Overview</a> </p> 

# HP Helion OpenStack&reg;: Verifying the Install Using Embedded Tests

A version of the upstream [Tempest](http://docs.openstack.org/developer/tempest/) integration tests  is pre-deployed in the undercloud. 

You can use these embedded tests to verify if the deployed overcloud is functional.

* [Running the tests](#running)
* [Disclaimer](#disclaimer)
* [Test results](#results)
* [Customizing the test run](#custom)
* [Known issues](#issues)
* [Known failures](#fail)
* [Disclaimer](#disclaimer)


## Running the tests ## {#running}

1. Login to the seed VM. 

2. SSH into the undercloud node:

		ssh heat-admin@${UNDERCLOUD_IP}
		sudo -i

3. Source the overcloud admin credentials, activate the virtual environment and start the tests:

		source ~root/overcloud.stackrc
		source /opt/stack/venvs/openstack/bin/activate
		run-tempest

## Test results ## {#results}

Tempest is deployed under `/opt/stack/tempest`. During a test run, test results are displayed on the console. A detailed log file is written to `/opt/stack/tempest/tempest.log`.

The results are also stored in the `testrespository` database. 

To access the results after the run:

1. Login to the seed VM. 

2. SSH into the undercloud node:

		ssh heat-admin@${UNDERCLOUD_IP}
		sudo -i

3. Change to the `tempest` directory and list test results:

		cd /opt/stack/tempest
		testr last

See [Test Repository users manual](https://testrepository.readthedocs.org/en/latest/) for more details on how to manage the test result repository.

## Customizing the test run ## {#custom}

There are several ways available to customize which tests will be executed.

### Run only the tests from a certain folder (and subfolders). For example you can run only Compute API tests:

1. Login to the seed VM. 

2. SSH into the undercloud node:

		ssh heat-admin@${UNDERCLOUD_IP}
		sudo -i

3. Execute the following command:

		OS_TESTPATH=./tempest/api/compute run-tempest

### Run only the tests matching a series of white and blacklists. 

To do so customize the content of `/opt/stack/tempest/tests2skip.txt`.

Documentation on the format of white and black-lists is available at http://git.openstack.org/cgit/openstack/tripleo-image-elements/tree/elements/tempest/tests2skip.py#n24. 


### Include all API tests

A good selection would only run api tests, and exclude tests that are less relevant for deployment validation, such as negative, admin, cli and thirdparty (EC2) tests:

+tempest\.api\.*

### Exclude all admin and negative tests

.*[Aa]dmin.*
.*[Nn]egative.*

### Exclude CLI and third party tests

tempest\.cli.*
tempest\.thirdparty\.*

### Run only the tests for certain services, and exclude specific features: tempest allows doing this via its configuration file. 

A sample configuration file with inline documentation is deployed under `/opt/stack/tempest/etc/tempest.conf.sample`.

See the `service_available` section to enable or disable tests which require a specific service. 

See the `*_feature_enabled` sections to enable or  disabled tests which require a specific feature of a specific service. 

## Known issues ## {#issues}

The following failing tests can be excluded from the test run by adding the following to the `tests2skip.txt file`:

### Exclude tests for features non available or test not compatible

* tempest\.api\.compute\.certificates\.*
* tempest\.api\.compute\.servers.test_disk_config\.*
* tempest\.api\.network\.test_fwaas_extensions\.*
* tempest\.api\.network\.test_vpnaas_extensions\.*
* tempest\.api\.network\.test_load_balancer\.*
* tempest\.api\.image\.v1\.test_image\.CreateRegisterImagesTest\.test_register_http_image
* tempest\.api\.image\.v1\.test_images\.CreateRegisterImagesTest\.test_register_remote_image
* tempest.api\.network\.test_metering_extensions\.MeteringTestJSON
* tempest\.api\.network\.test_metering_extensions\.MeteringIpV6TestJSON
* tempest\.api\.compute\.test_live_block_migration.LiveBlockMigrationTestJSON\.test_live_block_migration
* tempest\.api\.compute\.floating_ips\.test_list_floating_ips\.FloatingIPDetailsTestJSON\.test_list_floating_ip_pools

## Known failures ## {#fail}

The following known failures can be fixed by installing the `tempest-lib>=0.2.0` OpenStack Functional Testing Library.

See [tempest-lib 0.2.0](https://pypi.python.org/pypi/tempest-lib/0.2.0) for information on downloading the library.

* tempest\.api\.object_storage\.test_container_staticweb\.StaticWebTest\.test_web_index      
* tempest\.api\.object_storage\.test_container_staticweb\.StaticWebTest\.test_web_listing_css
* tempest\.api\.object_storage\.test_container_services\.ContainerTest\.test_update_container_metadata_with_delete_metadata
* tempest\.api\.object_storage\.test_container_services\.ContainerTest\.test_update_container_metadata_with_delete_metadata_key
* tempest\.api\.object_storage\.test_object_slo\.ObjectSloTest\.test_upload_manifest
* tempest\.api\.object_storage\.test_container_sync_middleware\.ContainerSyncMiddlewareTest\.test_container_synchronization


## Disclaimer ## {#disclaimer}

Running the tests requires access the overcloud identity admin credentials; it will create and delete test accounts and test resources for test purposes. 

In certain cases tempest may fail to clean-up some of test resources after a test is complete, for example in case of failed tests.

----