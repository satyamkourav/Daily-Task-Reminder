require 'mail'

# Load environment variables from .env
Dotenv.load

def send_email(mail_body)
  puts "In the send_email.rb file"

  mail = Mail.new do
    from    ENV['EMAIL_ADDRESS']
    to      ENV['EMAIL_RECIPIENTS']
    subject "Aaj k kaam in Room"
    body    mail_body
  end

  mail.delivery_method :smtp, {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'smtp.gmail.com',
    user_name:            ENV['EMAIL_ADDRESS'],
    password:             ENV['EMAIL_PASSWORD'],  # App password if 2FA is enabled
    authentication:       :login,  # Use :login instead of 'plain' if needed
    enable_starttls_auto: true
  }

  begin
    mail.deliver!
    puts "Email sent successfully!"
  rescue => e
    puts "Failed to send email: #{e.message}"
  end
end
