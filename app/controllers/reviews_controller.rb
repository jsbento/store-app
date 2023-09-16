class ReviewsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.create(review_params)

    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:item_id])
    @review = @item.reviews.find(params[:id])
    @review.destroy

    redirect_to item_path(@item)
  end

  private

  def review_params
    params.require(:review).permit(:author, :body, :status)
  end
end
