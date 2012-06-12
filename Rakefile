#!/usr/bin/env ruby
# From https://github.com/edavis10/edavis10-emacs/blob/master/Rakefile

require "fileutils"
require 'rake/clean'

@elisp="~/.emacs.d"
@emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"

desc "delete all byte compiled files"
task :clean_byte do
  Dir['**/**.elc'].each do |file|
    File.delete(file)
  end
end

desc "byte compile all emacs files"
task :compile do
  system("#{@emacs} -batch -f batch-byte-recompile-directory #{@elisp}")
end
