class SessionsController < ApplicationController

  def create 

    engineer = Engineer.find_by_email(params[:email])

    if engineer && engineer.authenticate(params[:password])
      session[:user_id] = engineer.id
      session[:user_type] = Settings.user_type[:engineer] 
      flash[:success] = "ログインに成功しました(エンジニア)"
    else

      company = Company.find_by_email(params[:email])

      if company && company.authenticate(params[:password])
        session[:user_id] = company.id
        session[:user_type] = Settings.user_type[:company] 
        flash[:success] = "ログインに成功しました(企業)"
      else
        flash[:error] = "ユーザー名かパスワードに誤りがあります"
      end

    end

    redirect_to root_path

  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_path
  end

end
