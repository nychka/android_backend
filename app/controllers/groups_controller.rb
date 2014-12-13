class GroupsController < InheritedResources::Base

  private

    def group_params
      params.require(:group).permit(:title)
    end
end

