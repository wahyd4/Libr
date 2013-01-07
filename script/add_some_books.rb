class AddSomeBooks
	User.create email:'test@test.com', name:'Test'
	User.first.books.create name:'看见', image:'http:\/\/img3.douban.com\/mpic\/s24514758.jpg',isbn:'9787549529322'
	User.first.books.create name:'寻路中国', image:'http:\/\/img5.douban.com\/mpic\/s4575849.jpg',isbn:'9787532752805'
	User.first.books.create name:'送你一颗子弹', image:'http:\/\/img3.douban.com\/mpic\/s4243447.jpg',isbn:'9787542631664'
end