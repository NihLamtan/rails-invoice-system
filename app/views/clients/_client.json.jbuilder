json.extract! client, :id, :name, :email, :phone, :currency, :created_at, :updated_at
json.url client_url(client, format: :json)
