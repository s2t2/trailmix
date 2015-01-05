# trailmix Cookbook

Configures a production server and deploys one or more rails applications

## Recipes

#### applications

Deploys application(s) from github-hosted source.

#### crontab

Clears the [crontab](http://crontab.org/). Adds application-specific cron entries to the crontab.

#### deployment_message

Sends an email to the deployer upon server deployment. If included in a run list, this recipe should assume the last position.

#### environment_variables

Adds global and application-specific environment variables.

#### mail

Installs and configures the [sendmail](https://www.freebsd.org/cgi/man.cgi?sendmail%288%29) service, which is pre-installed on Amazon EC2 servers.

#### messages

Creates a directory for storing email message file templates. Uploads email message files.

## Attributes

Key | Description | Datatype | Default Value
--- | --- | --- | ---
`deployer_email_address` | The email address to be notified upon deployment. | String | nil
`environment_variables` | A container for a list of environment variable key-value pairs. | Object | nil
`rbenv["root_path"]` | A wrapper for the rbenv root path attribute. | String | "/home/ec2-user/rbenv"

## Application-Specific Attributes

In the table below, `app` refers to `applications["APP_NAME"]`, where `APP_NAME` is the name of your application.

Key | Description | Datatype | Default Value
--- | --- | --- | ---
`app["code"]["source_url"]` | A URL pointing to the application's source repository. | String | nil
`app["code"]["destination_path"]` | A file path pointing to the destination directory on the node where the source code will be stored. | String | nil

## Contributing

Communicate comments, questions, and requests via [GitHub Issues](https://github.com/s2t2/trailmix-solo/issues), and submit pull requests according to [GitHub Workflow](https://guides.github.com/introduction/flow/index.html).

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
