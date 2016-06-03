require 'elasticsearch/model'
if Rails.env.production?
  if ENV['BONSAI_URL']
    Elasticsearch::Model.client = Elasticsearch::Client.new({url: ENV['BONSAI_URL'], logs: true})
    BONSAI_INDEX_NAME = ENV['BONSAI_URL'][/[^\/]+$/]
  else
    app_name = Rails.application.class.parent_name.underscore.dasherize
    BONSAI_INDEX_NAME = "#{app_name}-#{Rails.env}"
  end
else
  Elasticsearch::Model.client = Elasticsearch::Client.new url: "http://localhost:9200/"
end
