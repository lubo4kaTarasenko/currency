class CalculateStatistic
  include Interactor

  def call
    aggregate_statistic_for_current_week
  end

  private

  def calculate_statistic_date(_cur, cur_values)
    values_arr = cur_values.map(&:value)
    count_values = values_arr.empty? ? 1 : values_arr.size
    {
      max: values_arr.max,
      min: values_arr.min,
      avg: values_arr.sum / count_values
    }
  end

  def aggregate_statistic_for_current_week
    start = Time.now.beginning_of_week
    finish = start.end_of_week
    aggregate_statistic_for_period(start, finish, 'week')
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
end
