class Product < ApplicationRecord
  enum category: { オリジナル商品: 1, 食べ物: 2 }
end
