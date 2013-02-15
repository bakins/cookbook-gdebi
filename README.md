# gdebi cookbook

# Requirements

Supports Ubuntu/debian only

# Usage

provides a wrapper around gdebi. Use liek the built in dpkg_package:

    gdebi_package '/path/to/package.deb' do
      action :install
    end


# Attributes

none

# Recipes

default - include before using the provider

# Author

Author:: Brian Akins (<brian.akins@turner.com>)
