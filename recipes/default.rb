# -*- coding: utf-8 -*-

%w{gcc make zlib-devel bzip2-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "/usr/local/src/tokyocabinet-1.4.48.tar.gz" do
  source "http://fallabs.com/tokyocabinet/tokyocabinet-1.4.48.tar.gz"
end

execute "extract tokyocabinet" do
  cwd "/usr/local/src"
  command <<-EOH
     tar xvfz tokyocabinet-1.4.48.tar.gz
  EOH

  not_if { File.exist?("/usr/local/src/tokyocabinet-1.4.48/") }
end

execute "configure && make tokyocabinet" do
  cwd "/usr/local/src/tokyocabinet-1.4.48/"

  command <<-EOH
    ./configure
    make
    make install
  EOH

  #not_if { File.exist?("#{node['home']}/local/bin/convert") }

  action :run
end

remote_file "/usr/local/src/tokyotyrant-1.1.41.tar.gz" do
  source "http://fallabs.com/tokyotyrant/tokyotyrant-1.1.41.tar.gz"
end

execute "extract tokyotyrant" do
  cwd "/usr/local/src"
  command <<-EOH
     tar xvfz tokyotyrant-1.1.41.tar.gz
  EOH

  not_if { File.exist?("/usr/local/src/tokyotyrant-1.1.41") }
end

execute "configure && make tokyotyrant" do
  cwd "/usr/local/src/tokyotyrant-1.1.41/"

  command <<-EOH
    ./configure
    make
    make install
  EOH

  #not_if { File.exist?("#{node['home']}/local/bin/convert") }

  action :run
end
