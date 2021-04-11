Sentry.init do |config|
  config.dsn = 'https://2e3dabbd96664f01884c154f1d5831a2@o71139.ingest.sentry.io/5714543'
  config.breadcrumbs_logger = [:active_support_logger]
  config.traces_sample_rate = 1.0
end
