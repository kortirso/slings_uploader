namespace :patching do
    desc 'Add new category'
    task patch_1: :environment do
        Category.create name: 'Ткани', single_name: 'Ткань'
    end
end