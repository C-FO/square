require 'square/core_ext/hash'
require 'date'

module Square
  module Utils
    module API

      LIST_ORDER = %w(ASC DESC)

    private

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Hash]
      def objects_from_response(klass, request_method, path, options={})
        response = send(request_method.to_sym, path_with_version(path), options)
        batch_token = parse_batch_token(response[:response_headers][:link])
        objects = objects_from_array(klass, response[:body])
        {
          objects: objects,
          batch_token: batch_token
        }
      end

      # @param klass [Class]
      # @param array [Array]
      # @return [Array]
      def objects_from_array(klass, array)
        array.map do |element|
          klass.new(element.deep_symbolize_keys)
        end
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Object]
      def object_from_response(klass, request_method, path, options={})
        response = send(request_method.to_sym, path_with_version(path), options)
        klass.from_response(response.deep_symbolize_keys)
      end

      def path_with_version(path)
        "v#{@api_version}#{path}"
      end

      def parse_date(date)
        if date.is_a? String
          Date.parse(date).strftime('%Y-%m-%d')
        elsif date.is_a? Date
          date.strftime('%Y-%m-%d')
        else
          raise
        end
      rescue => ex
        raise ArgumentError.new 'invalid date'
      end

      # @param response_header_link [String]
      # @return [String]
      # @see https://connect.squareup.com/docs/connect#pagination
      def parse_batch_token(response_header_link)
        return if response_header_link.nil?
        response_header_link.match(/batch_token=(?<batch_token>.+)\>.+\z/)[:batch_token]
      end
    end
  end
end
