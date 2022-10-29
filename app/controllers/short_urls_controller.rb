class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @test = ShortUrl.all
    render json: @test
  end

  def create
    #short_url = ShortUrl.new(full_url: params[:full_url], title: "")
    short_url = ShortUrl.new(short_url_params)
    puts short_url

    if short_url.save
      render json: short_url, status: :created # I can also return the status code, like 200

    else
      render json: short_url.errors, status: :unprocessable_entity # Code error 422
    end
  end

  private

  def short_url_params
    defaults = {title: ""}
    params.require(:short_url).permit(:full_url, :title).reverse_merge(defaults)
  end

  def show
  end

end
