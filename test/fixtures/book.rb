class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  default_serialize_options :xml => {:skip_instruct => true}
end