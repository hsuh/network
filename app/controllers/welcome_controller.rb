class WelcomeController < ApplicationController
  def index
    @gemtest = Holahsu.hi
  end
end
