require 'rake'
require 'test_helper'

feature 'WPReportFlow Feature Test' do
  before do
    tasks_path = "#{Rails.root}/lib/tasks/pressevent"
    load File.expand_path("#{tasks_path}/automatic_update_report.rake")
    Rake::Task.define_task :environment
    sign_in_user
  end

  feature "successful report generations" do
    scenario 'request a report for an invalid wordpress installation' do
      @wp_installation = create_new_invalid_wp_installation
      visit wp_installations_path
      request_report_for_installation @wp_installation
      page.must_have_content "Failed to generate report, Invalid API Key"
    end
  end

  feature "successful report generations" do
    scenario 'request a report' do
      @wp_installation = create_new_wp_installation
      visit wp_installations_path
      request_report_for_installation @wp_installation
      page.must_have_content "Update Report for #{@wp_installation.name}"
    end

    scenario 'automatic update report' do
      @wp_installation = create_new_wp_installation(autocheck: true)
      Rake::Task['pressevent:automatic_update_report'].invoke
      ActionMailer::Base.deliveries.wont_be_empty
    end
  end
end

def request_report_for_installation(wp)
  page.find("a[href='#{new_wp_installation_report_path(wp)}']").click
end
