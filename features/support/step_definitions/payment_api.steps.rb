# frozen_string_literal: true
Given(/^I retrieve a valid token$/) do
  check = expect(@auth_token).not_to be '{}'
  LOG.info('The token is valid') unless check == false
end

When(/^I create a quote with no query parameters$/) do
  @response = @api_methods.create_quote(@auth_token)
end

Then(/^the response should include specific error messages$/) do
  LOG.info('Checking that the response contains select error messages')
  @quote_comp.compare_errors(@response)
end

When(/^I create a quote for selling GBP and buying USD for "([^"]*)"$/) do |amount|
  query_params = ['GBP', 'USD', 'sell', amount.to_s]
  @response = @api_methods.create_quote(@auth_token, query_params)
end

Then(/^the response should include the "([^"]*)$/) do |sell_amount|
  LOG.info('Checking that the response contains select fields')
  @quote_comp.compare_fields(@response.to_json, sell_amount)
end
