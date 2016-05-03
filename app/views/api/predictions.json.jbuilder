json.array!(@users) do |user|
  json.name user.name
  json.appreciation user.appreciation
  json.avatar user.avatar.url(:mini)
  json.workplace do |json|
    json.company user.workplaces[0].company
    json.position user.workplaces[0].position
  end
end

json.array!(@projects) do |project|
  json.name project.name
  json.headline project.headline
  json.logo project.logo.url(:mini)
end