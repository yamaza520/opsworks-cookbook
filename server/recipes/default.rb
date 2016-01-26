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
  action :create
end

# for CodeDeploy
execute "CodeDeploy install" do
  command  <<-EOH
    aws s3 cp s3://aws-codedeploy-ap-northeast-1/latest/install . --region ap-northeast-1
    chmod +x ./install
    sudo ./install auto
  EOH
end
