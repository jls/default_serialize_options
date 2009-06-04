class Author < ActiveRecord::Base
  has_many :books
  default_serialize_options :all => {:dasherize => false}
end