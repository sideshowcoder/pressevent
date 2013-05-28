class WordpressInstancesController < ApplicationController
  def new
    @wordpress_instance = WordpressInstance.new
  end

  def create
  end
end
