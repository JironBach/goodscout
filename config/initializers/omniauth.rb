Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, Settings.omniauth_info[:facebook][:id], Settings.omniauth_info[:facebook][:app_secret],
           :scope => 'email', :info_fields => 'id,email,gender,link,locale,name,verified,birthday,cover'

  provider :github, Settings.omniauth_info[:github][:id], Settings.omniauth_info[:github][:app_secret]

end
