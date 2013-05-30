maintainer       "Content Hub Ltd"
maintainer_email "a.gale@contenthub.co.uk"
license           "Apache 2.0"
description      "Installs/Configures cakephpapp"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "php"
depends "openssl"
depends "apache2"
depends "mysql"
depends "database"
# Hmmm
depends "build-essential"
depends "apt" 