load(Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb"))

#remember to specify env when calling seeds tasks in future:

#rake db:seed RAILS_ENV=production