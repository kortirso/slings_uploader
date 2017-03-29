class UsersController < ApplicationController
    before_action :check_user, only: :show

    def index

    end

    def show

    end

    private

    def check_user
        render_not_found if current_user.id != params[:id].to_i
    end
end