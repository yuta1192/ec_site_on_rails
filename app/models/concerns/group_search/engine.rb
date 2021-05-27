module GroupSearch
  module Engine
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model

      # ①index名
      index_name "es_group_#{Rails.env}"

      # document_typeは必須らしい
      document_type "es_group_#{Rails.env}"

      # ②mapping情報
      settings do
        mappings dynamic: 'false' do
          indexes :id, type: 'integer'
          indexes :name, type: 'text', analyzer: 'kuromoji'
          indexes :created_at, type: 'date', format: 'YYYY-MM-dd kk:mm:ss'
        end
      end

      # ③mappingの定義に合わせてindexするドキュメントの情報を生成する
      def as_indexed_json(*)
        attributes
          .symbolize_keys
          .slice(:id, :name, :created_at)
      end
    end

    class_methods do
      # ④indexを作成するメソッド
      def create_index!
        client = __elasticsearch__.client
        # すでにindexを作成済みの場合は削除する
        client.indices.delete index: self.index_name rescue nil
        # indexを作成する
        client.indices.create(index: self.index_name,
          body: {
            settings: self.settings.to_hash,
            mappings: self.mappings.to_hash
          })
      end
    end

    def search(query)
      elasticsearch__.search({
        query: {
          multi_match: {
             fields: %w(publisher author category title description),
             type: 'cross_fields',
             query: query,
             operator: 'and'
          }
        }
      })
    end
  end
end
