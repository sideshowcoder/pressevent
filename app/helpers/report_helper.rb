module ReportHelper
  def link_to_reports(reports)
    raw reports.map { |r| link_to r.name, r.url }.join(", ")
  end
end
