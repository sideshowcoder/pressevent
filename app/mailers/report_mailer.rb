class ReportMailer < ActionMailer::Base
  helper :report

  default from: 'report@pressevent.herokuapp.com'

  def daily(email, reports)
    @reports = reports
    mail to: email, subject: 'Pressevent wordpress update reports'
  end

  def requested(email, report)
    @report = report
    mail to: email, subject: 'Pressevent wordpress requested update report'
  end
end
