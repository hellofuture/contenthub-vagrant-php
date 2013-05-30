#
# Cookbook Name:: contenthub
# Recipe:: default
#
# Generic recipe
#
# Copyright 2013, Content Hub
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

###############################################################################
# Get all this stuff installed for free
###############################################################################

include_recipe "apt"
include_recipe "mysql::ruby"
include_recipe "build-essential"
include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
include_recipe "database"

###############################################################################
# Create our app database and make a MySQL user and grant them permisions
###############################################################################

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}


database node['contenthub']['db']['database'] do
   connection mysql_connection_info
   provider Chef::Provider::Database::Mysql
   action :create
end

mysql_database_user node['contenthub']['db']['user'] do
  connection mysql_connection_info
  password node['contenthub']['db']['password']
  database_name node['contenthub']['db']['database']
  privileges [:select,:update,:insert,:create,:delete]
  action :grant
end

###############################################################################
# Disable default "It works" Apache site.
###############################################################################

apache_site "000-default" do
  enable false
end

###############################################################################
# Setup virtualhost for our Wordpress site
###############################################################################

web_app node['contenthub']['host'] do
  template "contenthub.conf.erb"
  docroot node['contenthub']['dir']
  server_name node['contenthub']['host']
end
