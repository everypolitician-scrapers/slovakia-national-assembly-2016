# frozen_string_literal: true

require 'field_serializer'
require 'nokogiri'

class Page
  include FieldSerializer

  def initialize(url)
    @url = url
  end

  private

  def noko
    @noko ||= Nokogiri::HTML(open(url, 'Accept-Language' => 'en').read)
  end

  attr_reader :url
end
