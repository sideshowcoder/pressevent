class ReportsController < ApplicationController
  before_filter :authenticate_user!


  def new
    wp = WPInstallation.find(params[:wp_installation_id])
    @report = Report.new(wp_installation: wp)
    begin
      @report.generate!
    rescue Report::GenerationError => e
      flash[:error] = "Failed to generate report, #{e.message}."
      redirect_to wp_installations_path
    end
  end

end
