class RateUpdater
  include Sidekiq::Worker

  def perform
    result = GetRatesFromApi.call
    if result.success?
      logger.info 'api response success'
      return CalculateStatistic.call 
    end

    failed!
  end

  private

  def failed!
    logger.info 'there are not response from api'
  end
end
