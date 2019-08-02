# -*- coding: utf-8 -*- #
# frozen_string_literal: true

describe Rouge::Lexers::Perl do
  let(:subject) { Rouge::Lexers::Perl.new }

  describe 'guessing' do
    include Support::Guessing

    it 'guesses by filename' do
      # *.pl needs source hints because it's also used by Prolog
      assert_guess :filename => 'foo.pl', :source => 'my $foo = 1'
      assert_guess :filename => 'foo.pm'
      assert_guess :filename => 'test.t'
    end

    it 'guesses by mimetype' do
      assert_guess :mimetype => 'text/x-perl'
      assert_guess :mimetype => 'application/x-perl'
    end

    it 'guesses by source' do
      assert_guess :source => '#!/usr/local/bin/perl'
    end
  end
end
