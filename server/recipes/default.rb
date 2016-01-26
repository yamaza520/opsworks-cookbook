# user add
user "rl_app" do
  supports :manage_home => true
  action :create
end

# create directory
directory "/var/play" do
  owner "rl_app"
  group "rl_app"
  recursive true
  mode 0755
  action :create_if_missing
end
