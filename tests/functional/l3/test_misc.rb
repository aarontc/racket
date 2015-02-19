require_relative '../../test_helper'

require_relative '../../../lib/racket/misc'
require_relative '../../../lib/racket/l3/misc'

class TestL3Misc < Minitest::Test
	def test_misc
		Racket::L3::Misc.checksum Racket::Misc.randstring(rand(2048))

		mac = "6e:f1:eb:b7:c8:72"
		ll = "fe80::6cf1:ebff:feb7:c872"
		assert_equal(ll, Racket::L3::Misc.linklocaladdr(mac))

		ipv4 = Racket::L3::Misc.randomipv4
		lipv4 = Racket::L3::Misc.ipv42long(ipv4)
		ipv6 = Racket::L3::Misc.randomipv6
		lipv6 = Racket::L3::Misc.ipv62long(ipv6)

		assert_equal(ipv4, Racket::L3::Misc.long2ipv4(lipv4))
		assert_equal(ipv6, Racket::L3::Misc.long2ipv6(lipv6))

		ipv6 = "a:0:0:0f:0:1"
		zipv6 = "a::f:0:1"
		assert_equal(zipv6, Racket::L3::Misc.compressipv6(ipv6))
	end
end
