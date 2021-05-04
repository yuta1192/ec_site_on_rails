# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def send_password_reset_to_user
    user = User.new(id: 1, e_mail: 'hogehoge@hoge.hoge', name_sei: '菅田', name_mei: '将暉')
    NotificationMailer.send_password_reset_to_user(user)
  end

  def user_send_contact
    user = User.new(id: 1, e_mail: 'hogehoge@hoge.hoge', name_sei: '菅田', name_mei: '将暉')
    contact = Contact.new(contact: "aiueo")
    NotificationMailer.user_send_contact(user, contact)
  end

  def send_purchase_complite
    user = User.new(id: 1, e_mail: 'hogehoge@hoge.hoge', name_sei: '菅田', name_mei: '将暉')
    product = Product.new(id: 1, price: 1000)
    order_history = OrderHistory.new(id: 1, order_number: "aiuoeokaki20192")
    order_history_products = OrderHistoryProduct.new(id: 1, order_history_id: 1, product_id: 1, num: 100)
    NotificationMailer.send_purchase_complite(user, order_history)
  end
end
