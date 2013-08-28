module ReportHelper
  def link_to_reports(reports)
    raw link_to_reports_with_type(reports, Report).join(", ")
  end

  def link_to_error_reports(reports)
    raw link_to_reports_with_type(reports, ErrorReport).join(", ")
  end

  def link_to_reports_with_type(reports, type = Report)
    reports.map { |r|
      link_to r.name, r.url if r.is_a? type
    }.compact
  end

  def has_error_reports?(reports)
    reports.any? { |r| r.is_a? ErrorReport }
  end

end
