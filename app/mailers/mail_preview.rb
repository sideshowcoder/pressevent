class MailPreview < MailView
  def report
    wp_one = WPInstallation.new(name: 'test', url: 'http://test.com', api_key: '12345')
    wp_two = WPInstallation.new(name: 'test_two', url: 'http://test.com', api_key: '12345')

    update_core = Update.new(name: 'core', installed: '1.1.0', current: '1.2.0' )
    update_plugin_one = Update.new(name: 'foo', installed: '2.1.0', current: '3.2.0' )
    update_plugin_two = Update.new(name: 'bar', installed: '2.1.0', current: '3.2.0' )
    updates = [update_core, update_plugin_one, update_plugin_two]

    one = Report.new(wp_installation: wp_one, updates: updates)
    two = Report.new(wp_installation: wp_two, updates: updates)
    three = ErrorReport.new("Invalid API Key", "test invalid", one.url)
    reports = [one, two, three]

    mail = ReportMailer.daily("me@example.com", reports)
  end

  def report_requested
    wp_one = WPInstallation.new(name: 'test', url: 'http://test.com', api_key: '12345')

    update_core = Update.new(name: 'core', installed: '1.1.0', current: '1.2.0' )
    update_plugin_one = Update.new(name: 'foo', installed: '2.1.0', current: '3.2.0' )
    update_plugin_two = Update.new(name: 'bar', installed: '2.1.0', current: '3.2.0' )
    updates = [update_core, update_plugin_one, update_plugin_two]

    one = Report.new(wp_installation: wp_one, updates: updates)

    mail = ReportMailer.requested("me@example.com", one)
  end
end
