# shell copy
cookbook_file "/etc/init.d/play" do
  source "play.sh"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
