shared_examples_for 'authorization' do
  context 'for guest' do
    it 'should render welcome page' do
      do_request

      expect(response).to render_template 'welcome/index'
    end
  end
end
