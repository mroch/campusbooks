module CampusBooks
  class Error < StandardError ; end

  def self.api_key
    @api_key
  end

  def self.api_key=(key)
    @api_key = key
  end
end

require 'campusbooks/base'
require 'campusbooks/book'
require 'campusbooks/offer'
