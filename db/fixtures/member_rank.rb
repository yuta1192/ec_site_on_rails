# 会員ランク(MemberRank)

5.times do |i|
  MemberRank.seed do |mr|
    mr.name = "member_ranks_name_#{i}"
    mr.multiplication_rate = (i+1)*10
    mr.recalculation = i+1
  end
end
