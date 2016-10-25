json.extract! profile, :id, :name, :phone, :website, :email, :type, :address, :zip, :created_at, :updated_at
json.url profile_url(profile, format: :json)