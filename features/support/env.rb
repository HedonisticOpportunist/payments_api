# frozen_string_literal: true

require 'dotenv'
require 'json'
require 'report_builder'
require 'rspec'
require 'rspec/expectations'
require_relative '../../../currency_cloud_api/common_lib/logging'
include RSpec::Matchers

# Creates Directory if not present which is to hold the json report
FileUtils.mkdir_p('reports/json') unless File.exist?('reports/json')

if ENV['LOCAL']
  Dotenv.load('../.env')
  LOG.info('Loaded secrets from env file')
end
