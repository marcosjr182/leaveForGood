json.extract! donation, :id, :pickup_window_start, :pickup_window_end, :comments, :anonymous, :organization_id, :created_at, :updated_at
json.url donation_url(donation, format: :json)