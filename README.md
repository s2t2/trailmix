# Trailmix Solo

A [knife solo](http://matschaffer.github.io/knife-solo/) implementation of the [trailmix](https://github.com/s2t2/trailmix) chef cookbook.

## Prerequisites

Obtain shell access to an Amazon Linux server hosted by [Amazon EC2](http://aws.amazon.com/ec2/).

Install gems via [bundler](http://bundler.io/).

```` sh
bundle install
````

Install cookbooks via [librarian-chef](https://github.com/applicationsonline/librarian-chef).

```` sh
librarian-chef install
````

## Usage

Add a node configuration file, like *my-node.com.json* to the */nodes* directory, specifying desired trailmix [recipes and attributes](https://github.com/s2t2/trailmix#recipes-and-attributes).

Administer node server according to knife solo workflow.

```` sh
knife solo prepare my-node.com
knife solo cook my-node.com
````
