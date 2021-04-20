# カートの備考（CartMemo）

CartMemo.seed do |cm|
  cm.id = 1
  cm.memo = 'こちらはカートの備考（上部）になります'
  cm.position = 1
end

CartMemo.seed do |cm|
  cm.id = 2
  cm.memo = 'こちらはカートの備考（下部）になります'
  cm.position = 2
end
