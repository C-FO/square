require 'square/model/base'
require 'square/core_ext/hash'
require 'square/connect/model/money'

module Square
  module Connect
    class Tender < Square::Model::Base

      CARD_BRAND = [
        'UNKNOWN',
        'VISA',
        'MASTER_CARD',
        'AMERICAN_EXPRESS',
        'DISCOVER',
        'DISCOVER_DINERS',
        'JCB'
      ]

      ENTRY_METHOD = [
        'MANUAL',
        'SCANNED',
        'SQUARE_CASH',
        'SQUARE_WALLET',
        'SWIPED',
        'WEB_FORM',
        'OTHER'
      ]

      TYPE = [
        'CREDIT_CARD',
        'SQUARE_GIFT_CARD',
        'SQUARE_WALLET',
        'CASH',
        'NO_SALE',
        'OTHER',
        'UNKNOWN'
      ]

      attr_reader :type, :name, :card_brand, :pan_suffix, :entry_method, :payment_note

      def total_money
        return unless @attrs[:total_money]
        @total_money ||= Square::Connect::Money.new(@attrs[:total_money].deep_symbolize_keys)
      end

      def tendered_money
        return unless @attrs[:tendered_money]
        @tendered_money ||= Square::Connect::Money.new(@attrs[:tendered_money].deep_symbolize_keys)
      end

      def change_back_money
        return unless @attrs[:change_back_money]
        @change_back_money ||= Square::Connect::Money.new(@attrs[:change_back_money].deep_symbolize_keys)
      end

      def refunded_money
        return unless @attrs[:refunded_money]
        @refunded_money ||= Square::Connect::Money.new(@attrs[:refunded_money].deep_symbolize_keys)
      end

    end
  end
end
