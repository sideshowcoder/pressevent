require 'rake'
require 'test_helper'

describe 'Pressevent::AutomaticUpdateReportTaskTest' do
  it 'calls the user notifier for a user with autochecking installations' do
    user = mock()
    notifier = mock()
    User.stubs(:with_autochecking_installations).returns([user])
    UserUpdateNotifier.expects(:new).with(user).returns(notifier)
    notifier.expects(:notify).once
    subject.invoke
  end
end
