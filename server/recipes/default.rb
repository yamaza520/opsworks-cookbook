# user add
user "rl_app" do
  supports :manage_home => true
  action :create
end
group "wheel" do
  action [:modify]
  members ["rl_app"]
  append true
end

# create directory
directory "/var/play" do
  owner "rl_app"
  group "wheel"
  recursive true
  mode 0755
  action :nothing
end
