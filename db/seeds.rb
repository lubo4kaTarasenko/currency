require_relative '../config/gem_dependencies'
require_relative '../config/app_dependencies'

def create_rates_for_30_days
  currencies = {
    UAH: 28.03,
    JPY: 105.03,
    LTC: 0.007,
    ETH: 0.00065,
    EUR: 0.83
  }
  time = Time.now.yesterday
  30.times do |_t|
    currencies.each do |cur, val|
      new_val = val.to_f * (1 + (0.2 / rand(1..10) * [1, -1].sample))
      Rate.create(currency: cur, value: new_val, fetched_at: time)
    end
    time = time.prev_day
  end
end

def aggregate_old_data
  start = Time.now.beginning_of_week
  4.times do
    start -= 7.days
    finish = start.end_of_week
    aggregate_statistic_for_period(start, finish, 'week')
  end
end

def calculate_statistic_date(_cur, cur_values)
  values_arr = cur_values.map(&:value)
  count_values = values_arr.empty? ? 1 : values_arr.size
  {
    max: values_arr.max,
    min: values_arr.min,
    avg: values_arr.sum / count_values
  }
end

def aggregate_statistic_for_period(start, finish, period_type)
  rates = RateRepository.all_for_period(start, finish)

  currency_groups = rates.group_by(&:currency)
  currency_statistic = {}

  currency_groups.each do |cur, cur_values|
    currency_statistic[cur] = calculate_statistic_date(cur, cur_values)
  end

  StatisticRepository.create(start: start, finish: finish, period_type: period_type, data: currency_statistic)
end

create_rates_for_30_days
aggregate_old_data
