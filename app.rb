require 'sinatra'

require_relative './config/gem_dependencies'
require_relative './config/app_dependencies'

set :bind, '0.0.0.0'

root = File.dirname(__FILE__)
set :haml, format: :html5, layout: :application
set :views, File.join(root, 'app/views')

get '/' do
  rates = RateRepository.all_for_last_date
  haml :index, locals: { rates: rates }
end

get '/statistic' do
  statistic = StatisticRepository.all
  haml :statistic, locals: { statistic: statistic }
end
