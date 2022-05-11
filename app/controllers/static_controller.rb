class StaticController < ApplicationController
  def home
    render json: {status: "WDR API Working!"}
  end
end
