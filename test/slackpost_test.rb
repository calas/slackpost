require 'test_helper'

class SlackpostTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Slackpost::VERSION
  end

  def test_message_success
    response = Slackpost.send_simple_msg_to_channel('gem test', 'test_slack')
    assert response.code == '200'
  end
end
