class MessagesController < ApplicationController

  require 'pp'

  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_val, only: [:show, :new]

  # GET /messages
  # 受信メッセージの表示
  def index
    #todo DB設計を修正
    Notification.done_notification(Settings.notification_type[:message],session[:user_type],session[:user_id])
    @messages = Message.select_received_messages(session[:user_type],session[:user_id])
  end

  # GET /messages/sent
  # 送信メッセージの表示
  def index_sent
    @messages = Message.select_sent_messages(session[:user_type],session[:user_id])
    render :index
  end

  # GET /messages

  # GET /messages/1
  def show
    render :show
    Message.read_messages(@messages)
  end

  # GET /messages/new
  def new
  end

  def download_attached_file
    @attached_file = Message.find(params[:message_id]).attached_file
    filepath = @attached_file.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @attached_file.url.gsub(/.*\//,''), :length => stat.size)
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
      @skills             = Skill.all
      @messages           = Message.select_message_thread(session[:user_type],session[:user_id],params[:message][:opponent_id]).page(params[:page])
      @new_message        = Message.new
      @opponent           = Company.find(params[:message][:opponent_id].to_i)   if view_context.am_i_engineer?
      @opponent           = Engineer.find(params[:message][:opponent_id].to_i)  if view_context.am_i_company?
      from_user           = Engineer.find(session[:user_id])                    if view_context.am_i_engineer?
      from_user           = Company.find(session[:user_id])                     if view_context.am_i_company?
      to_user             = Company.find(params[:message][:opponent_id])        if view_context.am_i_engineer?
      to_user             = Engineer.find(params[:message][:opponent_id])       if view_context.am_i_company?
      create_notification()
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
      @messages = Message.select_message_thread(session[:user_type],session[:user_id],params[:opponent_id]).page(params[:page])
      @new_message = Message.new
      @opponent = Company.find(params[:opponent_id].to_i) if view_context.am_i_engineer?
      @opponent = Engineer.find(params[:opponent_id].to_i) if view_context.am_i_company?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :desc, :upload_file)
    end

    def create_message_data

      if view_context.am_i_engineer? 
        engineer_id = session[:user_id] 
        company_id  = params[:message][:opponent_id] if view_context.am_i_engineer?
      elsif view_context.am_i_company?
        engineer_id = params[:message][:opponent_id] if view_context.am_i_company?
        company_id  = session[:user_id] if view_context.am_i_company?
      end

      filename = params['message']['attached_file'].original_filename unless params['message']['attached_file'].nil?

      data = {
        'message_type'        => session['user_type'],
        'engineer_id'         => engineer_id,
        'company_id'          => company_id,
        'title'               => params['message']['title'],
        'desc'                => params['message']['desc'],
        'attached_file'       => params['message']['attached_file'],
        'attached_file_name'  => filename,
      }

    end

    def create_notification
      opponent_user_type  = Settings.user_type[:company]  if view_context.am_i_engineer?
      opponent_user_type  = Settings.user_type[:engineer] if view_context.am_i_company?
      #MessageMailer.send_message_email(from_user, to_user, @message).deliver_now
      Notification.create(
        :notification_type  => Settings.notification_type[:message],
        :user_type          => opponent_user_type,
        :user_id            => @opponent.id
      )
    end

end
