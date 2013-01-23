$(document).ready(function(){


    var loadBook = function(){
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
    var showTags = function(tags){
        for(var i=0;i<tags.length;i++){
            var tag = $('<span class="label">'+tags[i].title+'</span>');
        }
    }

    var displayBookInfo = function(json){
        $('img.cover').attr('src',json.images.large);
        var ul = $('div.span4 ul');
        ul.append('<li><b>副标题: </b>'+json.subtitle+'</li>');
        ul.append('<li><b>作者: </b>'+json.author[0]+'</li>');
        ul.append('<li><b>出版社: </b>'+json.publisher+'</li>');
        ul.append('<li><b>页数: </b>'+json.pages+'页</li>');
        ul.append('<li><b>ISBN: </b>'+json.isbn13+'</li>');
        ul.append('<li><b>定价: </b>'+json.price+'</li>');
        ul.append('<li><b>出版日期: </b>'+json.pubdate+'</li>');
        ul.append('<li><b>豆瓣评分: </b>'+json.rating.average+'分</li>');
        ul.append('<li><b>标签：</b></li>')
        for(var i=0;i<json.tags.length;i++){
            var tag = $('<span class="label my-label">'+json.tags[i].title+'</span>');
            $('div.well.summary').append(tag).hide().show('slow');
        }

    }

    loadBook();

});

