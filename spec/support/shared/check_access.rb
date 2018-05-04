shared_examples_for 'Check access' do
  context 'unauthorized' do
    it 'render error page' do
      do_request

      expect(response).to render_template 'welcome/index'
    end
  end
end
