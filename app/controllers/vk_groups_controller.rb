class VkGroupsController < ApplicationController
    before_action :find_vk_group

    def update
        @vk_group.update(vk_group_params)
    end

    private

    def find_vk_group
        @vk_group = VkGroup.find(params[:id])
        render_not_found if @vk_group.user_id != current_user.id
    end

    def vk_group_params
        params.require(:vk_group).permit(:group_id, albums_attributes: [:vk_id, :vk_group_id, :id])
    end
end