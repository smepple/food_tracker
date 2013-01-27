class SourcesController < ApplicationController

  def index
    @sources = Source.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @sources.map(&:name)
  end
end
