require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'superecsite1'
    config.asset_host = 'https://s3.amazonaws.com/superecsite1'

    config.fog_public = false # ←コレ
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1',
      path_style: true
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
