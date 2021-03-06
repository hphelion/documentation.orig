---
layout: default
title: "UNIX CLI for HP Helion Public Cloud: Performing Large File Uploads"
permalink: /cli/unix/articles/large
product: unix-cli
categories: cli linux unix
tags: large file upload download
published: false

---
<!--PUBLISHED-->
# UNIX CLI for HP Helion Public Cloud: Performing large file uploads v12.12#

___________________

###Important Notice###

On November 4, 2013, the UNIX CLI was moved into its End-of-Life Cycle process toward final deprecation. During this 6-month transition time:

* New and existing customers are encouraged to migrate to the OpenStackClient (Unified) CLIs or the OpenStack command-line clients for each respective service
* No new feature requests will be honored
* Bug reports will be accepted

HP Helion Public Cloud has contributed the Unix CLI back to the open source community, and you can get support, access the documentation, and download the source code [here](https://github.com/hpcloud/unix_cli).

_________________________________________

The UNIX CLI for HP Helion Public Cloud is the perfect way to upload large files.  This article contains some tuning and recovery tips about uploading large files.

If you upload files larger than 5 gigabytes (GB) with the Unix CLI, they are divided into 1 GB segments and a manifest file is created to reassemble the segments.  You can use the manifests file as you would any object and do not remove the segments.

* [Tuning](#Tuning)
* [Restarting an upload](#Restarting)
* [For more information](#articles)

##Tuning## {#Tuning}

There are several configuration settings you may need to tune by setting them with the [`config:set`](/cli/unix/reference#config:set) command when you upload or download large files:

* `read_timeout` : The timeout in seconds to complete a read (default 240 seconds)
* `write_timeout` : The timeout in seconds to complete a write (default 240 seconds)
* `storage_segment_size` : The size in bytes of each segment uploaded (default one gigabyte)
* `storage_chunk_size` : The size in bytes of chunks to write when uploading (default one megabyte)
* `storage_max_size` : The maximum size of a file before it needs a manifest (default five gigabytes)

For example, to reset your `write_timeout` value to three minutes instead of four, use the following command:

    hpcloud config:set write_timeout=240

Older versions of the CLI used fairly low `read_timeout` and `write_timeout` values, so you may want to set them if you older configuration files.  If you are on an unreliable connection, you may wish to set the segment size smaller so you can have a better chance of getting a segment uploaded.  The segment size works only for uploads.  A segment size larger than five gigabytes will fail.

In general, upload and download performance doesn't vary depending on the value of `storage_chunk_size`. However, if you have bad connectivity, resetting `storage_chunk_size` can be useful.

**Note**: If `storage_chunk_size` is set too large, you may receive a "Broken Pipe" error message because the large chunk fails to write.  In performance tests that we have run, there has not been much difference with different values of chunk size.

##Restarting an upload## {#Restarting}

If a large file fails to upload, you may retry it.  First you must clean up any partial segments.  List the segments:

    $  hpcloud list :databases -l
      +-------------------------------+------------+--...
      | sname                         | size       | t...
      +-------------------------------+------------+--...
      | ten_gig.db.segment.0000000001 | 1073741824 | a...
      | ten_gig.db.segment.0000000002 | 1073741824 | a...
      | ten_gig.db.segment.0000000003 | 4202023    | a...
      +-------------------------------+------------+--...

Remove the partial segment:

    $ hpcloud remove :databases/ten_gig.db.segment.0000000003
    Removed :databases/ten_gig.db.segment.0000000003

Now retry your upload with the `-r` option:

    $ hpcloud copy -r ten_gig.db :databases
    ten_gig.db: |====================================================|
    Copied ten_gig.db => :databases
    $


##For more information## {#articles}

For more tips and How-tos on using your UNIX CLI for HP Helion Public Cloud, see [UNIX CLI for HP Helion Public Cloud: Articles on to use the UNIX CLI for HP Helion Public Cloud](/cli/unix/articles/).
