class WPInstallationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @wp_installations = current_user.wp_installations
  end

  def new
    @wp_installation = WPInstallation.new
  end

  def edit
    @wp_installation = current_user.wp_installations.find(params[:id])
  end

  def destroy
    if WPInstallation.destroy(params[:id])
      flash[:notice] = "Unregistered Wordpress installation."
    end
    redirect_to action: :index
  end

  def update
    @wp_installation = current_user.wp_installations.find(params[:id])
    if @wp_installation.update_attributes(wp_installation_params)
      flash[:notice] = "Updated Wordpress installation."
      redirect_to action: :index
    else
      render :edit
    end
  end

  def create
    @wp_installation = current_user.wp_installations.build(wp_installation_params)

    if @wp_installation.save
      flash[:notice] = "Registered new Wordpress installation."
      redirect_to action: :index
    else
      render :new
    end
  end

  private
  def wp_installation_params
    fields = [:name, :url, :api_key, :auto_checking]
    params.require(:wp_installation).permit(fields)
  end
end
