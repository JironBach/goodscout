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

    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.valid?
      @inquiry.save
      flash.now[:notice] = 'この内容でお問い合わせを送信しました'
      render :show
    else
      render :new, notice: @inquiry.errors
    end

  end

  private

    def inquiry_params
      params.require(:inquiry).permit(:title, :desc, :how_to_reply, :company_name, :company_email, :company_phone_number, :representative_person)
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
