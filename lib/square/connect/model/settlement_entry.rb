require 'square/model/identity'
require 'active_support/core_ext/hash'
require 'square/connect/model/money'

module Square
  module Connect
    class SettlementEntry < Square::Model::Base

      TYPE = [
        'ADJUSTMENT',
        'BALANCE_CHARGE',
        'CHARGE',
        'FREE_PROCESSING',
        'HOLD_ADJUSTMENT',
        'INCENTED_PAYMENT',
        'PAYOUT',
        'REDEMPTION_CODE',
        'REFUND',
        'RETURNED_ACH_ENTRY',
        'RETURNED_PAYOUT',
        'RETURNED_SQUARE_275',
        'SQUARE_275',
        'OTHER'
      ]

      attr_reader :type, :payment_id

      def amount_money
        return unless @attrs[:amount_money]
        @amount_money ||= Square::Connect::Money.new(@attrs[:amount_money].deep_symbolize_keys)
      end

      def fee_money
        return unless @attrs[:fee_money]
        @fee_money ||= Square::Connect::Money.new(@attrs[:fee_money].deep_symbolize_keys)
      end

    end
  end
end
