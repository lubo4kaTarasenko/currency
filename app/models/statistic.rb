class Statistic
  include Mongoid::Document

  field :period_type, type: String
  field :period_start, type: Date
  field :period_end, type: Date
  field :data # , type: JSON
end

#    {
#      "USD" => {
#        avg: 0.1,
#        max: 0.2,
#        min: 0.01
#      },
#      "UAH" => {
#
#      }
#    }
