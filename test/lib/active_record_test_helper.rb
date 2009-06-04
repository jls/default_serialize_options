require 'test/lib/active_record_connector'
require 'test/fixtures/schema.rb'

class ActiveRecordTestHelper < Test::Unit::TestCase
  FIXTURES_PTH = File.join(File.dirname(__FILE__), '/../fixtures')
  dep = defined?(ActiveSupport::Dependencies) ? ActiveSupport::Dependencies : ::Dependencies
  dep.load_paths.unshift FIXTURES_PTH
  
  def default_test
  end
end