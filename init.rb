require 'redmine'

Redmine::Plugin.register :redmine_pic_up do
  name 'Pic Up plugin'
  author 'Juan Vazquez (Jnillo) & Arantzazu Vega (Zazu)'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  
  permission :pic_ups, {:pic_ups => [:index,:show_my_pics]}, :public => true
  menu :project_menu, :pic_ups, { :controller => 'pic_ups', :action => 'index' }, :caption => 'PicUp', :after => :issues, :param => :project_id

end
