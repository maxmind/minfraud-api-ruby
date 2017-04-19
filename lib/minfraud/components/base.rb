require 'minfraud/initializable'
require 'minfraud/representable'

module Minfraud
  module Components
    class Base
      include Initializable
      include Representable
    end
  end
end
