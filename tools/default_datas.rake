require 'active_record'
desc ""
task :default_times_pics => :environment do
  projects = Project.find :all
  puts "Inicio"
  if projects.respond_to?(:each)
    projects.each do |project|
      issues = Issue.find :all,:conditions =>{:project_id => project.id}
      
      if issues.respond_to?(:each)

        issues.each do |issue|
         1000.times do
          
          time = TimeEntry.new

          time.project_id = project.id
          time.issue_id = issue.id
          time.user_id = rand(100)+1
          time.hours = rand(8).to_f
          month = rand(Time.now.month)+1
          day = rand(Time.now.day)+1
          time.spent_on = Time.at(Time.now.to_i-(86400*day*month))
          time.tyear = Time.now.year
          time.tmonth = month
          time.activity_id = rand(2)+8
          time.tweek = time.spent_on.strftime("%U")


          if time.valid?
            time.save
            puts "si"
          else
            puts time.errors.full_messages
          end
          
         end
        end

      end

    end
  end
  puts "FIN"
end

task :create_users_pics => :environment do

  u = 1
  puts "Inicio"
  100.times do

    user = User.new(:language => Setting.default_language, :mail_notification => Setting.default_notification_option)

    user.firstname = 'user'+u.to_s
    user.lastname = 'user'+u.to_s
    user.mail = 'user'+u.to_s+'@gmail.com'
    user.mail_notification = 'all'
    user.status = 1
    user.login = 'user'+u.to_s
    user.password = 'user'+u.to_s
    user.admin = false

    if user.valid?
      user.save
      puts "si"
    else
      puts user.errors.full_messages
    end
    u+=1
  end
  puts "FIN"

end


task :create_issues_pics => :environment do

  projects = Project.find :all
  puts "INicio"
  if projects.respond_to?(:each)
    projects.each do |project|
      sub = 1
      1000.times do
        issue = Issue.new
        issue.tracker_id = rand(3)+1
        issue.project_id = project.id
        issue.subject = "Tarea_"+sub.to_s
        issue.author_id = rand(100)+1

        if issue.valid?
          issue.save
          puts "si"
        else
          puts issue.errors.full_messages
        end

        sub +=1
      end
    end
  end
  puts "FIN"

end
