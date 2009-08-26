require 'test_helper'

class BaseTest < Test::Unit::TestCase

  def setup
    CampusBooks.api_key = 'SmT8KuLkGvy7SexotRTB'
  end

  should "parse OK response and return just the response" do
    expected_response = {
      "status"=>"ok", 
      "version"=>"1", 
      "page" => {
        "name"=>"bookinfo",
        "rating"=>"5.0",
        "category"=>nil,
        "title"=>"The Ruby Programming Language",
        "isbn10"=>"0596516177",
        "tried_amazon"=>"1",
        "author"=>"David Flanagan - Yukihiro Matsumoto",
        "msrp"=>"39.99",
        "rank"=>"19257",
        "isbn13"=>"9780596516178",
        "publisher"=>"O'Reilly Media, Inc.",
        "pages"=>"446",
        "edition"=>"Paperback",
        "binding"=>"Paperback",
        "published_date"=>"2008-01-25",
        "image"=>"http://ecx.images-amazon.com/images/I/41n-JSlBHkL._SL75_.jpg"
      }, 
      "label"=>{
        "name"=>"Scheduleman Tartan",
        "plid"=>"1709"
      }
    }
    CampusBooks::Base.expects(:get).once.returns({
      "response" => expected_response
    })
    actual_response = CampusBooks::Base.get_response('/bookinfo', :query => { :isbn => '9780596516178' })
    assert_equal expected_response, actual_response
  end
  
  should "raise an exception when an API error occurs" do
    CampusBooks::Base.expects(:get).once.returns({
      "response" => {
        "status" => "error",
        "errors" => {
          "error" => [
            "Permission Denied - Invalid or missing API Key",
            "'isbn' parameter is required",
            "'' is not a valid ISBN",
            "Unable to create a book with isbn "
          ]
        },
        "version" => "3"
      }
    })
    exception = assert_raise CampusBooks::Error do
      CampusBooks::Base.get_response('/bookinfo', :query => { :isbn => '' })
    end
    assert_equal %Q{4 errors occured while getting path '/bookinfo' with options {:query=>{:isbn=>""}}:
  Permission Denied - Invalid or missing API Key
  'isbn' parameter is required
  '' is not a valid ISBN
  Unable to create a book with isbn }, exception.message
  end
end
