desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  SpotSweeper.sweep!
end

task :send_test_message => :environment do
  Message.send_text_message({number_to_send_to: ENV["A_NUM"], body: "iluvu"})
end
