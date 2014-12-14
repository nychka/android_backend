class GroupsController < ApplicationController
  before_action :authenticate_user!
  private

    def group_params
      params.require(:group).permit(:title)
    end
end

