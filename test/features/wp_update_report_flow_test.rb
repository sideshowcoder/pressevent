require 'test_helper'
require 'rake'

feature 'WPReportFlow Feature Test' do
  before do
    VCR.insert_cassette 'wp-updater-api'
    load File.expand_path("#{Rails.root}/lib/tasks/automatic_update_report.rake")
    Rake::Task.define_task :environment
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

  scenario 'automatic update report' do
    @wp_installation = create_new_wp_installation_with_automatic_check
    Rake::Task['pressevent:automatic_update_report'].invoke
    ActionMailer::Base.deliveries.wont_be_empty
  end

end

def request_report_for_installation(wp)
  page.find("a[href='#{new_wp_installation_report_path(wp)}']").click
end
