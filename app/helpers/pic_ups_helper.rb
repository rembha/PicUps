module PicUpsHelper

  week_day = ['Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','Sabados','Domingos']

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
   html << "<td>#{user.name}</td>"
   html << "<td>#{pic.hours}</td>"
   html << "<td>#{pic.created_on}</td>"
   html << "</tr>"
   html

  end

end
