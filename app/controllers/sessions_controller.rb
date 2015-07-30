class SessionsController < ApplicationController

  ENGINEER = 0
  RECRUITER = 1

  def create 

    user = Engineer.find_by_email params[:email]

    if user && user.authenticate(params[:password])
      session[:user] = Engineer.find(user.id)
      session[:user_type] = ENGINEER
      flash[:success] = "ログインに成功しました"
    else
      flash[:error] = "ユーザー名かパスワードに誤りがあります"
    end

    redirect_to root_path

  end

  def destroy 
    session[:user] = nil
    @engineers = Engineer.all
    @skills = Skill.all
    render :template => 'engineers/index'
  end

end
