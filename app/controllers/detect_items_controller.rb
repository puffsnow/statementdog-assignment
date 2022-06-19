class DetectItemsController < ApplicationController
  include Authenticate

  before_action :authenticate!
  before_action :authenticate_detect_list_user

  def move
    raise UniversalError.new('Direction is needed', redirect_path: detect_lists_path) if params['direction'].nil?

    @detect_item.move(direction: params['direction'])

    redirect_to detect_lists_path
  end

  private

  def authenticate_detect_list_user
    @detect_item = DetectItem.find_by(id: params[:id])
    @detect_list = @detect_item.detect_list

    raise UniversalError.new('List doesn\'t exist', redirect_path: detect_lists_path) if @detect_list.nil?
    raise UniversalError.new('You don\'t have this list edit permission', redirect_path: detect_lists_path) if @detect_list.user_id != current_user.id
  end
end
