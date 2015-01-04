# Trailmix Solo

A [knife solo](http://matschaffer.github.io/knife-solo/) implementation of the [trailmix](https://github.com/s2t2/trailmix) chef cookbook.

## Prerequisites

Obtain shell access to an Amazon Linux server hosted by [Amazon EC2](http://aws.amazon.com/ec2/). Optionally add an [EBS](http://aws.amazon.com/ebs/) database storage drive to `dev/sdb` during instance launch wizard configuration.

Optionally add deploy key files (*config*, *id_rsa*, and *id_rsa.pub*) for one or more github-hosted application source code repositories to */site-cookbooks/trailmix-solo/files/applications/APP_NAME/deploy_keys/*.

Add a node configuration file, like *my-node.com.json* to the */nodes* directory, specifying desired trailmix [attributes](https://github.com/s2t2/trailmix#attributes).

## Usage

### Initial Server Deployment

Install gems via [bundler](http://bundler.io/).

```` sh
bundle install
````

Install cookbooks via [librarian-chef](https://github.com/applicationsonline/librarian-chef).

```` sh
librarian-chef install
````

Administer node server according to knife solo workflow.

```` sh
knife solo prepare my-node.com
knife solo cook my-node.com
````

### Subsequent Server Deployments

```` sh
knife solo cook my-node.com
````
