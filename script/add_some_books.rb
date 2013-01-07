class AddSomeBooks
	User.create email:'test@test.com', name:'Test'
	User.first.books.create name:'看见', image:'http:\/\/img3.douban.com\/mpic\/s24514758.jpg',isbn:'9787549529322'
end