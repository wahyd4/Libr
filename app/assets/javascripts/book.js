$(document).ready(function(){


    loadBook = function(){
        var isbn = $('input.isbn').val();
        if(isbn === null){
            return;
        }
        $.ajax({
            url:'https://api.douban.com/v2/book/isbn/'+isbn+'?alt=xd',
            dataType:"jsonp",
            success:function(json){
                console.log(json)
                displayBookInfo(json);
            }
        });
    }
    displayBookInfo = function(json){
        $('img.cover').attr('src',json.images.large);
        var ul = $('div.span4 ul');
        ul.append('<li><b>副标题:</b>'+json.subtitle+'</li>');
        ul.append('<li><b>作者:</b>'+json.author[0]+'</li>');
        ul.append('<li><b>出版社:</b>'+json.publisher+'</li>');
        ul.append('<li><b>页数:</b>'+json.pages+'页</li>');
        ul.append('<li><b>ISBN:</b>'+json.isbn13+'</li>');
        ul.append('<li><b>定价:</b>'+json.price+'</li>');
        $('div.well.summary').text(json.author_intro);

    }

    loadBook();



});

