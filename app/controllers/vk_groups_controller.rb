class VkGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :update
  before_action :find_vk_group

  def update
    @vk_group.update(vk_group_params)
    redirect_to integration_path(current_user)
  end

  private def find_vk_group
    @vk_group = VkGroup.find_by(id: params[:id])
    render_not_found if @vk_group.nil? || @vk_group.user_id != current_user.id
  end

  private def vk_group_params
    p = params.require(:vk_group).permit!.to_h
    p['albums_attributes'].delete_if { |_key, value| value['album_id'].empty? }
    p
  end
end
