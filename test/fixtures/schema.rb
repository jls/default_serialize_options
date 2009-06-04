ActiveRecord::Schema.define do
  create_table "books", :force => true do |t|
    t.string    "title"
    t.integer   "author_id"
    t.integer   "category_id"
    t.integer   "id"
  end
  
  create_table "authors", :force => true do |t|
    t.string    "first_name", "last_name"
    t.integer   "id"
  end
  
  create_table "categories", :force => true do |t|
    t.string  "name"
    t.integer "id"
  end
end