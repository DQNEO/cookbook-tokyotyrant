# put init script
template "/etc/init.d/ttservd" do
  source "ttservctl.erb"
  mode "0755"
end

