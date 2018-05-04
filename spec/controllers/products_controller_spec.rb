RSpec.describe ProductsController, type: :controller do
  describe 'GET #show' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      sign_in_user

      context 'if product does not exist' do
        before { get :show, params: { id: 999 } }

        it 'renders error page' do
          expect(response).to render_template 'shared/404'
        end
      end

      context 'if product exists' do
        let!(:product) { create :product }
        before { get :show, params: { id: product.slug } }

        it 'renders show page' do
          expect(response).to render_template :show
        end
      end
    end

    def do_request
      get :show, params: { id: 999 }
    end
  end

  describe 'GET #new' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      context 'for simple user' do
        sign_in_user
        before { get :new }

        it 'renders error page' do
          expect(response).to render_template 'shared/404'
        end
      end

      context 'for admin user' do
        sign_in_admin
        before { get :new }

        it 'renders new page' do
          expect(response).to render_template :new
        end
      end
    end

    def do_request
      get :new
    end
  end

  describe 'GET #edit' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      context 'for simple user' do
        sign_in_user
        before { get :edit, params: { id: 999 } }

        it 'renders error page' do
          expect(response).to render_template 'shared/404'
        end
      end

      context 'for admin user' do
        sign_in_admin

        context 'if product does not exist' do
          before { get :edit, params: { id: 999 } }

          it 'renders error page' do
            expect(response).to render_template 'shared/404'
          end
        end

        context 'if product exists' do
          let!(:product) { create :product }
          before { get :edit, params: { id: product.slug } }

          it 'renders edit page' do
            expect(response).to render_template :edit
          end
        end
      end
    end

    def do_request
      get :edit, params: { id: 999 }
    end
  end

  describe 'POST #create' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      context 'for simple user' do
        sign_in_user
        let(:request) { post :create, params: { product: {} } }

        it 'does not create new product' do
          expect { request }.to_not change(Product, :count)
        end

        it 'and renders error page' do
          request

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for admin user' do
        sign_in_admin

        context 'for invalid params' do
          let(:request) { post :create, params: { product: { name: '', category: nil, price: 0 } } }

          it 'does not create new product' do
            expect { request }.to_not change(Product, :count)
          end

          it 'and renders error page' do
            request

            expect(response).to redirect_to new_product_path
          end
        end

        context 'for valid params' do
          let!(:category) { create :category }
          let(:request) { post :create, params: { product: { name: '1', category_id: category.id, price: 100 } } }

          it 'creates new product' do
            expect { request }.to change(Product, :count).by(1)
          end

          it 'and redirects to product' do
            request

            expect(response).to redirect_to product_path(Product.last.slug)
          end
        end
      end
    end

    def do_request
      post :create, params: { product: {} }
    end
  end

  describe 'PATCH #update' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      let!(:product) { create :product }

      context 'for simple user' do
        sign_in_user
        let(:request) { patch :update, params: { id: product.id, product: {} } }

        it 'does not update product' do
          old_product = product
          request
          product.reload

          expect(product).to eq old_product
        end

        it 'and renders error page' do
          request

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for admin user' do
        sign_in_admin

        context 'for invalid params' do
          let(:request) { patch :update, params: { id: product.id, product: { price: -1 } } }

          it 'does not update product' do
            old_product = product
            request
            product.reload

            expect(product).to eq old_product
          end

          it 'and renders edit page' do
            request

            expect(response).to render_template :edit
          end
        end

        context 'for valid params' do
          let(:request) { patch :update, params: { id: product.id, product: { price: product.price + 1 } } }

          it 'updates product' do
            old_price = product.price
            request
            product.reload

            expect(old_price != product.price).to eq true
          end

          it 'and redirects to product' do
            request

            expect(response).to redirect_to product_path(product.slug)
          end
        end
      end
    end

    def do_request
      patch :update, params: { id: 999, product: {} }
    end
  end

  describe 'DELETE #destroy' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      let!(:product) { create :product }

      context 'for simple user' do
        sign_in_user
        let(:request) { delete :destroy, params: { id: product.id } }

        it 'does not delete product' do
          expect { request }.to_not change(Product, :count)
        end

        it 'and renders error page' do
          request

          expect(response).to render_template 'shared/404'
        end
      end

      context 'for admin user' do
        sign_in_admin

        context 'if product does not exist' do
          let(:request) { delete :destroy, params: { id: 999 } }

          it 'does not delete product' do
            expect { request }.to_not change(Product, :count)
          end

          it 'and renders error page' do
            request

            expect(response).to render_template 'shared/404'
          end
        end

        context 'for valid params' do
          let(:request) { delete :destroy, params: { id: product.id } }

          it 'does not destroy product' do
            expect { request }.to_not change(Product, :count)
          end

          it 'and calls delete method' do
            expect_any_instance_of(Product).to receive(:delete)

            request
          end

          it 'and redirects to product' do
            request

            expect(response).to redirect_to product_path(product.slug)
          end
        end
      end
    end

    def do_request
      delete :destroy, params: { id: 999, product: {} }
    end
  end

  describe 'POST #mass_inserting' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      sign_in_user

      context 'for invalid params' do
        it 'does not call perform for CatalogPublishingJob' do
          expect(CatalogPublishingJob).to_not receive(:perform_later)

          post :mass_inserting
        end
      end

      context 'for valid params' do
        let!(:album1) { create :album, name: 'Базовая коллекция', vk_group: @current_user.vk_group }
        let!(:album2) { create :album, name: 'Коллекция Весна-Лето', vk_group: @current_user.vk_group }
        let!(:album3) { create :album, name: 'Коллекция Остатки сладки', vk_group: @current_user.vk_group }

        it 'calls perform for CatalogPublishingJob' do
          expect(CatalogPublishingJob).to receive(:perform_later)

          post :mass_inserting
        end
      end
    end

    def do_request
      post :mass_inserting
    end
  end
end
