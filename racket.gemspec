require 'rubygems'
SPEC = Gem::Specification.new do |s|
	s.name = "racket"
	s.version = '2.0.0'
	s.licenses = ['BSD']
	s.summary = s.description
	s.description = 'Ruby Gem for reading and writing raw packets'
	s.authors = ['Jon Hart', 'Aaron Ten Clay']
	s.homepage = 'http://spoofed.org/files/racket/'
	s.files = Dir.glob("{bin,docs,examples,lib,test}/**/*")

	s.add_dependency 'bit-struct'
	s.add_dependency 'pcaprub'
	s.add_development_dependency 'minitest'
	s.add_development_dependency 'rake'
end
