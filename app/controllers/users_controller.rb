class UsersController < ApplicationController

  def sign_in
    session[:user] = 'hoge'
    @engineers = Engineer.all
    render :template => 'engineers/index'
  end

  def sign_out
    session[:user] = nil
    @engineers = Engineer.all
    render :template => 'engineers/index'
  end

end
