require 'square/model/base'
require 'active_support/core_ext/hash'
require 'square/connect/model/money'
require 'square/connect/model/payment_tax'

module Square
  module Connect
    class PaymentSurcharge < Square::Model::Base

      attr_reader :name, :rate, :surchage_id, :taxable, :type

      def amount_money
        return unless @attrs[:amount_money]
        @applied_money ||= Square::Connect::Money.new(@attrs[:amount_money].deep_symbolize_keys)
      end

      def applied_money
        return unless @attrs[:applied_money]
        @applied_money ||= Square::Connect::Money.new(@attrs[:applied_money].deep_symbolize_keys)
      end

      def taxes
        return unless @attrs[:taxes]
        @taxes ||= @attrs[:taxes].map do |tax|
          Square::Connect::PaymentTax.new(tax.deep_symbolize_keys)
        end
      end
    end
  end
end
