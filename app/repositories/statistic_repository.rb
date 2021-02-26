class StatisticRepository
  class << self
    def all
      Statistic.all.to_a.uniq { |stat| stat.period_start.strftime('%x') }
    end

    def create(start:, finish:, period_type:, data:)
      record = Statistic.where(period_type: period_type, period_start: start, period_end: finish).first_or_create!
      record.update(data: data)
    end
  end
end
