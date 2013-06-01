require 'test_helper'

feature 'WPReportFlow Feature Test' do
  before do
    VCR.insert_cassette 'wp-updater-api'
    sign_in_user
  end

  after do
    VCR.eject_cassette
  end

  scenario 'request a report' do
    @wp_installation = create_new_wp_installation
    visit wp_installations_path
    request_report_for_installation @wp_installation
    page.must_have_content "Update Report for #{@wp_installation.name}"
  end
end

def request_report_for_installation(wp)
  page.find("a[href='#{new_wp_installation_report_path(wp)}']").click
end
