# Trailmix

A [knife solo](http://matschaffer.github.io/knife-solo/) cookbook of [chef](https://learn.chef.io/) recipes to configure and automate server administration tasks.

## Prerequisites

1. Obtain shell access to a fresh server, perhaps from a service like [Amazon EC2](http://aws.amazon.com/ec2/).

## Configuration

Trailmix Recipes are modular. Include desired recipes in the node's run list, like so:

```` js
{
  "deployer_email_address":"YOUR_EMAIL@gmail.com",
  "run_list":[
    "trailmix::default",
    "trailmix::deploy"
  ]
}
````

## Usage

Administer a server according to knife solo workflow.

```` sh
knife solo prepare my-node.com
knife solo cook my-node.com
````
