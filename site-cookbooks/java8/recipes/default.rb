include_recipe "java"

ruby_block "insert_line" do
	block do
  		file = Chef::Util::FileEdit.new(node[:java][:security])
		file.insert_line_if_no_match("networkaddress.cache.ttl = 0", "networkaddress.cache.ttl = 0")
		file.write_file
	end
end

ruby_block "insert_line" do
	block do
  		file = Chef::Util::FileEdit.new(node[:java][:security])
		file.insert_line_if_no_match("networkaddress.cache.negative.ttl = 0", "networkaddress.cache.negative.ttl = 0")
		file.write_file
	end
end