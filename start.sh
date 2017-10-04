bundle exec puma -C config/puma.rb -e production -d -b unix:///var/run/controlpec-webservice.sock --pidfile /var/run/controlpec-webservice.pid
