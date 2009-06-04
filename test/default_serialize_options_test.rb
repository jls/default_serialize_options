require 'test/unit'
require 'test/lib/active_record_test_helper'
require 'test_helper'

require 'default_serialize_options'
ActiveRecord::Base.send :include, DefaultSerializeOptions
class DefaultSerializeOptionsTest < ActiveRecordTestHelper
  
  def setup
    Fixtures.create_fixtures(FIXTURES_PTH, 'books')
    Fixtures.create_fixtures(FIXTURES_PTH, 'authors')
    Fixtures.create_fixtures(FIXTURES_PTH, 'categories')
  end

  # Book => xml: => :skip_instruct => true
  # Category => :json => :dasherize => false
  # Author => :all => :dasherize => false

  def first_book
    Book.find(:first)
  end

  def instruct
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  end

  def book_default_xml
    "<book>\n" \
    "  <author-id type=\"integer\">1</author-id>\n  <category-id type=\"integer\">1</category-id>\n" \
    "  <id type=\"integer\">1</id>\n  <title>Harry Potter</title>\n</book>\n"
  end
  
  def category_default_xml
    "<category>\n  <id type=\"integer\">1</id>\n  <name>Fiction</name>\n</category>\n"
  end
  
  def author_default_xml
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<author>\n  <first_name>J.K.</first_name>\n  <id type=\"integer\">1</id>\n  <last_name>Rowling</last_name>\n</author>\n"
  end
  
  def author_default_json
    "{\"id\": 1, \"first_name\": \"J.K.\", \"last_name\": \"Rowling\"}"
  end
  
  def test_obey_default_serialize_options
    assert_equal book_default_xml, first_book.to_xml
  end
  
  def test_ignore_defaults
    assert_equal instruct + book_default_xml, first_book.to_xml(:ignore_defaults => true)
  end
  
  def test_override_defaults
    assert_equal instruct + book_default_xml, first_book.to_xml(:skip_instruct => false)
  end
  
  def test_json_does_not_set_to_xml
    assert_equal instruct + category_default_xml, first_book.category.to_xml
  end
  
  def test_all_sets_xml_and_json
    assert_equal author_default_xml, first_book.author.to_xml, "option[:all] Did not set to_xml"
    assert_equal author_default_json, first_book.author.to_json, "option[:all] Did not set to_json"
  end
  
  
end
