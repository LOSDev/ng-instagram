require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                 => ENV['AWS_S3_REGION'] # Change this for different AWS region. Default is 'us-east-1'
  }
  if Rails.env.production?
    config.storage = :fog
  else
    config.storage = :file
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory    = ENV['S3_BUCKET_NAME']
end
