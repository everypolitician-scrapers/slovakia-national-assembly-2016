# frozen_string_literal: true

require_relative 'page'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class MemberPage < Page

  field :first_name do
    value_for('Meno')
  end

  field :last_name do
    value_for('Priezvisko')
  end

  field :name do
    first_name + " " + last_name
  end

  field :party do
    value_for('Kandidoval(a) za')
  end

  field :birth_date do
    Date.parse(value_for('Narodený(á)')).to_s
  end

  field :residence do
    value_for('Bydlisko')
  end

  field :title do
    value_for('Titul')
  end

  field :nationality do
    value_for('Národnosť')
  end

  field :region do
    value_for('Kraj')
  end

  field :email do
    href_for('E-mail').gsub('mailto:','')
  end

  field :website do
    href_for('Www')
  end

  field :image do
    noko.css(".mp_foto img @src").text
  end

  field :source do
    url.tidy
  end

  field :id do
    first_name + last_name + birth_date
  end

  private

  def value_for(strong_text)
    node = noko.xpath("//strong[contains(text(),'"+strong_text+"')]/following-sibling::span")[0]
    return node.text.tidy unless node.nil?
    ""
  end

  def href_for(strong_text)
    node = noko.xpath("//strong[contains(text(),'"+strong_text+"')]/following-sibling::span/a/@href")[0]
    return node.text.tidy unless node.nil?
    ""
  end
end
