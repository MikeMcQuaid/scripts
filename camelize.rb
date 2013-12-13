#!/usr/bin/env ruby -p
$_.gsub!(/(^|\s)\S/) {|s| s.delete(' ').upcase }
