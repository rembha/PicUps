class PicUpsController < ApplicationController
  unloadable
  def index
    @project = Project.find_by_identifier params[:project_id]
    @project_picups = PicUp.find_by_id @project.id || create_pic_to_project(params[:project_id])

  end
 
  def pic_project_info
    @project = Project.find_by_identifier params[:project_id]
    @project_picups = PicUp.find_by_id @project.id || create_pic_to_project(params[:project_id])
  end

  def my_pics
    debugger
    puts "my_pics"

    @user = User.current
    @my_pics = get_my_pics
    
    render :partial => "pic_ups/my_pics",:locals => {:user => @user,:pics => @my_pics}
  end

  def update_times_pics
    puts "my_pics"

    @user = User.current
    @my_pics = get_my_pics params[:period]

    render :partial => "my_pics",:locals =>{:user => @user,:pics => @my_pics}
  end



  private

  def create_pic_to_project(project)
    PicUps.new(project).save
  end
  
  def get_my_pics(period = 7)
    since = Time.at(Time.now.to_i - 86400 * period)
    my_pics = []
    days = period
    period.each do
     my_pics << pics_day(days) 
     days -= 1
    end
  end
  
  def who_is
    
    unless session[:user_id].nil?
      @user = User.current
      if @user.login != 'admin'
        redirect_to :action => "pic_project_info"
      end
    else
      redirect_to :action => "not_login"
    end
  end

  def pics_day(day)
    since = Time.at(Time.now.to_i - 86400 * day)
    nday = since.day
    day = since.wday

    pics = SpendTime.find :all,:conditions => ["project_id = ? AND user_id = ? AND created_on > ?",@project.id,@user.id,since]

    if !pics.nil? && pics.respond_to?(:each)
      issues = []
      hours = 0
      pics.each do |pic|
        hours += pic.hours
        issue = Issue.find_by_id pic.issue_id
        issues << "Ref #"+issue.id.to_s+" .- "+issue.subject+" ("+pic.hours.to_s+")"
      end
      pics_day[:issues] = issues
      pics_day[:time_to_justify] = @proyect[day.to_s]
      pics_day[:time_not_justify] = pics_day[:time_to_justify]-hours
      pics_day[:time_justify] = hours
      pics_day[:wday] = wday
      pics_day[:day] = day 
    end

  end
end
