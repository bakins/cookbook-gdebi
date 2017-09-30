# gdebi cookbook

## This project no longer maintained. Open an issue if you'd like to maintain it.

# Requirements

Supports Ubuntu/debian only

# Usage

provides a wrapper around gdebi. Use like the built in dpkg_package:

    gdebi_package '/path/to/package.deb' do
      action :install
    end

Can also function as a generic package provider:

    package 'nginx' do
      provider Chef::Provider::Package::Gdebi
      source '/vagrant/nginx_1.2.4-precise-1_amd64.deb'
      action :install
    end

# Attributes

none

# Recipes

default - include before using the provider

# Author

Author:: Brian Akins (<brian@akins.org>)
