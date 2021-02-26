class RateRepository
  class << self
    def all
      Rate.all
    end

    def create(currency, value)
      time = Time.now
      record = Rate.create(currency: currency, value: value.to_f.round(8), fetched_at: time)
    end

    def all_by_day(date)
      Rate.where(fetched_at: (date.beginning_of_day..date.end_of_day))
    end

    def all_for_yesterday
      all_by_day(Time.now.yesterday)
    end

    def all_for_last_date
      last_rate_date = Rate.last.fetched_at
      all_by_day(last_rate_date)
    end

    def all_for_period(start, finish)
      Rate.where(fetched_at: (start.beginning_of_day..finish.end_of_day))
    end
  end
end
