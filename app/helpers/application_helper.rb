module ApplicationHelper

  def am_i_engineer?
    session[:user_type] == Settings.user_type[:engineer]
  end

  def am_i_company?
    session[:user_type] == Settings.user_type[:company]
  end

end
