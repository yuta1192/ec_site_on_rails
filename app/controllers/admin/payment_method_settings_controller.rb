class Admin::PaymentMethodSettingsController < ApplicationController
  def index
    @payment_method_setting = PaymentMethodSetting.find(1)
  end
end
