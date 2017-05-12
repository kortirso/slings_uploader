if Category.count == 0
    category_1 = Category.create name: 'Слинги-рюкзаки'
    category_2 = Category.create name: 'Май-слинги'
end

if Category.find_by(name: 'Слинги-рюкзаки').single_name.empty?
    Category.find_by(name: 'Слинги-рюкзаки').update(single_name: 'Слинг-рюкзак')
    Category.find_by(name: 'Май-слинги').update(single_name: 'Май-слинг')
end
