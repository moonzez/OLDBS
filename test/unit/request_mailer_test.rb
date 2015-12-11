require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  tests RequestMailer
  def test_request_email
    @expected.subject = 'RequestMailer#request_email'
    @expected.body    = read_fixture('request_email')
    @expected.date    = Time.now

    assert_equal @expected.encoded, RequestMailer.create_request_email(@expected.date).encoded
  end

end
