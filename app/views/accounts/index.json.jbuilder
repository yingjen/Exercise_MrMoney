json.array!(@accounts) do |account|
  json.extract! account, :id, :buyday, :title, :dollar, :description
  json.url account_url(account, format: :json)
end
