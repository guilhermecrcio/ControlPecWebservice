bundle exec puma -C config/puma.rb -e production -d -b unix:///var/run/flagticket-webservice.sock --pidfile /var/run/flagticket-webservice.pid
