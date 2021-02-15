class ListsController < ApplicationController
  def index
    @task = Task.all
  end
end
