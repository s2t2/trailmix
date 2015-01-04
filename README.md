# Trailmix Solo

Configures and deploys a [rails](http://guides.rubyonrails.org/) application server to support one or more applications and associated dependencies.

## Usage

Initial deployment:
 + `bundle install` to install gems via [bundler](http://bundler.io/)
 + `librarian-chef install` to install cookbook dependencies via [librarian-chef](https://github.com/applicationsonline/librarian-chef)
 + `knife solo prepare my-node.com` to install [chef](https://www.chef.io/chef/) on a node server
 + `knife solo cook my-node.com` to deploy site cookbook(s) onto a node server

Subsquent Deploys:
 + `knife solo cook my-node.com`

## Prerequisites

Obtain shell access to an Amazon Linux server hosted by [Amazon EC2](http://aws.amazon.com/ec2/). Add an [EBS](http://aws.amazon.com/ebs/) database storage drive to `dev/sdb` during EC2 instance launch wizard configuration.

Obtain deploy keys for one or more github-hosted source code repositories, and add corresponding .ssh files (*config*, *id_rsa*, and *id_rsa.pub*) to `/site-cookbooks/trailmix/files/applications/APP_NAME/deploy_keys/`.

Add a node configuration file to the */nodes* directory. Configure attribute values and add recipes to the run list (see [Node Templates](/node_templates) for example usage).

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
