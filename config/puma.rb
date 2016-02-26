#!/usr/bin/env puma

#rails的运行环境
environment 'production'
threads 2, 64
workers 4

#项目名
app_name = "wiki"
#项目路径
application_path = "/var/www/#{wiki}"
#这里一定要配置为项目路径下地current
directory "#{application_path}/current"

#下面都是 puma的配置项
pidfile "#{application_path}/shared/tmp/pids/puma.pid"
state_path "#{application_path}/shared/tmp/sockets/puma.state"
stdout_redirect "#{application_path}/shared/log/puma.stdout.log", "#{application_path}/shared/log/puma.stderr.log"
bind "unix://#{application_path}/shared/tmp/sockets/#{wiki}.sock"
activate_control_app "unix://#{application_path}/shared/tmp/sockets/pumactl.sock"

#后台运行
daemonize true
on_restart do
  puts 'On restart...'
end
preload_app!