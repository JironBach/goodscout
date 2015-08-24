class OmniauthCallbacksController < EngineersController

  def authenticate

    @skills = Skill.all
    @engineer = Engineer.new

    fb_info = env['omniauth.auth']

    if fb_info.present?
      @engineer.fb_uid  = fb_info['uid']
      @engineer.name    = fb_info['info']['name'] 
      @engineer.email   = fb_info['info']['email'] 
      @engineer.remote_image_url = "#{fb_info['info'].image.gsub('http://','https://')}?width=200&height=200"
      @engineer.age     = calc_age(fb_info['extra']['raw_info']['birthday'])
    end


    render 'engineers/new'

  end

  def failed
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  private

  def calc_age birthday
    splited = birthday.split('/')
    formatted = "#{splited[2]}#{splited[0].to_s}#{splited[1]}".to_i
    today = Date.today.strftime("%Y%m%d").to_i
    (today - formatted) / 10000
  end


end
