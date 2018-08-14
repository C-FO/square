require 'square/model/base'
require 'active_support/core_ext/hash'
require 'square/connect/model/money'

module Square
  module Connect
    class PaymentDiscount < Square::Model::Base

      attr_reader :name

      def applied_money
        return unless @attrs[:applied_money]
        @applied_money ||= Square::Connect::Money.new(@attrs[:applied_money].deep_symbolize_keys)
      end

    end
  end
end
