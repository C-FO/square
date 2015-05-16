require 'square/model/base'
require 'square/core_ext/hash'
require 'square/connect/model/money'
require 'square/connect/model/payment_tax'
require 'square/connect/model/payment_item_detail'
require 'square/connect/model/payment_discount'
require 'square/connect/model/payment_modifier'

module Square
  module Connect
    class PaymentItemization < Square::Model::Base

      attr_reader :name, :quantity, :notes, :item_variation_name

      def item_detail
        return unless @attrs[:item_detail]
        @item_detail ||= Square::Connect::PaymentItemDetail.new(@attrs[:item_detail].deep_symbolize_keys)
      end

      def total_money
        return unless @attrs[:total_money]
        @total_money ||= Square::Connect::Money.new(@attrs[:total_money].deep_symbolize_keys)
      end

      def single_quantity_money
        return unless @attrs[:single_quantity_money]
        @single_quantity_money ||= Square::Connect::Money.new(@attrs[:single_quantity_money].deep_symbolize_keys)
      end

      def gross_sales_money
        return unless @attrs[:gross_sales_money]
        @gross_sales_money ||= Square::Connect::Money.new(@attrs[:gross_sales_money].deep_symbolize_keys)
      end

      def discount_money
        return unless @attrs[:discount_money]
        @discount_money ||= Square::Connect::Money.new(@attrs[:discount_money].deep_symbolize_keys)
      end

      def taxes
        return unless @attrs[:taxes]
        @taxes ||= @attrs[:taxes].map do |tax|
          Square::Connect::PaymentTax.new(tax.deep_symbolize_keys)
        end
      end

      def discounts
        return unless @attrs[:discounts]
        @discounts ||= @attrs[:discounts].map do |discount|
          Square::Connect::PaymentDiscount.new(discount.deep_symbolize_keys)
        end
      end

      def modifiers
        return unless @attrs[:modifiers]
        @modifiers ||= @attrs[:modifiers].map do |modifier|
          Square::Connect::PaymentModifier.new(modifier.deep_symbolize_keys)
        end
      end

    end
  end
end
