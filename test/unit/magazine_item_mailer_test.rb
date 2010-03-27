require File.dirname(__FILE__) + '/../test_helper'

class MagazineItemMailerTest < ActiveSupport::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"
	
  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
    @expected.mime_version = '1.0'
  end

	def test_email
    MagazineItemMailer.deliver_send_login_info User.find(:first)
  end
		
  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/magazine_item_mailer/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
