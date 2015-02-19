require_relative '../../test_helper'

require_relative '../../../lib/racket/l2/vlan'

class TestVLAN < Minitest::Test
	def test_init
		Racket::L2::VLAN.new
		Racket::L2::VLAN.new Racket::Misc.randstring(30)
	end
end
