$(document).ready(function(){


    deletebooks = function(){
        $('.btn.btn-danger.btn-mini.hidden').removeClass('hidden');
        $('.delete-books').removeClass('btn-danger')
            .text('取消')
            .unbind('click')
            .click(function(){
                $(this).addClass('btn-danger').text('删除书籍');
                $('.btn.btn-danger.btn-mini').addClass('hidden');
                $(this).unbind('click').bind('click',deletebooks);
            });
    }

    $('.btn.delete-books.btn-danger').bind('click',deletebooks);
});
