#test recipe

include_recipe 'gdebi'

gdebi_package '/vagrant/nginx_1.2.4-precise-1_amd64.deb'
