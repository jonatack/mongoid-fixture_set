require 'mongoid/fixture_set/errors'

module Mongoid
  class FixtureSet
    class Fixture
      include Enumerable

      attr_reader :name, :fixture, :model_class
      def initialize(name, fixture, model_class)
        @name         = name
        @fixture      = fixture
        @model_class  = model_class
      end

      def class_name
        model_class.name if model_class
      end

      def each
        fixture.each { |item| yield item }
      end

      def [](key)
        fixture[key]
      end

      alias :to_hash :fixture

      def find
        if model_class
          model_class.unscoped do
            model_class.find_by('__fixture_name' => name)
          end
        else
          raise FixtureClassNotFound, "No class attached to find."
        end
      end
    end
  end
end 

