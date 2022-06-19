class DetectListsController < ApplicationController
  include Authenticate

  before_action :authenticate!
  before_action :authenticate_detect_list_user, only: [:edit, :update]

  def index
    @detect_lists = current_user.detect_lists.includes(display_detect_items: :stock)
  end

  def new
    @detect_list = DetectList.new
  end

  def create
    @detect_list = DetectList.new(detect_list_params)
    @detect_list.user = current_user
    @detect_list.save

    redirect_to detect_lists_path
  end

  def edit
  end

  def update
    @detect_list.update(detect_list_params)

    redirect_to detect_lists_path
  end

  private

  def detect_list_params
    params.require(:detect_list).permit(:name)
  end

  def authenticate_detect_list_user
    @detect_list = DetectList.find_by(id: params[:id])

    raise UniversalError.new('List doesn\'t exist', redirect_path: detect_lists_path) if @detect_list.nil?
    raise UniversalError.new('You don\'t have this list edit permission', redirect_path: detect_lists_path) if @detect_list.user_id != current_user.id
  end
end
