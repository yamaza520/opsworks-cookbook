# shell copy
cookbook_file "/etc/init.d/play.sh" do
  source "play.sh"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
