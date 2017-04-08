RSpec.describe UsersController, type: :controller do
    describe 'GET #index' do
        it_behaves_like 'authorization'

        context 'for user' do
            sign_in_user

            it 'should render index view' do
                get :index

                expect(response).to render_template :index
            end
        end

        def do_request
            get :index
        end
    end

    describe 'GET #show' do
        it_behaves_like 'authorization'

        context 'for user' do
            sign_in_user

            context 'for users page' do
                before { get :show, params: {id: @current_user.id} }

                it 'assigns the users vk_group to @vk_group' do
                    expect(assigns(:vk_group)).to eq @current_user.vk_group
                end

                it 'and should render show view' do
                    expect(response).to render_template :show
                end
            end

            context 'for another users page' do

            end
        end

        def do_request
            get :show, params: {id: 1}
        end
    end
end