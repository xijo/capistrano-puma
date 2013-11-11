# coding: utf-8
namespace :puma do

  task :set_puma_env do
    set :sockets_path, fetch(:sockets_path, File.join(shared_path, 'tmp/sockets'))
    set :puma_roles, fetch(:puma_roles, :app)
    set :puma_socket, fetch(:puma_socket, "unix://#{sockets_path}/puma.sock")
    set :pumactl_socket, fetch(:pumactl_socket, "unix://#{sockets_path}/pumactl.sock")
    set :puma_state, fetch(:puma_state, File.join(sockets_path, 'puma.state'))
    set :puma_log, fetch(:puma_log, File.join(shared_path, "log/puma-#{stage}.log"))
    set :puma_flags, fetch(:puma_flags, nil)
  end

  desc "Start puma instance for this application"
  task :start => [:set_puma_env] do
    on roles fetch(:puma_roles) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec puma -b '#{puma_socket}'",
            " -e #{stage} ",
            "--control '#{pumactl_socket}'",
            "-S #{puma_state}",
            fetch(:puma_flags),
            ">> #{puma_log} 2>&1 &"
        end
      end
    end
  end

  desc "Stop puma instance for this application"
  task :stop => [:set_puma_env] do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{puma_state} stop"
      end
    end
  end

  desc "Restart puma instance for this application"
  task :restart => [:set_puma_env] do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{puma_state} restart"
      end
    end
  end

  desc "Show status of puma for this application"
  task :status => [:set_puma_env] do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec pumactl -S #{puma_state} stats"
      end
    end
  end

  desc "Show status of puma for all applications"
  task :overview => [:set_puma_env] do
    on roles fetch(:puma_roles) do
      within release_path do
        execute :bundle, "exec puma status"
      end
    end
  end

end
