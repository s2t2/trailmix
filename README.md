# Trailmix Solo

A [chef](https://www.chef.io/chef/) cookbook of recipes to deploy and manage a production environment for one or more [Ruby on Rails](http://guides.rubyonrails.org/) applications.

## Usage

Install gems via [bundler](http://bundler.io/).

```` sh
bundle install
````

Install cookbooks via [librarian-chef](https://github.com/applicationsonline/librarian-chef).

```` sh
librarian-chef install
````

Place a node configuration file, like *my-node.com.json* into the */nodes* directory, select desired recipes by adding them to the run list, and specify attribute values above the run list.

See the [Recipes](/#recipes) section of this document for a description of recipe functionality, and the attributes [Attributes](/#attributes) section for a comprehensive list of available attributes.

See the [Node Templates](/node_templates) directory for example node configuration files.

Deploy node server via [knife solo](https://github.com/matschaffer/knife-solo).

```` sh
knife solo prepare my-node.com
knife solo cook my-node.com
````

## Prerequisites

Obtain shell access to an Amazon Linux server hosted by [Amazon EC2](http://aws.amazon.com/ec2/). Add an [EBS](http://aws.amazon.com/ebs/) database storage drive to `dev/sdb` during EC2 instance launch wizard configuration.

Obtain deploy keys for one or more github-hosted application source code repositories, and add corresponding .ssh files (*config*, *id_rsa*, and *id_rsa.pub*) to */site-cookbooks/trailmix/files/applications/APP_NAME/deploy_keys/*.

## Recipes

#### trailmix::applications

Deploys application(s) from github-hosted source according to `node["applications"]["APP_NAME"]["code"]` attribute configuration.

#### trailmix::crontab

Clears the [crontab](http://crontab.org/). Adds application-specific cron entries to the crontab according to `node["applications"]["APP_NAME"]["scheduled_rake_tasks"]` attribute configuration.

#### trailmix::deployment_message

Sends an email to the deployer upon server deployment. If including this recipe in your run list, it should take the last position.

#### trailmix::environment_variables

Adds environment variables according to `node["environment_variables"]` attribute configuration.

Adds application-specific environment variables according to `node["applications"]["APP_NAME"]["environment_variables"]` attribute configuration.

#### trailmix::mail

Installs and configures the [sendmail](https://www.freebsd.org/cgi/man.cgi?sendmail%288%29) service to allow email to be sent from the node.

#### trailmix::messages

Creates a directory for storing email message file templates. Uploads mail files to be used by other recipes.

## Attributes

The table below represents a comprehensive list of acceptable node attributes.

Key | Datatype | Description | Default Value
--- | --- | --- | ---
`node["deployer_email_address"]` | String | The email address to be notified upon deployment. | nil
`node["environment_variables"]` | Object | A container for a list of environment variable key-value pairs. | nil
`node["applications"]` | Object | A container for a list of applications by name. | nil
`node["applications"]["APP_NAME"]` | Object | A container for application-specific attributes. Replace `APP_NAME` with the name of your application. | nil
`node["applications"]["APP_NAME"]["code"]` | Object | A container for attributes related to the application's source code. | nil
`node["applications"]["APP_NAME"]["code"]["source_url"]` | String | A URL pointing to the application's source repository. | nil
`node["applications"]["APP_NAME"]["code"]["destination_path"]` | String | A file path pointing to the destination directory on the node where the source code will be stored. | nil

## Contributing

Communicate comments, questions, and requests via [GitHub Issues](https://github.com/s2t2/trailmix/issues), and submit pull requests according to [GitHub Workflow](https://guides.github.com/introduction/flow/index.html).

## License and Author

Author: [MJ Rossetti (@s2t2)](mailto:s2t2mail@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
