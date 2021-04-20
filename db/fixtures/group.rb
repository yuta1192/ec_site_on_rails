# グループ（Group）

Group.seed do |g|
  g.name = "group"
end

3.times do |i|
  GroupAddress.seed do |ga|
    ga.group_id = 1
    ga.address_id = i+1
  end
end
