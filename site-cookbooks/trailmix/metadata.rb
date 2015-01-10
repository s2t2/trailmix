name             'trailmix'
maintainer       'MJ Rossetti (@s2t2)'
maintainer_email 's2t2mail@gmail.com'
license          'Apache 2.0'
description      'Configures a production server and deploys one or more rails applications.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "application_ruby"
depends "ruby_build"
depends "rbenv"

#depends 'mysql'
#depends 'database'
