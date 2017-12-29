FactoryBot.define do
    factory :category do
        sequence(:name) { |i| "Category Name #{i}" }
    end
end
