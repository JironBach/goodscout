class SessionsController < ApplicationController

  def create 
    require 'pp'
    session[:user] = 'hoge'

    user = Engineer.find_by_email params[:email]
    pp params[:password_digest] 

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "ログインに成功しました"
    else
      flash[:error] = "ユーザー名かパスワードに誤りがあります"
    end

    redirect_to root_path

  end

  def destroy 
    session[:user] = nil
    @engineers = Engineer.all
    render :template => 'engineers/index'
  end

end
