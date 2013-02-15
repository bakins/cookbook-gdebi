require 'chef/resource/package'
require File.join(File.dirname(__FILE__), 'gdebi_provider')

class Chef
  class Resource
    class GdebiPackage < Chef::Resource::Package
      
      def initialize(name, run_context=nil)
        super
        @resource_name = :gdebi_package
        @provider = Chef::Provider::Package::Gdebi
      end
      
    end
  end
end
