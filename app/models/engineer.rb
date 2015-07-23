class Engineer < ActiveRecord::Base

  def self.create_engineer params,status,is_invitation_enabled

    begin
      Engineer.create(
        :name                   => params['name'],
        :email                  => params['email'],
        :password               => params['password'],
        :password_confirmation  => params['password_confirmation'],
        :self_introduction      => params['self_introduction'],
        :living_place           => params['living_place'],
        :age                    => params['age'],
        :phone_number           => params['phone_number'],
        :status                 => status,
        :job_history            => params['job_history'],
        :is_invitation_enabled  => is_invitation_enabled,
      )
    rescue
      puts $!
      puts $@
      puts "============DB格納エラー|Engineer#create_engineer=============="
      nil
    end

  end

  has_secure_password

end
