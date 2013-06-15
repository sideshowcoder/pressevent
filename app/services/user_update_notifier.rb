class UserUpdateNotifier
  def initialize(user)
    @user = user
  end

  def notify
    ReportMailer.daily(@user.email, non_empty_reports).deliver if has_reports?
  end

  private
  def has_reports?
    non_empty_reports.present?
  end

  def non_empty_reports
    @non_empty_reports ||= generated_reports.select(&:updates_available?)
  end

  def reports
    @user.installations_need_checking.map { |wp| Report.new(wp_installation: wp) }
  end

  def generated_reports
    reports.map { |r|
      begin
        r.generate!
      rescue Report::GenerationError
        # noop
      end
    }.compact
  end
end
