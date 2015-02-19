require_relative '../../test_helper'

class TestVT < Minitest::Test
	def test_init
		Racket::Misc::VT.new 2
		Racket::Misc::VT.new 2, 4, 4, 4, 4, 4, 12, 3
	end


	def test_decode
		s1 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04\xab\xcd\xef"
		t1 = Racket::Misc::VT.new
		t1.decode! s1
		assert_equal t1.value, 'spoofed.org'
		assert_equal t1.types.size, 0
		assert_equal t1.rest, "\x01\x02\x03\x04\xab\xcd\xef"

		t2 = Racket::Misc::VT.new(4)
		s2 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04"
		t2.decode!(s2)

		assert_equal t2.types[0], 0x01020304
		assert_equal t2.value, 'spoofed.org'
		assert_equal t2.rest, ''

		t3 = Racket::Misc::VT.new 1, 2, 2, 4
		s3 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04\x05\xde\xad\xba\xbe\x11\xff".force_encoding 'ASCII-8BIT'
		t3.decode! s3

		assert_equal 0x01, t3.types[0]
		assert_equal 0x0203, t3.types[1]
		assert_equal 0x0405, t3.types[2]
		assert_equal 0xdeadbabe, t3.types[3]
		assert_equal 'spoofed.org', t3.value
		assert_equal "\x11\xff".force_encoding('ASCII-8BIT'), t3.rest
	end


	def test_encode
		t1 = Racket::Misc::VT.new 4
		s1 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04"
		t1.decode! s1
		assert_equal t1.encode, s1
		assert_equal "#{t1}", s1

		t2 = Racket::Misc::VT.new 1, 2, 2, 4
		s2 = "\x73\x70\x6f\x6f\x66\x65\x64\x2e\x6f\x72\x67\x00\x01\x02\x03\x04\x05\xde\xad\xba\xbe\xff\xff".force_encoding 'ASCII-8BIT'
		t2.decode! s2
		assert_equal s2.slice(0, s2.size - 2), t2.encode
		assert_equal s2.slice(0, s2.size - 2), "#{t2}"
	end
end
