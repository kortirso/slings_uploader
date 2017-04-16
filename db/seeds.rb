if Category.count == 0
    category_1 = Category.create name: 'Слинги-рюкзаки'
    category_2 = Category.create name: 'Май-слинги'
end

if Category.find_by(name: 'Слинги-рюкзаки').single_name.empty?
    Category.find_by(name: 'Слинги-рюкзаки').update(single_name: 'Слинг-рюкзак')
    Category.find_by(name: 'Май-слинги').update(single_name: 'Май-слинг')
end

if Rails.env.development? && Product.count == 0
    product = Product.new name: 'Розочки', price: 2600, caption: 'Слинг-рюкзак "Розочки", ткань американский хлопок+лен, усовершенствованный вариант, для детей от 7 кг, для родителя от 42 до 56 размера', category: category_1
    File.open("#{Rails.root}/db/images/flowers.jpg") { |f| product.image = f }
    product.save
end