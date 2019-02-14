require 'test_helper'

class SlackpostTest < Minitest::Test
  TEST_CHANNEL = 'test_slack'.freeze # test channel goes here

  def test_message_success
    response = Slackpost.simple_msg_to_channel('gem test 1', 'test_slack')
    assert response.code == '200'
  end

  def test_bad_token
    configure_slack_token('T0S/B40/Hk4')
    assert_raises Slackpost::SlackpostError do
      Slackpost.simple_msg_to_channel('gem test 2', 'test_slack')
    end
    configure_slack_token
  end

  def test_bad_channel
    assert_raises Slackpost::SlackpostError do
      Slackpost.simple_msg_to_channel('gem test 3', 'foo_bar_baz_channel')
    end
  end
end
