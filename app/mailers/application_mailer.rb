# default mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'postmaster@netloader.ru'
  layout 'mailer'
end
