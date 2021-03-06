---
layout: default
title: "Ruby Fog Bindings for HP Helion Public Cloud Block Storage Examples"
permalink: /bindings/fog/block-storage/
product: fog
published: false

---
<!--PUBLISHED-->
# Ruby Fog Bindings for HP Helion Public Cloud Block Storage Examples

##Important Notice##

Over the past two years, we have been a leading contributor of the Ruby Fog binding and have contributed to features that span Folsom to Havana. On November 4, 2013, the HP Helion Public Cloud extensions for Ruby Fog Bindings became a part of the standard Fog download available from the main [Fog repository](https://github.com/fog/fog).  This 'hpfog' gem contribution means you no longer need a special download to work with our cloud. We are working on transitioning all of our current documentation to the Ruby Fog community to be directly available in the Fog GitHub repository.
 
The Ruby Fog community has 100s of [active contributors](https://github.com/fog/fog/graphs/contributors) and we are looking forward to the further enhancements and features that are generated from this healthy community; a community that encourages collaboration and support.
 
Read our [blog post](http://www.hpcloud.com/blog/releasing-ruby-bindings-wild) to learn more about our work with Ruby Fog.

_______________

HP Helion Public Cloud Block Storage provides support for volumes and snapshots. A volume can store boot images, user data or both. They provide customers with persistent and flexible permanent storage. You can think of it as list of USB devices, that can be plugged in anywhere at will. Volumes can be attached to server instances and mounted. 

Snapshots are saved volume images at specific moments in time. You can take a snapshot of a volume and then use that snapshot to create a new volume.

The block storage provider has two abstractions - [a model layer](#ModelLayer) and [a request layer](#RequestLayer). Both layers are detailed below. The following code snippets can be executed from within a Ruby console (IRB):

        irb

This page discusses the following tasks:

* [Connecting to the Service](#ConnectingtotheService)
* [Volume Operations (Model Layer)](#ModelVolumeOperations)
* [Snapshot Operations (Model Layer)](#ModelSnapshotOperations)
* [Volume Operations (Request Layer)](#RequestVolumeOperations)
* [Snapshot Operations (Request Layer)](#RequestSnapshotOperations)

##Connecting to the Service## {#ConnectingtotheService}

To connect to the HP Helion Public Cloud Block Storage Service, follow these steps:

1. Enter IRB

        irb

2. Require the Fog library

        require 'fog'

3. Establish a connection to the HP Helion Public Cloud BlockStorage service

        conn = Fog::HP::BlockStorage.new(
               :hp_access_key  => "<your_ACCESS_KEY>",
               :hp_secret_key => "<your_SECRET_KEY>",
               :hp_auth_uri   => "<IDENTITY_ENDPOINT_URL>",
               :hp_tenant_id => "<your_TENANT_ID>",
               :hp_avl_zone => "<your_AVAILABILITY_ZONE>",
               <other optional parameters>
               )

**Note**: You must use the `:hp_access_key` parameter rather than the now-deprecated  `:hp_account_id` parameter you might have used in previous Ruby Fog versions.

You can find the values the access key, secret key, through the [HP Helion Public Cloud Console](https://horizon.hpcloud.com). Click the project menu and select *Account Info*.

##Using the Model Abstraction## {#ModelLayer}

<!--A description of what the model abstraction *is* would be good here-->

This section discusses the various operations you can perform using the model abstraction:

* [Volume Operations](#ModelVolumeOperations)
* [Snapshot Operations](#ModelSnapshotOperations)

###Volume Operations (Model Layer)### {#ModelVolumeOperations}

This section discusses the volume operations you can perform using the model abstraction.

1. List all available volumes for an account

        volumes = conn.volumes
        volumes.size   # returns no. of volumes
        # display volumes in a tabular format
        volumes.table([:id, :name, :status, :created_at])

2. Obtain the details of a particular volume

        volume = conn.volumes.get(volume_id)
        volume.name                         # returns name of the volume
        volume.created_at                   # returns the date the volume was created
        volume.status                        # returns the state of the volume e.g. available, in-use

3. List all available bootable volumes for an account

        bootable_volumes = conn.bootable_volumes
        bootable_volumes.size   # returns no. of bootable volumes
        # display bootable volumes in a tabular format
        bootable_volumes.table([:id, :name, :state, :created_at])

4. Obtain the details of a particular bootable volume

        volume = conn.bootable_volumes.get(volume_id)
        volume.name                         # returns name of the bootable volume
        volume.created_at                  # returns the date the bootable volume was created
        volume.status                        # returns the state of the bootable volume e.g. available, in-use

5. Create a new volume

        new_volume = conn.volumes.create(
               :name => "TestVolume",
               :description => "My Test Volume",
               :size => 1)
        new_volume.id       # returns the id of the volume
        new_volume.name     # => "TestVolume"
        new_volume.status    # returns the status of the volume e.g. creating, available
 
6. Create a new volume from an existing snapshot

        new_volume = conn.volumes.create(
               :name => "TestVolume",
               :description => "My Test Volume",
               :snapshot_id => 1,
               :size => 1)
        new_volume.id       # returns the id of the volume
        new_volume.snapshot_id       # returns the snapshot_id of the volume
        new_volume.name     # => "TestVolume"
        new_volume.status    # returns the status of the volume e.g. creating, available
**Note**: The size of the volume you create from a snapshot is the same as that of the snapshot. The `:size` parameter has no effect in this case.

7. Create a new bootable volume from an suitable single-part image

        new_volume = conn.bootable_volumes.create(
               :name => "BootVolume",
               :description => "My Boot Volume",
               :image_id => 11111,
               :size => 10)
        new_volume.id       # returns the id of the volume
**Note**: You can use a bootable volume to create a persistent server instance.

8. Attach an existing volume to an existing server

        volume = conn.volumes.get(volume_id)
        volume.attach(server_id, device)
        # => true
**Note**: The device parameter is the mount point on the server instance to which the volume is attached (for example, `/dev/sdf`).

9. Detach an existing volume

        volume = conn.volumes.get(volume_id)
        volume.detach
        # => true

10. Delete an existing volume

        volume = conn.volumes.get(volume_id)
        volume.destroy
        # => true

###Snapshot Operations (Model Layer)### {#ModelSnapshotOperations}

This section discusses the snapshot operations you can perform using the model abstraction.

1. List all available snapshots for an account

        snapshots = conn.snapshots
        snapshots.size   # returns no. of snapshots
        # display snapshots in a tabular format
        conn.snapshots.table([:id, :name, :state, :created_at])

2. Obtain the details of a particular snapshot

        snapshot = conn.snapshots.get(snapshot_id)
        snapshot.name                       # returns name of the volume
        snapshot.created_at                   # returns the date the volume was created
        snapshot.status                        # returns the state of the volume e.g. available

3. Create a new snapshot

        new_snapshot = conn.snapshots.create(
               :name => "TestVolume",
               :description => "My Test Volume",
               :volume_id => 1)
        new_snapshot.id       # returns the id of the volume
        new_snapshot.name     # => "TestVolume"
        new_snapshot.volume_id     # => 1
        new_snapshot.status    # returns the status of the volume e.g. creating, available

4. Delete an existing snapshot

        snapshot = conn.snapshots.get(snapshot_id)
        snapshot.destroy
        # => true

##Using the Request Abstraction## {#RequestLayer}

This section discusses the various operations you can perform using the request abstraction:

* [Volume Operations (Request Layer)](#RequestVolumeOperations)
* [Snapshot Operations (Request Layer)](#RequestSnapshotOperations)

###Volume Operations (Request Layer)### {#RequestVolumeOperations}

This section discusses the volume operations you can perform using the request abstraction.

1. List all available volumes for an account

        response = conn.list_volumes
        response.body['volumes']                    # returns an array of volume hashes
        response.headers                            # returns the headers
        response.body['volumes'][0]['displayName']         # returns the name of the volume

2. Obtain the details of a particular volume

        response = conn.get_volume_details(volume_id)
        volume = response.body['volume']
        volume['displayName']                  # returns the name of the volume
        volume['size']                               # returns the size of the volume
        volume['status']                            # returns the status of the volume e.g. available, in-use

3. List all available bootable volumes for an account

        response = conn.list_bootable_volumes
        response.body['volumes']                    # returns an array of bootable volume hashes
        response.headers                            # returns the headers
        response.body['volumes'][0]['displayName']         # returns the name of the bootable volume

4. Obtain the details of a particular bootable volume

        response = conn.get_bootable_volume_details(volume_id)
        volume = response.body['volume']
        volume['displayName']                  # returns the name of the bootable volume
        volume['size']                               # returns the size of the bootable volume
        volume['status']                            # returns the status of the bootable volume e.g. available, in-use

5. Create a new volume

        response = conn.create_volume("demo-vol", "demo-vol-desc", 1)
        volume = response.body['volume']
        volume['id']                                # returns the id of the new volume
        volume['displayName']                # => "demo-vol"
        volume['size']                             # => 1
        volume['status']                          # returns the status of the volume e.g. creating, available

6. Create a new volume from an existing snapshot

        response = conn.create_volume("demo-vol", "demo-vol-desc", 1, {'snapshot_id' => 1})
        volume = response.body['volume']
        volume['id']                                # returns the id of the new volume
        volume['displayName']                # => "demo-vol"
        volume['size']                             # => 1
        volume['snapshot_id']                 # => 1
        volume['status']                          # returns the status of the volume e.g. creating, available
**Note**: The size of the volume you create from a snapshot is the same as that of the snapshot. The third parameter (the size) has no effect in this case.

7. Create a new bootable volume from an suitable single-part image

        new_volume = conn.create_volume("TestBootVol", 
                                                        "My Test Boot Volume", 
                                                        10, 
                                                        {"imageRef" => "1111111"}
                                                     )
        new_volume.id       # returns the id of the volume
**Note**: You can use a bootable volume to create a persistent server instance.

8. Attach an existing volume to an existing server

        response = conn.compute.attach_volume(server_id, volume_id, device)
        volume_attachment = response.body['volumeAttachment']
        volume_attachment['id']       # returns the id of the volume
        volume_attachment['volumeId']  # returns the id of the volume
**Note**: The device parameter is the mount point on the server instance to which the volume is attached (for example, `/dev/sdf`)

9. List volumes attached to a server

        response = conn.compute.list_server_volumes(server_id)
        volume_attachments = response.body['volumeAttachments']
        volume_attachment[0]['id']       # returns the id of the volume
        volume_attachment[0]['volumeId']  # returns the id of the volume
        volume_attachment[0]['device']  # returns the device of the volume

10. Detach an existing volume

        conn.detach_volume(server_id, volume_id)

11. Delete an existing volume

        conn.delete_volume(volume_id)

###Snapshot Operations### {#RequestSnapshotOperations}

This section discusses the snapshot operations you can perform using the request abstraction.

1. List all available snapshots for an account

        response = conn.list_snapshots
        response.body['snapshots']                    # returns an array of snapshot hashes
        response.headers                            # returns the headers
        response.body['snapshots'][0]['displayName']         # returns the name of the snapshot
        response.body['snapshots'][0]['size']                       # returns the size of the snapshot
        response.body['snapshots'][0]['volumeId']               # returns the volume id of the snapshot

2. Obtain the details of a particular snapshot

        response = conn.get_snapshot_details(snapshot_id)
        snapshot = response.body['snapshot']
        snapshot['displayName']                  # returns the name of the snapshot
        snapshot['size']                               # returns the size of the snapshot
        snapshot['volumeId']                        # returns the volume id of the snapshot
        snapshot['status']                            # returns the status of the snapshot e.g. available, in-use

3. Create a new snapshot

        response = conn.create_snapshot("demo-snap", "demo-snap-desc", 1)
        snapshot = response.body['snapshot']
        snapshot['id']                                # returns the id of the new volume
        snapshot['displayName']                # => "demo-vol"
        snapshot['size']                             # => 1
        snapshot['volumeId']                        # returns the volume id of the snapshot
        snapshot['status']                          # returns the status of the snapshot e.g. creating, available

4. Delete an existing snapshot

        conn.delete_snapshot(snapshot_id)
