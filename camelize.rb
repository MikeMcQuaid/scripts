#!/usr/bin/env ruby -p
require "English"
$LAST_READ_LINE.gsub!(/(^|\s)\S/) { |s| s.delete(" ").upcase }
