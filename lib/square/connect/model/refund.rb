require 'square/model/base'
require 'active_support/core_ext/hash'
require 'square/connect/model/money'
require 'time'

module Square
  module Connect
    class Refund < Square::Model::Base

      TYPE = %w(FULL)

      attr_reader :type, :reason, :payment_id

      def created_at
        @created_at ||= Time.parse(@attrs[:created_at])
      end

      def processed_at
        @processed_at ||= Time.parse(@attrs[:processed_at])
      end

      def refunded_money
        return unless @attrs[:refunded_money]
        @refunded_money ||= Square::Connect::Money.new(@attrs[:refunded_money].deep_symbolize_keys)
      end

      def refunded_additive_tax_money
        return unless @attrs[:refunded_additive_tax_money]
        @refunded_additive_tax_money ||= Square::Connect::Money.new(@attrs[:refunded_additive_tax_money].deep_symbolize_keys)
      end

      def refunded_inclusive_tax_money
        return unless @attrs[:refunded_inclusive_tax_money]
        @refunded_inclusive_tax_money ||= Square::Connect::Money.new(@attrs[:refunded_inclusive_tax_money].deep_symbolize_keys)
      end

      def refunded_processing_fee_money
        return unless @attrs[:refunded_processing_fee_money]
        @refunded_processing_fee_money ||= Square::Connect::Money.new(@attrs[:refunded_processing_fee_money].deep_symbolize_keys)
      end
    end
  end
end
