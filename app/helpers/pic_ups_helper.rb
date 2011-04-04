require 'i18n'
module PicUpsHelper

#  week_day = [l(:Monday),l(:Tuesday),l(:Wendsday),l(:Thuesday),l(:Friday),l(:Saturday),l(:Sunday)]
#  months = [l(:january),l(:january),l(:febrary),l(:march),l(:april),l(:may),l(:june),l(:july),l(:august),l(:september),l(:october),l(:november),l(:december)]


  def week_day
    ["Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Domingo"]
  end
  def months
     ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
  end

  def period_send_inform(project)
    
    if !project.day.nil?
      "Semanales, todos los "+week_day[project.day-1]
    elsif !project.num_day.nil?
      "Mensuales, los d&iacute;as"+project.num_day.to_s+" de cada mes"
    else
      "Diarios"
    end
  end

  def show_pic(pic)

   issue = Issue.find_by_id pic.issue_id
   user = User.find_by_id pic.user_id

   html = "<tr>"
   html << "<td>(#{issue.id}) #{issue.subject}</td>"
   html << "<td>#{(Tracker.find(issue.tracker_id)).name}</td>"
   html << "<td>#{user.name}</td>"
   html << "<td>#{pic.hours}</td>"
   html << "<td>#{pic.created_on}</td>"
   html << "</tr>"
   html

  end


  def select_month_in_year

    months_select = []
    cont = 0

    Time.now.month.times do
      months_select << [months[cont],cont+1]
      cont += 1
    end

    months_select
  end

end
