class CompletionsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @completions = @category.completions.order(id: "DESC").page(params[:page]).per(5)
  end
end
