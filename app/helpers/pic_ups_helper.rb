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

end
