class Admin::ShippingSettingsController < ApplicationController
  def index
    @shipping_setting = ShippingSetting.find(1)
  end
end
