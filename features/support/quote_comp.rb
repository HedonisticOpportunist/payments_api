# frozen_string_literal: true

# class that deals with data comparisons
class QuoteComp
  def compare_errors(response)
    error_code = 'rate_fetch_failed'
    expect(response).to include(error_code)
    buy_currency_invalid = 'buy_currency_is_in_invalid_format'
    expect(response).to include(buy_currency_invalid)
    buy_currency_required = 'buy_currency_is_required'
    expect(response).to include(buy_currency_required)

    sell_currency_invalid = 'sell_currency is in invalid format'
    expect(response).to include(sell_currency_invalid)
    sell_currency_required = 'sell_currency_is_required'
    expect(response).to include(sell_currency_required)
    fixed_side_required = 'fixed_side_is_required'
    expect(response).to include(fixed_side_required)

    wrong_amount_type = 'amount_type_is_wrong'
    expect(response).to include(wrong_amount_type)
    numeric_type = 'amount should be of numeric type'
    expect(response).to include(numeric_type)
    amount_type_required = 'amount_is_required'
    expect(response).to include(amount_type_required)
  end

  def compare_fields(response, sell_amount)
    currency_pair_value = 'GBPUSD'
    expect(response).to include(currency_pair_value)
    client_buy_currency = 'USD'
    expect(response).to include(client_buy_currency)
    client_sell_currency = 'GBP'

    expect(response).to include(client_sell_currency)
    expect(response).to include(sell_amount)
    fixed_side  = 'sell'
    expect(response).to include(fixed_side)
  end
end
