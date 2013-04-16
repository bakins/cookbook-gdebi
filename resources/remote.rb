# simple helper that fetches and installs
# abstract a common use case

actions :create
default_action :create

attribute :package_name, :kind_of => String, :name_attribute => true
attribute :mirror, :kind_of => String, :default => nil, :required => true
attribute :version, :kind_of => String, :default => nil, :required => true
attribute :arch, :kind_of => String, :default => nil
attribute :checksum, :kind_of => String, :default => nil
attribute :options, :kind_of => String, :default => nil
