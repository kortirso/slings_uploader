class VkGroupsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :update
    before_action :find_vk_group

    def update
        @vk_group.update(vk_group_params)
        redirect_to current_user
    end

    private

    def find_vk_group
        @vk_group = VkGroup.find(params[:id])
        render_not_found if @vk_group.user_id != current_user.id
    end

    def vk_group_params
        p = params.require(:vk_group).permit(:group_id, archive_attributes: [:album_id, :vk_group_id, :id], albums_attributes: [:album_id, :album_name, :vk_group_id, :id]).to_h
        p['albums_attributes'].delete_if { |key, value| value['album_id'].empty? }
        p
    end
end