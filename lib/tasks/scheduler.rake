desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  SpotSweeper.sweep!
end

task :send_test_message => :environment do
  Message.send_text_message(to: "+18457966027", body: "iluvu")
end
