$(document).ready(function () {


    var searchBook = function () {
        var query = $('.key-word').val();
        if (query.replace(/\s+/, "") === "") {
            return false;
        }
        $.ajax({
            url: 'https://api.douban.com/v2/book/search?alt=xd&q=' + query,
            dataType: "jsonp",
            success: function (json) {
                console.log(json);
                showBooks(json);
            }
        });

    }

    var showBooks = function (json) {
        $('.books').empty().append('<p>共<b>' + json.count + '</b>条结果</p>');
        var books = json.books;
        books = $.isArray(books) ? books : books.toArray()
        for (var i = 0; i < books.length; i++) {
            var book = $('<div class="row-fluid"></div>');
            var coverImage = $('<div class="span2"></div>');
            var info = $('<div class="span5"></div>');
            //info detail
            title = $('<h4>' + books[i].title + '</h4>');
            info.append(title);
            if (books[i].author && books[i].author.length > 0) {
                var author = $('<p>作者：' + books[i].author[0] + '</p>');
                info.append(author);
            }
            if (books[i].isbn13) {
                var isbn = $('<p>ISBN:' + books[i].isbn13 + '</p>');
                info.append(isbn);
            }
            if (books[i].publisher) {
                var publisher = $('<p>出版社：' + books[i].publisher + '</p>');
                info.append(publisher);
            }
            coverImage.append('<img class="cover" src="' + books[i].image + '" />');
            var tempForm = '<div class="span3"><form method="post" action="/books">'
                + '<input hidden="true" name="image" value="' + books[i].image + '"/>'
                + '<input hidden="true" name="title" value="' + books[i].title + '"/>'
                + '<input hidden="true" name="isbn" value="' + books[i].isbn13 + '"/>'
                + '<input hidden="true" name="author" value="' + books[i].author[0] + '"/>'
                + '<button class="btn btn-primary add-to-lib"><i class="icon-plus"></i>添加至书库</button>'
                + '</form></div>';
            var addToLib = $(tempForm);
            book.append(coverImage).append(info).append(addToLib);
            $('.books').append(book).append('<hr>').hide().show('slow');

        }

    }

    $('.search-book').bind('click', searchBook);


});