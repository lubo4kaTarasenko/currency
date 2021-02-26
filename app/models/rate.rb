class Rate
  include Mongoid::Document

  field :currency, type: String
  field :value, type: Float
  field :fetched_at, type: Time
end
