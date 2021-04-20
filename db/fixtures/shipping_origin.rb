# 出荷元（ShippingOrigin）

10.times do |i|
  ShippingOrigin.seed do |so|
    so.status = 1
    so.origin_id = i+1
    so.password_digest = "password"
    so.shipping_origin_name = "shipping_origin_name_#{i}"
    so.shipping_origin_email = "shipping_origin_email_#{i}"
  end
end
