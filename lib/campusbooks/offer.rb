module CampusBooks
  class Offer < Base
    SUPPORTED_PARAMS = [
      :isbn,                # The ISBN for this offer
      :isbn13,              # The thirteen digit ISBN for this offer
      :isbn10,              # The ten digit ISBN for this offer
      :merchant_id,         # A numeric merchant ID (Note, this value may be signed)
      :merchant_name,       # The Name of the merchant (looked up from the defined constants)
      :price,               # The price that this merchant is listing this item for
      :shipping_ground,     # The cost to ship to an address in the US via ground services
      :total_price,         # Seller price plus the ground shipping price
      :link,                # Link to purchase the book
      :condition_id,        # Numeric representation of the condition (see constants)
      :condition_text,      # Text representation of the condition
      :availability_id,     # Numeric representation of the availability (how long it takes for the seller to ship it)
      :availability_text,   # Text representation of the availability
      :location,            # Geographic location where this item ships from (not always present)
      :their_id,            # The merchant's id for this offer (not always present)
      :comments,            # Comments about this offering
      :condition_text       # Text representation of the condition
    ]
    attr_reader *SUPPORTED_PARAMS
    
    def initialize(params = {})
      SUPPORTED_PARAMS.each do |param|
        instance_variable_set("@#{param}", params[param.to_s]) if params.key?(param.to_s)
      end
    end
    
    # Fall back on ISBN13 or ISBN10 if @isbn isn't set
    def isbn
      @isbn || @isbn13 || @isbn10
    end
  end
end
