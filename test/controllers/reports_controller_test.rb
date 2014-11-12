require 'test_helper'

describe ReportsController do
  describe '#new' do
    before do
      sign_in users(:john_doe)
    end

    it 'renders new' do
      Report.any_instance.stubs(:generate!)
      Report.any_instance.stubs(:core_updates).returns([])
      Report.any_instance.stubs(:plugin_updates).returns([])
      get :new, wp_installation_id: wp_installations(:my_wordpress)
      flash[:notice].must_equal 'Send report email.'
    end

    it 'flashes error when report could not be generated fails' do
      error = Report::GenerationError.new("ERROR")
      Report.any_instance.stubs(:generate!).raises(error)
      get :new, wp_installation_id: wp_installations(:my_wordpress)
      flash[:error].must_equal 'Failed to generate report, ERROR.'
    end
  end
end
