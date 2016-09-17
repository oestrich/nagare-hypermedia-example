class HomeController < ApplicationController
  class Root
  end

  def index
    render :json => Root.new, :serializers => { :item => RootSerializer }
  end
end
