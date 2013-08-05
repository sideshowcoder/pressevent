class ReportMailer < ActionMailer::Base
  helper :report

  default from: 'report@pressevent.herokuapp.com'

  def daily(email, reports)
    @reports = reports
    mail to: email, subject: 'Pressevent wordpress update reports'
  end
end
