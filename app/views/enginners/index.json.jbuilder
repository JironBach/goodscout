json.array!(@enginners) do |enginner|
  json.extract! enginner, :id, :name, :email, :encrypted_password, :self_introduction, :living_place, :fb_uid, :github_uid, :age, :phone_number, :status, :job_history, :notes, :is_registration_enabled
  json.url enginner_url(enginner, format: :json)
end
