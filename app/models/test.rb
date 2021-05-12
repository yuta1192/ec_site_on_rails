class Test
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :test, type: String
end
