module UserSearch
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.search(query)
      __elasticsearch__.search(
        {
          sort: [
          { followed_relationships_count: {order: "desc"}},
          ],
          query: {
            query_string: {
              default_field: "username",
              query: "*#{query}*"
          }
          }
        }
      )
    end

    def as_indexed_json(options={})
      as_json(
        only: [:id, :username, :slug, :avatar, :followed_relationships_count]
      )
    end
  end
end
