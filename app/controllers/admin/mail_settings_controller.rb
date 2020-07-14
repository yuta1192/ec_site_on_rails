class Admin::MailSettingsController < ApplicationController
  def index
    @mail_setting = MailSetting.find(1)
  end
end
