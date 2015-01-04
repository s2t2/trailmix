# Trailmix Solo

Configures and deploys a [rails](http://guides.rubyonrails.org/) application server to support one or more applications and associated dependencies.

## Usage

Install gems via [bundler](http://bundler.io/) (`bundle install`).

Install [chef](https://www.chef.io/chef/) cookbook dependencies via [librarian-chef](https://github.com/applicationsonline/librarian-chef) (`librarian-chef install`).

Deploy configuration to a node server via [knife solo](https://github.com/matschaffer/knife-solo).

```` sh
knife solo prepare my-node.com
knife solo cook my-node.com
````

## Prerequisites

Obtain shell access to an Amazon Linux server hosted by [Amazon EC2](http://aws.amazon.com/ec2/). Add an [EBS](http://aws.amazon.com/ebs/) database storage drive to `dev/sdb` during EC2 instance launch wizard configuration.

Obtain deploy keys for one or more github-hosted application source code repositories, and add corresponding .ssh files (*config*, *id_rsa*, and *id_rsa.pub*) to */site-cookbooks/trailmix/files/applications/APP_NAME/deploy_keys/*.

Place a node configuration file into the */nodes* directory. Add desired recipes to the run list, and specify attribute values above the run list.

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

Key | Description | Datatype | Default Value
--- | --- | --- | ---
`node["deployer_email_address"]` | The email address to be notified upon deployment. | String | nil
`node["environment_variables"]` | A container for a list of environment variable key-value pairs. | Object | nil
`node["applications"]["APP_NAME"]["code"]["source_url"]` | A URL pointing to the application's source repository. | String | nil
`node["applications"]["APP_NAME"]["code"]["destination_path"]` | A file path pointing to the destination directory on the node where the source code will be stored. | String | nil

See the [Node Templates](/node_templates) directory for example usage of attributes in a node configuration file.

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
