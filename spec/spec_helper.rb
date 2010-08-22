# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

class String
  def decode_json
    ActiveSupport::JSON.decode(self)
  end
end

module UserSessionAwareActions

  EDITOR = User.new(:username => 'editor', :editor => true)
  VIEWER = User.new(:username => 'viewer', :editor => false)

  def get_as_editor(action, params = {})
    get_as_user action, params, EDITOR
  end

  def post_as_editor(action, params = {})
    post_as_user action, params, EDITOR
  end

  def get_as_viewer(action, params = {})
    get_as_user action, params, VIEWER
  end

  def post_as_viewer(action, params = {})
    post_as_user action, params, VIEWER
  end

  def get_as_user(action, params, user)
    get action, params, {:user_id => 1, :editor => user.editor, :user => user}
  end

  def post_as_user(action, params, user)
    post action, params, {:user_id => 1, :editor => user.editor, :user => user}
  end

end

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, comment the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end

module BeforeAndAfter

  LEFT_SIDE_LATER  = 1
  RIGHT_SIDE_LATER = -1
  
  def before?(input_time)
    (self <=> input_time) == RIGHT_SIDE_LATER
  end
  
  def after?(input_time)
    (self <=> input_time) == LEFT_SIDE_LATER
  end
end

Time.send :include, BeforeAndAfter

module Spec
  module Mocks
    module ArgumentMatchers
      class DateAroundMatcher

        # Takes an argument of expected date
        def initialize(expected)
          @expected = expected
        end

        # actual is a date (hopefully) passed to the method by the user.
        # We'll check if this date is 'around' expected date, where 'around' means
        # thay don't differ more than a second
        def ==(actual)
          if actual.kind_of? Time
             return (actual - @expected).abs < 1.second
          else
            return false
          end
        end

        def description
          "date around #{@expected}"
        end

      end

      # Usage:
      #  some_mock.should_receive(:message).with( date_around(Time.now) )
      def date_around(*args)
        DateAroundMatcher.new(*args)
      end
    end
  end
end

module DisableFlashSweeping
  def sweep
  end
end
