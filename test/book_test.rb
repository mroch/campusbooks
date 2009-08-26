require 'test_helper'

class BookTest < Test::Unit::TestCase
  VALID_ISBN13 = '9780596516178'
  VALID_ISBN10 = '0596516177'

  def setup
    CampusBooks.api_key = 'SmT8KuLkGvy7SexotRTB' # 'AbC123dEFG4H5jkl6MNO'
  end

  should "store ISBN from constructor" do
    mock_successful_request
    book = CampusBooks::Book.find(VALID_ISBN13)
    assert_equal VALID_ISBN13, book.isbn
  end

  should "convert ISBN10 to ISBN13" do
    mock_successful_request
    book = CampusBooks::Book.find(VALID_ISBN10)
    assert_equal VALID_ISBN13, book.isbn
  end

  should "validate ISBN during construction" do
    assert_nothing_raised do
      mock_successful_request
      CampusBooks::Book.find(VALID_ISBN10)
    end
    assert_raise ArgumentError, 'isbn is invalid' do
      CampusBooks::Book.find('0-596-51617-8')
    end
  end

  should "get valid values" do
    mock_successful_request
    book = CampusBooks::Book.find(VALID_ISBN13)
    assert_equal VALID_ISBN10, book.isbn10
    assert_equal VALID_ISBN13, book.isbn13
    assert_equal VALID_ISBN13, book.isbn
    assert_equal 'The Ruby Programming Language', book.title
    assert_equal 'David Flanagan - Yukihiro Matsumoto', book.author
    assert_equal 'Paperback', book.binding
    assert_equal '39.99', book.msrp
    assert_equal '446', book.pages
    assert_equal "O'Reilly Media, Inc.", book.publisher
    assert_equal Date.parse('2008-01-25'), book.published_date
    assert_equal 'Paperback', book.edition
    assert_equal 'Foo bar', book.description
  end
  
  should "include prices" do
    book = CampusBooks::Book.find(VALID_ISBN13, :include => :prices)
  end

  private
    def mock_successful_request
      CampusBooks::Book.expects(:get).once.returns({
        "response" => {
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
            "image"=>"http://ecx.images-amazon.com/images/I/41n-JSlBHkL._SL75_.jpg",
            "description" => 'Foo bar'
          }, 
          "label"=>{
            "name"=>"Scheduleman Tartan",
            "plid"=>"1709"
          }
        }
      })
    end
    
    def mock_failed_request(isbn = '0-596-51617-8')
      CampusBooks::Book.expects(:get).once.returns({
        "response" => {
          "status" => "error",
          "errors" => {
            "error" => [
              "'#{isbn}' is not a valid ISBN"
            ]
          },
          "version" => "3"
        }
      })
    end
end
