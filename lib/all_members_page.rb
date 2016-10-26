# frozen_string_literal: true
require_rel 'page'

class AllMembersPage < Page
  field :member_relative_urls do
    urls
  end

  private

  def urls
    noko.css('.mps_list_block li a @href').map(&:text)
  end
end
