class EnginnersController < ApplicationController
  before_action :set_enginner, only: [:show, :edit, :update, :destroy]

  # GET /enginners
  # GET /enginners.json
  def index
    @enginners = Enginner.all
  end

  # GET /enginners/1
  # GET /enginners/1.json
  def show
  end

  # GET /enginners/new
  def new
    @enginner = Enginner.new
  end

  # GET /enginners/1/edit
  def edit
  end

  # POST /enginners
  # POST /enginners.json
  def create
    require 'pp'
    puts "=================="
    pp enginner_params
    puts "=================="
    @enginner = Enginner.new(enginner_params)

    respond_to do |format|
      if @enginner.save
        format.html { redirect_to @enginner, notice: 'Enginner was successfully created.' }
        format.json { render :show, status: :created, location: @enginner }
      else
        format.html { render :new }
        format.json { render json: @enginner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enginners/1
  # PATCH/PUT /enginners/1.json
  def update
    respond_to do |format|
      if @enginner.update(enginner_params)
        format.html { redirect_to @enginner, notice: 'Enginner was successfully updated.' }
        format.json { render :show, status: :ok, location: @enginner }
      else
        format.html { render :edit }
        format.json { render json: @enginner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enginners/1
  # DELETE /enginners/1.json
  def destroy
    @enginner.destroy
    respond_to do |format|
      format.html { redirect_to enginners_url, notice: 'Enginner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enginner
      @enginner = Enginner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enginner_params
      params.require(:enginner).permit(:name, :email, :encrypted_password, :self_introduction, :living_place, :fb_uid, :github_uid, :age, :phone_number, :status, :job_history, :notes, :is_registration_enabled)
    end
end
