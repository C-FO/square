module Square
  class Version
    MAJOR = 0 unless defined? Square::Version::MAJOR
    MINOR = 4 unless defined? Square::Version::MINOR
    PATCH = 0 unless defined? Square::Version::PATCH
    PRE = nil unless defined? Square::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end
  end
end
