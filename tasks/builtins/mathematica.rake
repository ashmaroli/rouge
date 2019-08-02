# -*- coding: utf-8 -*- #

require 'open-uri'

def mathematica_builtins(&b)
  return enum_for :mathematica_builtins unless block_given?

  mathematica_doc_url = 'http://reference.wolfram.com/language/guide/AlphabeticalListing.html'

  mathematica_docs = open(mathematica_doc_url).read

  p :docs => mathematica_docs

  mathematica_docs.scan %r(<span class="IFSans"><a href="/language/ref/(\w+)[.]html">)m do |word|
    p :word => word
    yield word
  end
end

def mathematica_builtins_source
  yield   "# -*- coding: utf-8 -*- #"
  yield   "# frozen_string_literal: true"
  yield   ""
  yield   "# automatically generated by `rake builtins:mathematica`"
  yield   "module Rouge"
  yield   "  module Lexers"
  yield   "    class Mathematica"
  yield   "      def self.builtins"
  yield   "        @builtins ||= Set.new %w(#{mathematica_builtins.to_a.join(' ')})"
  yield   "      end"
  yield   "    end"
  yield   "  end"
  yield   "end"
end

namespace :builtins do
  task :mathematica do
    File.open('lib/rouge/lexers/mathematica/builtins.rb', 'w') do |f|
      mathematica_builtins_source do |line|
        f.puts line
      end
    end
  end
end
