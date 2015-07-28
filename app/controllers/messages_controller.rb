class MessagesController < ApplicationController

  require 'pp'

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  def index
    @messages = Message.all
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    @engineer_id = params[:engineer_id]
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create

    @message = Message.new(create_message_data())

    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      @engineer_id = params['message']['engineer_id']
      puts "====="
      puts @engineer_id
      puts "====="
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :desc)
    end

    def create_message_data

      pp params

      data = {
        'from_type'   => session['user_type'],
        'from_id'     => session['user']['id'],
        'to_id'       => params['message']['engineer_id'],
        'title'       => params['message']['title'],
        'desc'        => params['message']['desc']
      }

    end

end
