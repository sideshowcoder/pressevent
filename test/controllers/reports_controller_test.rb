require 'test_helper'

describe ReportsController do
  describe '#new' do
    before do
      sign_in users(:john_doe)
    end

    it 'renders new' do
      Report.any_instance.stubs(:generate).returns(true)
      Report.any_instance.stubs(:core_updates).returns([])
      Report.any_instance.stubs(:plugin_updates).returns([])
      get :new, wp_installation_id: wp_installations(:my_wordpress)
      assert_template :new
    end

    it 'flashes error when report could not be generated fails' do
      Report.any_instance.stubs(:generate).returns(false)
      get :new, wp_installation_id: wp_installations(:my_wordpress)
      flash[:error].must_equal 'Failed to generate report, please try again later.'
    end
  end
end
