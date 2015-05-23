require 'test_helper'

describe UserUpdateNotifier do
  before do
    @john = users(:john_doe)
    @wp = @john.wp_installations.first
  end

  describe 'sent mail' do
    before do
      report = Report.new(wp_installation: @wp)
      Report.any_instance.stubs(:generate!).returns(report)
    end

    it 'sends for non-empty reports' do
      Report.any_instance.expects(:updates_available?).returns(true)
      ReportMailer.any_instance.expects(:daily)
      UserUpdateNotifier.new(@john).notify
    end

    it 'does not sent for empty reports' do
      Report.any_instance.stubs(:updates_available?).returns(false)
      ReportMailer.expects(:daily).never
      UserUpdateNotifier.new(@john).notify
    end
  end

  it 'handles backend exceptions' do
    report = Report.new(wp_installation: @wp)
    Report.any_instance.stubs(:generate!).raises(Report::GenerationError)
    UserUpdateNotifier.new(@john).notify
  end
end
