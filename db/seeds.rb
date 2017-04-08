category = Category.create name: 'Слинги-рюкзаки'
Category.create name: 'Май-слинги'

if Rails.env.development?
    product = Product.new name: 'Розочки', price: 2600, caption: 'Слинг-рюкзак "Розочки", ткань американский хлопок+лен, усовершенствованный вариант, для детей от 7 кг, для родителя от 42 до 56 размера', category: category
    File.open("#{Rails.root}/db/images/flowers.jpg") { |f| product.image = f }
    product.save
end