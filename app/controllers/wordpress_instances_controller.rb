class WordpressInstancesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @wordpress_instances = []
  end

  def new
    @wordpress_instance = WordpressInstance.new
  end

  def create
    @wordpress_instance = current_user.wordpress_instances.build(wordpress_instance_params)

    if @wordpress_instance.save
      flash[:notice] = "Registered new Wordpress installation."
      redirect_to action: :index
    else
      render :new
    end
  end

  private
  def wordpress_instance_params
    fields = [:name, :url, :api_key, :auto_checking]
    params.require(:wordpress_instance).permit(fields)
  end
end
