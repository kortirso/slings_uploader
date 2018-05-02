# default mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'postmaster@netloader.com'
  layout 'mailer'
end
