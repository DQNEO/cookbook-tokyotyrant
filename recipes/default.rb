# -*- coding: utf-8 -*-

%w{gcc make zlib-devel bzip2-devel telnet}.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "/usr/local/src/tokyocabinet-#{node['tc']['version']}.tar.gz" do
  source "http://fallabs.com/tokyocabinet/tokyocabinet-#{node['tc']['version']}.tar.gz"
end

execute "extract tokyocabinet" do
  cwd "/usr/local/src"
  command <<-EOH
     tar xvfz tokyocabinet-#{node['tc']['version']}.tar.gz
  EOH

  not_if { File.exist?("/usr/local/src/tokyocabinet-#{node['tc']['version']}/") }
end

execute "configure && make tokyocabinet" do
  cwd "/usr/local/src/tokyocabinet-#{node['tc']['version']}/"

  command <<-EOH
    ./configure
    make
    make install
  EOH

  not_if { File.exist?("/usr/local/bin/tchmgr") }

  action :run
end

remote_file "/usr/local/src/tokyotyrant-#{node['tt']['version']}.tar.gz" do
  source "http://fallabs.com/tokyotyrant/tokyotyrant-#{node['tt']['version']}.tar.gz"
end

execute "extract tokyotyrant" do
  cwd "/usr/local/src"
  command <<-EOH
     tar xvfz tokyotyrant-#{node['tt']['version']}.tar.gz
  EOH

  not_if { File.exist?("/usr/local/src/tokyotyrant-#{node['tt']['version']}") }
end

execute "configure && make tokyotyrant" do
  cwd "/usr/local/src/tokyotyrant-#{node['tt']['version']}/"

  command <<-EOH
    ./configure
    make
    make install
  EOH

  not_if { File.exist?("/usr/local/bin/ttserver") }

  action :run
end

template "/usr/local/sbin/ttservctl" do
  source "ttservctl.erb"
  mode "0755"
end

link "/etc/init.d/ttservctl" do
  to "/usr/local/sbin/ttservctl"
  link_type :symbolic
end

service "ttservctl" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
