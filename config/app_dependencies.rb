require_relative './initializers/mongo'
require_relative './initializers/sidekiq'

require_relative '../app/models/rate'
require_relative '../app/models/statistic'

require_relative '../app/repositories/rate_repository'
require_relative '../app/repositories/statistic_repository'

require_relative '../app/interactors/get_rates_from_api'
require_relative '../app/interactors/calculate_statistic'

require_relative '../app/workers/rate_updater'
