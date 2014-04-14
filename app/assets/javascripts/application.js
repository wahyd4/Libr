//= require jquery
//= require jquery_ujs

$(document).ready(function () {
    if (window.location.href.lastIndexOf('libr.herokuapp.com') !== -1) {

        if (confirm('此网站已经迁移至: http://librme.com,点击确定跳转到该网站')) {
            window.location.href = 'http://librme.com'
        }
    }
});
