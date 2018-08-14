require 'square/model/identity'
require 'active_support/core_ext/hash'
require 'square/connect/model/device'
require 'square/connect/model/money'
require 'square/connect/model/payment_tax'
require 'square/connect/model/tender'
require 'square/connect/model/refund'
require 'square/connect/model/payment_itemization'
require 'time'

module Square
  module Connect
    class Payment < Square::Model::Identity

      attr_reader :merchant_id, :creator_id, :description

      def created_at
        @created_at ||= Time.parse(@attrs[:created_at])
      end

      def device
        return nil unless @attrs[:device]
        @device ||= Square::Connect::Device.new(@attrs[:device].deep_symbolize_keys)
      end

      def inclusive_tax_money
        return unless @attrs[:inclusive_tax_money]
        @inclusive_tax_money ||= Square::Connect::Money.new(@attrs[:inclusive_tax_money].deep_symbolize_keys)
      end

      def additive_tax_money
        return unless @attrs[:additive_tax_money]
        @additive_tax_money ||= Square::Connect::Money.new(@attrs[:additive_tax_money].deep_symbolize_keys)
      end

      def tax_money
        return unless @attrs[:tax_money]
        @tax_money ||= Square::Connect::Money.new(@attrs[:tax_money].deep_symbolize_keys)
      end

      def tip_money
        return unless @attrs[:tip_money]
        @tip_money ||= Square::Connect::Money.new(@attrs[:tip_money].deep_symbolize_keys)
      end

      def discount_money
        return unless @attrs[:discount_money]
        @discount_money ||= Square::Connect::Money.new(@attrs[:discount_money].deep_symbolize_keys)
      end

      def total_collected_money
        return unless @attrs[:total_collected_money]
        @total_collected_money ||= Square::Connect::Money.new(@attrs[:total_collected_money].deep_symbolize_keys)
      end

      def processing_fee_money
        return unless @attrs[:processing_fee_money]
        @processing_fee_money ||= Square::Connect::Money.new(@attrs[:processing_fee_money].deep_symbolize_keys)
      end

      def net_total_money
        return unless @attrs[:net_total_money]
        @net_total_money ||= Square::Connect::Money.new(@attrs[:net_total_money].deep_symbolize_keys)
      end

      def refunded_money
        return unless @attrs[:refunded_money]
        @refunded_money ||= Square::Connect::Money.new(@attrs[:refunded_money].deep_symbolize_keys)
      end

      def inclusive_tax
        return unless @attrs[:inclusive_tax]
        @inclusive_tax ||= @attrs[:inclusive_tax].map do |tax|
          Square::Connect::PaymentTax.new(tax.deep_symbolize_keys)
        end
      end

      def additive_tax
        return unless @attrs[:additive_tax]
        @additive_tax ||= @attrs[:additive_tax].map do |tax|
          Square::Connect::PaymentTax.new(tax.deep_symbolize_keys)
        end
      end

      def tender
        return unless @attrs[:tender]
        @tender ||= @attrs[:tender].map do |tender|
          Square::Connect::Tender.new(tender.deep_symbolize_keys)
        end
      end

      def refunds
        return unless @attrs[:refunds]
        @refunds ||= @attrs[:refunds].map do |refund|
          Square::Connect::Refund.new(refund.deep_symbolize_keys)
        end
      end

      def itemizations
        return unless @attrs[:itemizations]
        @itemizations ||= @attrs[:itemizations].map do |item|
          Square::Connect::PaymentItemization.new(item.deep_symbolize_keys)
        end
      end

    end
  end
end
