class EngineersController < ApplicationController

  before_action :set_engineer, only: [:show, :edit, :update, :destroy]

  require 'pp'

  # GET /engineers
  # GET /engineers.json
  def index
    @engineers = Engineer.all
  end

  # GET /engineers/1
  # GET /engineers/1.json
  def show
  end

  # GET /engineers/new
  def new
    @skills = Skill.all
    @engineer = Engineer.new
  end

  # GET /engineers/1/edit
  def edit
  end

  # POST /engineers
  # POST /engineers.json
  def create

    password_digest = 'hogehoge'
    status = 0
    status = params['status'] if params['status'] != nil
    is_invitation_enabled = true
    @engineer = Engineer.create_engineer(engineer_params,status,is_invitation_enabled)

    respond_to do |format|
      if @engineer != nil 
        skills_data = []
        params['skills'].each do |skill|
          if skill[1]['year'].to_i > 0 || skill[1]['level'].to_i > 0
            skills_data.push({
              :skill_id             => skill[0].to_i,
              :engineer_id          => @engineer.id,
              :years_of_experience  => skill[1]['year'],
              :level                => skill[1]['level'] 
            })
          end
        end
        EngineerSkill.insert_engineer_skills(skills_data)
        format.html { redirect_to @engineer, notice: 'Engineer was successfully created.' }
      else
        @engineer = Engineer.new
        format.html { render :new, notice: @engineer.errors }
      end
    end

  end

  # PATCH/PUT /engineers/1
  # PATCH/PUT /engineers/1.json
  def update
    respond_to do |format|
      if @engineer.update(engineer_params)
        format.html { redirect_to @engineer, notice: 'Engineer was successfully updated.' }
        format.json { render :show, status: :ok, location: @engineer }
      else
        format.html { render :edit }
        format.json { render json: @engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engineers/1
  # DELETE /engineers/1.json
  def destroy
    @engineer.destroy
    respond_to do |format|
      format.html { redirect_to engineers_url, notice: 'Engineer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engineer
      @engineer = Engineer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engineer_params
      params.require(:engineer).permit(:name, :email, :password, :password_confirmation, :self_introduction, :living_place, :fb_uid, :github_uid, :age, :phone_number, :status, :job_history, :notes, :is_invitation_enabled)
    end
end
