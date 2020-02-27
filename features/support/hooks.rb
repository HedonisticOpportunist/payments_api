# frozen_string_literal: true

Before do |scenario|
  @api_methods = APIMethods.new
  @quote_comp = QuoteComp.new
  @feature_name = scenario.feature.name # Feature name
  @scenario_name = scenario.name # Scenario name
  @scenario_tags = scenario.source_tag_names # Tags (as an array)

  @auth_token = @api_methods.retrieve_token

  LOG.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
  LOG.debug('     ' + @feature_name + '    ' + @scenario_name)
  LOG.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
  LOG.debug('tags => ' + @scenario_tags.to_s) unless @scenario_tags.nil?
end

After do |_|
  LOG.debug('This is the end of the scenario.')
  LOG.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>(\n)")
  session_end = @api_methods.end_session(@auth_token)
  check = expect(session_end).to eql('{}')
  LOG.info('The session has ended successfully.') unless check == false
end

at_exit do
  time = Time.now.strftime('%Y-%m-%d-%H%M').gsub(/\s+/, '')
  ReportBuilder.configure do |config|
    config.input_path = 'reports/json/cucumber.json'
    config.report_path = 'reports/auto_report_' + time
    config.report_types = [:HTML]
    config.include_images = true
    config.additional_info = {
      Browser: 'Firefox',
      Platform: RUBY_PLATFORM,
      RubyVersion: RUBY_VERSION
    }
  end
  options = {
    color: 'blue'
  }
  ReportBuilder.build_report options
end
