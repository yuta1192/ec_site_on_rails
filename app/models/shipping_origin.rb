class ShippingOrigin < ApplicationRecord
  scope :search, -> (params) do
    return if params.blank?

    origin_id_search(params[:origin_id])
      .shipping_origin_name_search(params[:shipping_origin_name])
      .status_search(params[:status])
  end

  scope :origin_id_search, -> origin_id { where('origin_id LIKE ?', "%#{origin_id}%") if origin_id.present? }
  scope :shipping_origin_name_search, -> shipping_origin_name { where('shipping_origin_name LIKE ?', "%#{shipping_origin_name}%") if shipping_origin_name.present? }
  scope :status_search, -> status { status == "99" ? all : where(status: status) }
end
