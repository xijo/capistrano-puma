require 'capistrano'
require 'capistrano/version'

module CapistranoPuma
  class Tasks
    def self.load_into(capistrano_config)
      capistrano_config.load do
        before(%w[puma:start puma:stop puma:restart puma:status]) do
          _cset(:puma_app_name) { fetch(:application) }
        end

        namespace :puma do
          desc "Start puma instance for this application"
          task :start do
            run "/etc/init.d/puma start #{puma_app_name}"
          end

          desc "Stop puma instance for this application"
          task :stop do
            run "/etc/init.d/puma stop #{puma_app_name}"
          end

          desc "Restart puma instance for this application"
          task :restart, roles: :app do
            run "/etc/init.d/puma restart #{puma_app_name}"
          end

          desc "Show status of puma for this application"
          task :status, roles: :app do
            run "/etc/init.d/puma status #{puma_app_name}"
          end

          desc "Show status of puma for all applications"
          task :overview, roles: :app do
            run "/etc/init.d/puma status"
          end

          desc "Create a shared tmp dir for puma state files"
          task :after_symlink, roles: :app do
            run "rm -rf #{release_path}/tmp"
            run "ln -s #{shared_path}/tmp #{release_path}/tmp"
          end
        end

        after "deploy:start",          "puma:start"
        after "deploy:stop",           "puma:stop"
        after "deploy:restart",        "puma:restart"
        after "deploy:create_symlink", "puma:after_symlink"
      end
    end
  end
end

if Capistrano::Configuration.instance
  CapistranoPuma::Tasks.load_into(Capistrano::Configuration.instance)
end
