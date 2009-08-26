require 'isbn/tools'

module CampusBooks
  class Book < Base
    SUPPORTED_PARAMS = [
      :isbn10,          # Ten-Digit ISBN for this book
      :isbn13,          # Thirteen-Digit ISBN for this book
      :title,           # Book Title
      :author,          # Book Author
      :binding,         # Book Binding
      :msrp,            # List price for the book
      :pages,           # Number of pages in the book
      :publisher,       # Book Publisher
      :published_date,  # Published Date
      :edition,         # Edition
      :description      # A text description for the book
    ]
    attr_reader *SUPPORTED_PARAMS
    alias_method :isbn, :isbn13

    def self.find(isbn, opts = {})
      isbn = isbn.to_s
      canonical_isbn = (ISBN_Tools.is_valid_isbn13?(isbn) ? isbn : ISBN_Tools.isbn10_to_isbn13(isbn)) or raise ArgumentError.new('isbn is invalid')
      
      include_prices = opts[:include] && [*opts[:include]].include?(:prices)

      raw_result = get_response(include_prices ? '/bookprices' : '/bookinfo', :query => { 
        :isbn => canonical_isbn, :key => CampusBooks.api_key 
      })
      
      book_params = include_prices ? raw_result['page']['book'] : raw_result['page']
      
      if raw_result['page']['offers']
        book_params['offers'] = flatten_offers(raw_result['page']['offers'])
      end
      
      new(book_params)
    end

    def initialize(params = {})
      create_offers(params.delete('offers')) if params.key?('offers')

      SUPPORTED_PARAMS.each do |param|
        instance_variable_set("@#{param}", params[param.to_s]) if params.key?(param.to_s)
      end
    end

    def published_date
      @parsed_published_date ||= Date.parse(@published_date)
    end

    def offers
      if !@offers_loaded
        raw_offers = get_response('/prices', :query => { :isbn => @isbn, :key => CampusBooks.api_key })['page']
        create_offers(self.class.flatten_offers(raw_offers))
      end
      @offers
    end

    private
      def self.flatten_offers(data)
        result = []
        data['condition'].each do |condition|
          if condition['offer']
            if condition['offer'].is_a?(Array)
              condition['offer'].each do |offer|
                result.push(offer)
              end
            else
              result.push(condition['offer'])
            end
          end
        end
        result
      end
      
      def create_offers(offer_hashes)
        @offers = offer_hashes.inject([]) { |ary, offer_hash| ary.push(Offer.new(offer_hash)) }
        @offers_loaded = true
        return @offers
      end
  end
end