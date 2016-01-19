service 'nginx' do
  action [:enable, :start]
end

template ".htpasswd" do
  path "/etc/nginx/.htpasswd"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end

template "conf.d/basic_auth.conf" do
  path "/etc/nginx/conf.d/basic_auth.conf"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[nginx]"
end
