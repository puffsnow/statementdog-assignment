class DetectLists::DetectItemsController < ApplicationController
  include Authenticate

  before_action :authenticate!
  before_action :authenticate_detect_list_user

  def new
    @stocks = Stock.all
  end

  def create
    @stock = Stock.find_by(code: params[:code])
    raise UniversalError.new('Stock doesn\'t exist', redirect_path: detect_lists_path) if @stock.nil?

    @detect_item = @detect_list.detect_items.find_or_create_by(stock: @stock)
    redirect_to detect_lists_path
  end

  private

  def authenticate_detect_list_user
    @detect_list = DetectList.find_by(id: params[:detect_list_id])

    raise UniversalError.new('List doesn\'t exist', redirect_path: detect_lists_path) if @detect_list.nil?
    raise UniversalError.new('You don\'t have this list edit permission', redirect_path: detect_lists_path) if @detect_list.user_id != current_user.id
  end
end
