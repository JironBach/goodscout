json.array!(@engineers) do |engineer|
  json.extract! engineer, :id, :name, :email, :encrypted_password, :self_introduction, :living__place, :fb_uid, :github_uid, :age, :phone_number, :status, :job_history, :notes, :is_invitation_enabled
  json.url engineer_url(engineer, format: :json)
end
