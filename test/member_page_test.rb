require 'minitest/autorun'
require_relative '../lib/member_page'
require 'nokogiri'
require 'open-uri'
require 'pry'

describe 'MemberPage' do
  it "should return an empty string when there is no data" do
    url = 'http://www.nrsr.sk/web/Default.aspx?sid=poslanci/poslanec&PoslanecID=957&CisObdobia=7'
    page = MemberPage.new(url).to_h
    page[:website].must_equal ''
  end

  it 'should scrape page data correctly' do
    url = 'http://www.nrsr.sk/web/Default.aspx?sid=poslanci/poslanec&PoslanecID=957&CisObdobia=7'
    page = MemberPage.new(url).to_h

    page[:first_name].must_equal 'Eduard'
    page[:last_name].must_equal 'Adamčík'
    page[:party].must_equal '#SIEŤ'
    page[:birth_date].must_equal '1963-01-07'
    page[:residence].must_equal 'Košice'
    page[:title].must_equal 'Ing.'
    page[:nationality].must_equal 'slovenská'
    page[:region].must_equal 'Košický'
    page[:email].must_equal 'eduard_adamcik@nrsr.sk'
  end

  it 'should record the correct page source' do
    url = 'http://www.nrsr.sk/web/Default.aspx?sid=poslanci/poslanec&PoslanecID=957&CisObdobia=7'
    page = MemberPage.new(url).to_h

    page[:source].must_equal url
  end
end
