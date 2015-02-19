require_relative '../../test_helper'

class TestTLV < Minitest::Test
	def test_init
		Racket::Misc::TLV.new 2, 4
	end


	def test_decode
		t = Racket::Misc::TLV.new 4, 2
		s = "\x08\x05\x0c\x23\x00\x0b\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\xff\x00\xba"
		t.decode! s

		assert_equal 0x08050c23, t.type
		assert_equal 11, t.length
		assert_equal 'spoofed.org', t.value
		assert_equal "\xff\x00\xba".force_encoding('ASCII-8BIT'), t.rest

		t2 = Racket::Misc::TLV.new 1, 1, 8
		s2 = "\x02\x01\xaa\xbb\xcc\xdd\xee\xff"
		t2.decode! s2
		assert_equal 2, t2.type
		assert_equal 1, t2.length
		assert_equal "\xaa\xbb\xcc\xdd\xee\xff".force_encoding('ASCII-8BIT'), t2.value

		t3 = Racket::Misc::TLV.new 1, 1, 8, false
		s3 = "\x02\x01\xaa\xbb\xcc\xdd\xee\xff\x11\x22".force_encoding('ASCII-8BIT')
		t3.decode! s3
		assert_equal 2, t3.type
		assert_equal 1, t3.length
		assert_equal "\xaa\xbb\xcc\xdd\xee\xff\x11\x22".force_encoding('ASCII-8BIT'), t3.value

	end


	def test_encode
		t = Racket::Misc::TLV.new(4, 2)
		s = "\x08\x05\x0c\x23\x00\x0b\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\xff\xff"
		t.decode!(s)
		assert_equal(t.encode, s.slice(0, s.length - 2))
		assert_equal("#{t}", s.slice(0, s.length - 2))
	end
end
