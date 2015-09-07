class OmniauthCallbacksController < EngineersController

  def authenticate

    @skills = Skill.all

    case params['provider']
    when 'facebook'
      @engineer = parse_facebook_info(env['omniauth.auth'])
    when 'github'
      @engineer = parse_github_info(env['omniauth.auth'])
    end

    render 'engineers/new'

  end

  def failed
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  private

  def parse_facebook_info info

    engineer = Engineer.new

    if info.present?
      engineer.fb_uid  = info['uid']
      engineer.fb_url  = info['info']['urls']['Facebook']
      engineer.name    = info['info']['name'] 
      engineer.email   = info['info']['email'] 
      engineer.remote_image_url = "#{info['info'].image.gsub('http://','https://')}?width=200&height=200"
      engineer.age     = calc_age(info['extra']['raw_info']['birthday'])
    end

    engineer

  end

  def parse_github_info info

    engineer = Engineer.new

    if info.present?
      engineer.github_uid       = info['uid']
      engineer.github_url       = info['info']['urls']['GitHub']
      engineer.name             = info['info']['name']
      engineer.email            = info['info']['email']
      engineer.living_place     = info['extra']['raw_info']['location']
      engineer.remote_image_url = info['info']['image']
    end

    engineer

  end

  def calc_age birthday
    splited = birthday.split('/')
    formatted = "#{splited[2]}#{splited[0].to_s}#{splited[1]}".to_i
    today = Date.today.strftime("%Y%m%d").to_i
    (today - formatted) / 10000
  end

end
