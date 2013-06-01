

class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def new
    wp = WPInstallation.find(params[:wp_installation_id])
    @report = Report.new(wp_installation: wp)
    unless @report.generate
      flash[:error] = 'Failed to generate report, please try again later.'
      redirect_to wp_installations_path
    end
  end

end
