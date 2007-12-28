module Expectations::Results
  def initialize(file, line)
    self.line, self.file = line, file
  end
  
  def fulfilled?
    self.is_a?(Expectations::Results::Fulfilled)
  end
  
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def char(arg)
      define_method :char do
        arg
      end
    end
  end
end

module Expectations::Results
  module StateBasedFailure
    include Expectations::Results
    char "F"
    def message 
      "expected: <#{expected.inspect}> got: <#{actual.inspect}>"
    end
  end
end

module Expectations::Results
  module BehaviorFailure
    attr_accessor :message
    include Expectations::Results
    char "F"
  end
end

module Expectations::Results
  module Fulfilled
    include Expectations::Results
    char "."
  end
end

module Expectations::Results
  module BehaviorBasedError
    attr_accessor :exception, :message
    include Expectations::Results
    char "E"
  end
end

module Expectations::Results
  module StateBasedError
    attr_accessor :exception
    include Expectations::Results
    char "E"
    def message 
      "expected: <#{expected.inspect}> got: <#{actual.inspect}>"
    end
  end
end