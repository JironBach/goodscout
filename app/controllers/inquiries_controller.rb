class InquiriesController < ApplicationController

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new
    @company = Company.new
  end

  # GET /engineers/1
  # GET /engineers/1.json
  def show
  end

  # POST /inquiries
  def create
    #論理積のみでの演算だと片方が評価されないことがあるので一旦変数に保存
    company_data = parse_params_for_company(params)
    @company = Company.new(company_data)
    company_valid = @company.valid?

    inquiry_data = parse_params_for_inquiry(params,@company.id)
    @inquiry = Inquiry.new(inquiry_data)
    inquiry_valid = @inquiry.valid?

    if company_valid && inquiry_valid
      @inquiry.company_id = @company.id if @company.save
      @inquiry.save
      render :show
    else
      render :new, notice: [@inquiry.errors,@company.errors]
    end

  end

  private

    def inquiry_params
      params.require(:inquiry).permit(:title, :desc, :how_to_reply, :company_id)
    end

    def parse_params_for_company p

      company_data = {
        'company_name' => p['company_name'],
        'email' => p['email'],
        'representative_person' => p['representative_person'],
        'company_name' => p['company_name'],
        'status' => 0,
      }
      company_data['url'] = p['url'] if p['url'] != nil
      company_data['adress'] = p['adress'] if p['adress'] != nil
      company_data['phone_number'] = p['phone_number'] if p['phone_number'] != nil


      company_data

    end

    def parse_params_for_inquiry p,company_id

      inquiriry_data = {
        'title' => p['inquiry']['title'],
        'desc' => p['inquiry']['desc'],
        'how_to_reply' => p['inquiry']['how_to_reply'],
        'company_id' => company_id
      }

    end

end
