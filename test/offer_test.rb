require 'test_helper'

class OfferTest < Test::Unit::TestCase
  
  should "set params in constructor" do
    offer = CampusBooks::Offer.new({
      "merchant_id" => "24",
      "price"=>"11.93",
      "shipping_ground"=>"3.99",
      "condition_id"=>"2",
      "availability_id"=>"2",
      "comments"=>"Good condition. Absolutely no highlighting or markings inside the books. Decent covers subject to prior use.",
      "isbn10"=>"0596516177",
      "total_price"=>"15.92",
      "isbn13"=>"9780596516178",
      "merchant_name"=>"Amazon Marketplace",
      "availability_text"=>"Ready to ship",
      "link"=>"http://partners.campusbooks.com/link.php?params=ABCDEF",
      "condition_text"=>"Used"
    })
    #assert_equal '9780596516178', offer.isbn
    assert_equal '9780596516178', offer.isbn13
    assert_equal '0596516177', offer.isbn10
    assert_equal '24', offer.merchant_id
    assert_equal 'Amazon Marketplace', offer.merchant_name
    assert_equal '11.93', offer.price
    assert_equal '3.99', offer.shipping_ground
    assert_equal '15.92', offer.total_price
    assert_equal 'http://partners.campusbooks.com/link.php?params=ABCDEF', offer.link
    assert_equal '2', offer.condition_id
    assert_equal 'Used', offer.condition_text
    assert_equal '2', offer.availability_id
    assert_equal 'Ready to ship', offer.availability_text

    # FIXME: Need an example of these
    # assert_equal 'foo', offer.location
    # assert_equal 'foo', offer.their_id
    # assert_equal 'foo', offer.comments
  end
  
end
