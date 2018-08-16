require 'square/model/base'
require 'active_support/core_ext/hash'
require 'square/connect/model/tax'
require 'square/connect/model/money'

module Square
  module Connect
    class PaymentTax < Square::Model::Base
      extend Square::Connect::Tax

      attr_reader :name, :rate, :inclusion_type

      def applied_money
        return unless @attrs[:applied_money]
        @applied_money ||= Square::Connect::Money.new(@attrs[:applied_money].deep_symbolize_keys)
      end

    end
  end
end
