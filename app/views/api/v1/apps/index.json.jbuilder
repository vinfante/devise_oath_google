json.total @apps.size.to_s
json.apps(@apps) do |app|
  json.id app.id.to_s
  json.data do
    json.created app.created_at
    json.updated app.updated_at
  end
end
