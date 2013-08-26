require 'open3'

# copied from apt cookbook. avoids a dependency and how to inject apt recipe
def build_pref(package_name, pin, pin_priority)
  preference_content = "Package: #{package_name}\nPin: #{pin}\nPin-Priority: #{pin_priority}\n"
end

def preferences()
  
  preference = build_pref(new_resource.package_name, "version #{new_resource.version}", "1001")
  
  directory "/etc/apt/preferences.d" do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :nothing
  end.run_action(:create)
  
  file "/etc/apt/preferences.d/#{new_resource.package_name}" do
    owner "root"
    group "root"
    mode 00644
    content preference
    action :nothing
  end.run_action(:create)
end

DPKG_INSTALLED = /^Status: install ok installed/
DPKG_VERSION = /^Version: (.+)$/

# this is pretty cheesy, but keeps us from downlaoding it if it's already installed
# we bake some packages into images. more or less copied from dpkg provider
def installed?
  if @checked_if_installed
    return @installed
  end
  package_installed = false
  version = nil
  Open3.popen3("dpkg -s #{new_resource.package_name}") do |stdin, stdout, stderr|
    stdout.each_line do |line|
      case line
      when DPKG_INSTALLED
        package_installed = true
      when DPKG_VERSION
        if package_installed
          Chef::Log.debug("#{@new_resource} current version is #{$1}")
          version = $1
        end
      end
    end
  end

  @checked_if_installed = true
  @installed = package_installed && (version == new_resource.version)
end

action :create do
  preferences
  
  arch = new_resource.arch || {"x86_64" => "amd64", "i386" => "i386", "i686" => "i386"}[node['kernel']['machine']] || "any"
  pkg_file = "#{new_resource.package_name}_#{new_resource.version}_#{arch}.deb"
  
  pkg_path = ::File.join(Chef::Config[:file_cache_path], pkg_file)

  remote_file pkg_path do
    source "#{new_resource.mirror}/#{pkg_file}"
    checksum new_resource.checksum
    action :nothing
    not_if { installed? }
  end.run_action(:create)
  
  g = gdebi_package new_resource.package_name do
    source  pkg_path
    options new_resource.options
    version new_resource.version
    action :nothing
    not_if { installed? }
  end
  
  g.run_action(:install)

  new_resource.updated_by_last_action(g.updated?)
  
end
