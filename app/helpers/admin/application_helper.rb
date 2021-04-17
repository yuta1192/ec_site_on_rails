module Admin::ApplicationHelper
  def admin_left_menu(status)
    if status == 1
      @count= Shipment.where(allocation_status: 1).count
    elsif status == 2
      @count= Shipment.where(allocation_status: 2).count
    elsif status == 3
      @count= Shipment.where(shipping_status: 1).count
    elsif status == 4
      @count= Shipment.where(shipping_status: 2).count
    elsif status == 5
      @count= Shipment.where(shipping_status: 3).count
    elsif status == 6
      @count= Shipment.where(shipping_status: 4).count
    end
    return @count
  end
end
