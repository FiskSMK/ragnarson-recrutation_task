require 'test/unit'
require_relative 'name_day'

class StringTest < Test::Unit::TestCase
	def test_id_integer
		assert "12".is_integer?, "Mialo byc true.."
		assert_not "12h".is_integer?, "Mialo byc false.."
	end
end


class NameDayTest < Test::Unit::TestCase
	def setup
		@nd = NameDay.new
	end
	def test_getdoc
		nd.doc = nil
		nd.getDoc
		assert_not_nil nd.doc, "doc is nil"
	end
end
