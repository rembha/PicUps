class PicUpsController < ApplicationController
  unloadable
  def index
    @project = Project.find_by_identifier params[:project_id]
    @project_picups = (PicUp.find_by_id 1) || nil

    unless @project_picups.nil?
      @pics = TimeEntry.find :all,:conditions => {:project_id => @project.id,:tmonth => Time.now.month}
    end

    @identifier = params[:project_id]

  end

  def editTi

    project = PicUp.new

    if params[:send]["inform"] == 'week'
     project[:day] = params[:week]
    elsif params[:send]["inform"] == 'mounth'
     project[:nday] = params[:mounth]
    end

    project[:day_1] = params[:day_1] || 0
    project[:day_2] = params[:day_2] || 0
    project[:day_3] = params[:day_3] || 0
    project[:day_4] = params[:day_4] || 0
    project[:day_5] = params[:day_5] || 0
    project[:day_6] = params[:day_6] || 0
    project[:day_7] = params[:day_7] || 0

    project[:description] = params[:desciption] || nil

    project.save

    redirect_to :action => "index",:project_id => project.project_id
  end
 
  def pic_project_info
    @project = Project.find_by_identifier params[:project_id]
    @project_picups = PicUp.find_by_id @project.id || create_pic_to_project(params[:project_id])
  end

  def my_pics
    
    puts "**********************************************my_pics"

    @user = User.current
    @my_pics = get_my_pics
    debugger
    render :partial => "pic_ups/my_pics",:locals => {:user => @user,:pics => @my_pics}
  end

  def update_times_pics
    puts "**********************************************my_pics"

    @user = User.current
    @project = Project.find_by_identifier params[:project_id]
    @my_pics = get_my_pics params[:period]
    debugger
    render :partial => "my_pics",:locals =>{:user => @user,:pics => @my_pics}
  end



  private

  def create_pic_to_project(project)
    PicUps.new(project).save
  end
  
  def get_my_pics(period = 7)
    
    since = Time.at(Time.now.to_i-(86400*period.to_i))
    my_pics = []
    days = period.to_i
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
    since = Time.at(Time.now.to_i-(86400*day.to_i))
    nday = since.day
    day = since.wday
    project = PicUp.find 4
    
    pics = TimeEntry.find :all,:conditions => ["user_id = ? AND created_on > ?",@user.id,since]

    if !pics.nil? && pics.respond_to?(:each)
      issues = []
      hours = 0
      pics.each do |pic|
        hours += pic.hours
        issue = Issue.find_by_id pic.issue_id
        issues << "Ref #"+issue.id.to_s+" .- "+issue.subject+" ("+pic.hours.to_s+")"
      end
      pics_day = {}
      pics_day = {:issues => issues,
                  :time_to_justify => 8,
                  :time_not_justify => 8-hours,
                  :time_justify => hours,
                  :wday => nday,
                  :day => day
                  }
    end

  end
end
