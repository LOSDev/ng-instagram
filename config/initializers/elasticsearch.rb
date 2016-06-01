Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL'] || "http://localhost:9200/"

  User.__elasticsearch__.create_index! force: true
  User.import
  Post.__elasticsearch__.create_index! force: true
  Post.import
