module HashtagSearch
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.search(query, order)
      __elasticsearch__.search(
        {
          sort: [
          { "#{order}": {order: "desc"}},
          ],
          query: {
            multi_match: {
              query: query,
              fields: ['description^10', 'image']
            }
        },
        }
      )
    end
  end
end
