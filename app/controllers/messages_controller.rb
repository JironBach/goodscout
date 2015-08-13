class MessagesController < ApplicationController

  require 'pp'

  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_val, only: [:show, :new]

  # GET /messages
  # 受信メッセージの表示
  def index
    #todo DB設計を修正
    messages = Message.select_received_messages(session[:user_type],session[:user_id])
    @messages = Message.where(id: messages.map{ |message| message.id }).page(params[:page])
  end

  # GET /messages/sent
  # 送信メッセージの表示
  def index_sent
    messages = Message.select_sent_messages(session[:user_type],session[:user_id])
    @messages = Message.where(id: messages.map{ |message| message.id }).page(params[:page])
    render :index
  end

  # GET /messages

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create

    if session['user_type'] == nil
      redirect_to root_path
      return
    end

    @message = Message.new(create_message_data())

    if @message.save
      @skills = Skill.all
      @messages = Message.select_message_thread(session[:user_type],session[:user_id],params[:message][:opponent_id]).page(params[:page])
      @new_message = Message.new
      @opponent = Company.find(params[:message][:opponent_id].to_i) if view_context.am_i_engineer?
      @opponent = Engineer.find(params[:message][:opponent_id].to_i) if view_context.am_i_company?
      flash.now[:notice] = 'メッセージの送信に成功しました'
      redirect_to message_path(@message.id,:opponent_id => params[:message][:opponent_id])
    else
      @engineer_id = params['message']['engineer_id']
      render :new
    end

  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_val
      @skills = Skill.all
      @messages = Message.select_message_thread(session[:user_type],session[:user_id],params[:opponent_id]).page(params[:page]).page(params[:page])
      @new_message = Message.new
      @opponent = Company.find(params[:opponent_id].to_i) if view_context.am_i_engineer?
      @opponent = Engineer.find(params[:opponent_id].to_i) if view_context.am_i_company?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :desc)
    end

    def create_message_data

      if view_context.am_i_engineer? 
        engineer_id = session[:user_id] 
        company_id  = params[:message][:opponent_id] if view_context.am_i_engineer?
      elsif view_context.am_i_company?
        engineer_id = params[:message][:opponent_id] if view_context.am_i_company?
        company_id  = session[:user_id] if view_context.am_i_company?
      end

      data = {
        'message_type'   => session['user_type'],
        'engineer_id' => engineer_id,
        'company_id'  => company_id,
        'title'       => params['message']['title'],
        'desc'        => params['message']['desc']
      }

    end

end
