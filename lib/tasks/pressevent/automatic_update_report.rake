namespace :pressevent do
  desc <<-DESC
  sent reports to all users whom's wordpress installations which are set to auto checking, have updates
  DESC
  task automatic_update_report: :environment do
    User.with_autochecking_installations.each { |u|
      UserUpdateNotifier.new(u).notify
    }
  end
end
