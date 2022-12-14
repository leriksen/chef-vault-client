package node[:vault][:repotools] do
  action :install
end

yum_repository node[:vault][:hashi_repo][:name] do
  baseurl      node[:vault][:hashi_repo][:baseurl]
  gpgkey       node[:vault][:hashi_repo][:gpgkey]
  gpgcheck     node[:vault][:hashi_repo][:gpgcheck]
  enabled      node[:vault][:hashi_repo][:enabled]
  only_if { ['rhel', 'fedora'].include? node['platform_family'] }
end

package node[:vault][:hashi_repo][:pkg_name] do
  action :install
end

directory node[:vault][:home] do
  user  node[:accounts][:vault][:unix_user]
  group node[:accounts][:vault][:unix_group]
end

# we remove the unrequired default items
node[:vault][:clean_list].each do |item|
  file item do
    action :delete
    backup false
  end
end
