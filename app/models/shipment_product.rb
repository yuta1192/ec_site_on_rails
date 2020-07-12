class ShipmentProduct < ApplicationRecord
  belongs_to :product
  belongs_to :shipment
end
