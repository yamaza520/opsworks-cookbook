override[:java][:install_flavor] = "oracle"
override[:java][:jdk_version] = "8"
override[:java][:oracle][:accept_oracle_download_terms] = true
override[:java][:oracle][:jce][:enabled] = true

case node[:platform_family]
when "debian"
  default[:java][:security] = "/usr/lib/jvm/jdk1.8.0_66/jre/lib/security/java.security"
when "rhel"
  default[:java][:security] = "/usr/lib/jvm/jdk1.8.0_66/jre/lib/security/java.security"
else
  Chef::Log.error "Cannot configure java8, platform unknown"
end
