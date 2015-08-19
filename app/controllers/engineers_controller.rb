class EngineersController < ApplicationController

  before_action :set_engineer, only: [:show, :edit, :update, :destroy]

  # GET /engineers
  # GET /engineers.json
  def index

    @skills = Skill.all
    @engineers = Engineer.select_engineer_with_skills.page(params[:page])

  end

  # GET /engineers/1
  # GET /engineers/1.json
  def show
    @skills = Skill.all
  end

  # GET /engineers/new
  def new
    @skills = Skill.all
    @engineer = Engineer.new
  end

  # GET /engineers/1/edit
  def edit
    @skills = Skill.all
  end

  # POST /engineers
  # POST /engineers.json
  def create

    status = 0
    status = params['status'] if params['status'] != nil
    is_invitation_enabled = true
    @engineer = Engineer.create_engineer(engineer_params,status,is_invitation_enabled)

    respond_to do |format|
      if @engineer != nil && @engineer.valid?
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
        session[:user_type] = Settings.user_type['engineer'] 
        session[:user_id] = @engineer.id
        format.html { redirect_to @engineer, notice: '登録が完了しました！！' }
      else
        @errors = @engineer.errors
        @skills = Skill.all
        format.html { render :new, notice: @errors }
      end
    end

  end

  # PATCH/PUT /engineers/1
  # PATCH/PUT /engineers/1.json
  def update
    respond_to do |format|
      if @engineer.update(engineer_params)
        @skills = Skill.all
        format.html { redirect_to @engineer, notice: 'Engineer was successfully updated.' }
        format.json { render :show, status: :ok, location: @engineer }
      else
        @skills = Skill.all
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

  # ===================================
  # search type
  #   0 : not selected
  #   1 : search by skill
  #   2 : search by status
  #   3 : search by skill and status
  # ===================================
  def search
    
    search_by_skill_flag  = params['skills'].length > 1   || params['skills']['0']['id'].to_i > 0
    search_by_status_flag = params['statuses'].length > 1 || params['statuses']['0']['job'].to_i > 0

    type = 0
    type = 1 if search_by_skill_flag
    type = 2 if search_by_status_flag
    type = 3 if search_by_skill_flag && search_by_status_flag

    engineers = Engineer.all                   if type == 0
    engineers = search_by_skills_and_status()  if type == 3
    engineers = search_by_status()             if type == 2
    engineers = search_by_skills()             if type == 1

    @engineers = engineers.page(params[:page])

    @skills = Skill.all

    render :index

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engineer
      @engineer = Engineer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engineer_params
      params.require(:engineer).permit(
        :name, :email, :password, :password_confirmation, 
        :self_introduction, :living_place, :fb_uid, :github_uid, 
        :age, :phone_number, :status, :job_history, :notes, 
        :is_invitation_enabled, :image, :image_cache, :remove_image,
        :job_id, :desire_to_work_id
      )
    end

    def search_by_status

      job_ids,desire_to_work_ids = format_statuses_params()

      Engineer.where(:job_id => job_ids,:desire_to_work_id => desire_to_work_ids)
      
    end

    def search_by_skills

      search_conditions = format_skills_params()
      ids = Engineer.search_by_skills(search_conditions)
      Engineer.where(:id => ids)

    end

    def search_by_skills_and_status

      job_ids,desire_to_work_ids = format_statuses_params()
      search_conditions = format_skills_params()
      Engineer.search_by_skills_and_status(search_conditions,job_ids,desire_to_work_ids)

    end

    def format_statuses_params
      job_ids = []
      desire_to_work_ids = []
      params['statuses'].each do |status|
        job_ids.push(status[1]['job'])
        desire_to_work_ids.push(status[1]['desire'])
      end

      return job_ids,desire_to_work_ids
    end

    def format_skills_params

      search_conditions = []

      params['skills'].each do |key,param|
        next                unless param['id'].to_i     > 0
        param['year']   = 0 unless param['year'].to_i   > 0
        param['level']  = 0 unless param['level'].to_i  > 0
        search_conditions.push({
          'skill_id'            => param['id'],
          'years_of_experience' => param['year'],
          'level'               => param['level']
        }) 
      end

      search_conditions

    end

end
