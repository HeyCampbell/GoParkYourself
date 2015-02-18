desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  SpotSweeper.sweep!
end

task :send_test_message => :environment do
  Message.send_text_message({number_to_send_to: "+18457966027", body: "i have your phone number and I will find you [ASHLEY BALDWIN HUNTER]"})
end
