# Trailmix Solo

A [knife solo](http://matschaffer.github.io/knife-solo/) implementation of the [trailmix](https://github.com/s2t2/trailmix) chef cookbook.

## Prerequisites

1. Obtain shell access to a fresh server, perhaps from a service like [Amazon EC2](http://aws.amazon.com/ec2/).

## Usage

Administer a server according to knife solo workflow.

```` sh
knife solo prepare my-node.com
knife solo cook my-node.com
````
