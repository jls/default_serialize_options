class Category < ActiveRecord::Base
  has_many :books
  default_serialize_options :json => {:dasherize => false}
end