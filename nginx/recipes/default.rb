package 'nginx' do
  action :install
end

service 'nginx' do
  supports:status=>true,:restart=> true,:reload=>true
  action [:enable] # :startしない！
end

template 'nginx.conf' do
  path "/etc/nginx/nginx.conf"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template 'node_proxy.conf' do
  path "/etc/nginx/conf.d/node_proxy.conf"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end
