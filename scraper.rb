#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraperwiki'
require 'nokogiri'

require_rel 'lib'

require 'open-uri/cached'
# require 'scraped_page_archive/open-uri'

LIST_PAGE = 'https://www.nrsr.sk/web/?sid=poslanci/zoznam_abc'.freeze
BASE = 'https://www.nrsr.sk/web/'.freeze

members = AllMembersPage.new(LIST_PAGE)
                        .to_h[:member_relative_urls]
                        .map { |url| MemberPage.new(BASE + url).to_h }
warn "Found #{members.count} members"

members.each do |member|
  puts member.reject { |_, v| v.to_s.empty? }.sort_by { |k, _| k }.to_h if ENV['MORPH_DEBUG']
  ScraperWiki.save_sqlite([:id], member)
end
