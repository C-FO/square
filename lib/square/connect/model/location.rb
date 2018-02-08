require 'square/model/identity'
require 'time'

module Square
  module Connect
    class Location < Square::Model::Identity

      attr_reader :id, :name, :business_name

    end
  end
end
