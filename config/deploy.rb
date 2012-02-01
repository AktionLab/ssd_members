set :app_name, 'ssd_members'
set :rvm_ruby, 'ruby-1.9.3-p0'
set :server_location, 'bzlabs.org'
set :port, 2222

require './config/boot'
require 'bz_labs/base'
require 'bz_labs/mysql'
require 'bz_labs/nginx'
require 'bz_labs/unicorn'

