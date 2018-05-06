class VkGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_vk_group

  def update
    @vk_group.update(vk_group_params)
    redirect_to integration_path(current_user)
  end

  private def find_vk_group
    @vk_group = current_user.vk_group
  end

  private def vk_group_params
    p = params.require(:vk_group).permit!.to_h
    p['albums_attributes'].delete_if { |_key, value| value['identifier'].empty? }
    p
  end
end
