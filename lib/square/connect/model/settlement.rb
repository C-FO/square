require 'square/model/identity'
require 'active_support/core_ext/hash'
require 'square/connect/model/money'
require 'square/connect/model/settlement_entry'
require 'time'

module Square
  module Connect
    class Settlement < Square::Model::Identity

      STATUS = %w(FAILED SENT)

      attr_reader :status, :bank_account_id

      def initiated_at
        @initiated_at ||= Time.parse(@attrs[:initiated_at])
      end

      def total_money
        return unless @attrs[:total_money]
        @total_money ||= Square::Connect::Money.new(@attrs[:total_money].deep_symbolize_keys)
      end

      def entries
        return unless @attrs[:entries]
        @entries ||= @attrs[:entries].map do |entry|
          Square::Connect::SettlementEntry.new(entry.deep_symbolize_keys)
        end
      end

    end
  end
end
