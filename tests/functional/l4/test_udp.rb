require_relative '../../test_helper'

class TestUDP < Minitest::Test
	def test_init
		Racket::L4::UDP.new
		Racket::L4::UDP.new Racket::Misc.randstring(20)
	end

	def test_raw
		binary = "\x9e\x96\x00\x35\x00\x0c\x69\x4f\x66\x6f\x6f\x0a"
		i = Racket::L4::UDP.new binary
		assert_equal i.dst_port, 53
		assert_equal i.src_port, 40598
		assert_equal i.checksum, 0x694f
		assert_equal i.len, 12
		assert_equal i.payload, "foo\n"
	end

	def test_build
		i = Racket::L4::UDP.new
		i.src_port = 50243
		i.dst_port = 53
		i.payload = 'hhahahahahah'
		i.fix! '192.168.1.10', '1.2.3.4'

		assert_equal i.checksum, 0x2623
		assert_equal i.len, 20
	end
end
