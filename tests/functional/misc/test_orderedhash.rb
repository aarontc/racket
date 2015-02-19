require_relative '../../test_helper'

require_relative '../../../lib/racket/misc/ordered_hash'

class TestBitField < Minitest::Test
	def test_init
		Racket::Misc::OrderedHash.new
	end


	def test_order
		oh = Racket::Misc::OrderedHash.new
		("a".."z").each { |c|
			oh[c] = c.unpack("c")[0]
		}

		97.upto(122) { |v|
			assert_equal(oh[sprintf("%c", v)], v)
		}

		assert_nil(oh['kajf'])

		copy = []
		oh.each_key { |k| copy << k }
		0.upto(25) { |v|
			assert_equal(copy[v], sprintf("%c", 97 + v))
		}

		assert_nil(copy[205])
	end
end
