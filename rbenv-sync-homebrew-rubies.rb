#!/usr/bin/env ruby

require "pathname"
require "fileutils"

rbenv_versions          = Pathname("#{ENV["HOME"]}/.rbenv/versions")
homebrew_ruby_versions  = Pathname.glob("/usr/local/Cellar/ruby")
homebrew_ruby_versions += Pathname.glob("/usr/local/Cellar/ruby@*")

homebrew_ruby_versions.flat_map(&:children)
                      .each {|v| FileUtils.ln_sf v, rbenv_versions }

rbenv_versions.children
              .select(&:symlink?)
              .reject(&:exist?)
              .each {|v| FileUtils.rm_f v }
