# $Id$

task :default => [:test, :docs, :build]

task :build do
  sh %{gem build racket.gemspec}
end

task :doc => [:docs]

task :docs do
  sh %{test -d doc || mkdir doc}
  sh %{find doc -type f -a ! -wholename \*.svn/\* -print |xargs /bin/rm -f}
  sh %{date -d "Jan 1 1970" > doc/created.rid}
  sh %{rdoc -A rest,octets,hex_octets,unsigned,signed,text -p -o doc -q -f html -m README -W http://spoofed.org/files/racket/src/%s -S lib/* README}
end

task :install do
  sh %{sudo gem install racket.gem}
end

task :test do
  sh %{cd test && ruby ts_all.rb}
  #ruby "test/ts_all.rb"
end
