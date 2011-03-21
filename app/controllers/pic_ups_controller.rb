class PicUpsController < ApplicationController

  def index
    debugger

    @project_picups = PicUp.find_by_id params[:project_id] || create_pic_to_project(params[:project_id])
    @project = Project.find_by_identifier params[:project_id]
  end

  def my_pics
  end

  private

  def create_pic_to_project(project)
    PicUps.new(project).save
  end
end
