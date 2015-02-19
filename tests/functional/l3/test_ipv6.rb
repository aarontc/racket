require_relative '../../test_helper'

require_relative '../../../lib/racket/l3/i_pv6'
require_relative '../../../lib/racket/l3/misc'
require_relative '../../../lib/racket/l2/misc'

class TestIPV6 < Minitest::Test
	def test_init
		Racket::L3::IPv6.new
		Racket::L3::IPv6.new Racket::Misc.randstring(30)
	end

	def test_convert
		long = rand 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
		ipv6 = Racket::L3::Misc.long2ipv6 long

		assert_equal long, Racket::L3::Misc.ipv62long(ipv6)
		assert_equal ipv6, Racket::L3::Misc.long2ipv6(long)

		Racket::L3::Misc.soll_mcast_addr6 ipv6
		mac = Racket::L2::Misc.randommac
		Racket::L3::Misc.soll_mcast_mac mac
	end
end
