$(document).ready(function(){
    $('.edit-btn').click(function(){
        $('.user-info').hide();
        $('.edit-user').show('slow');
    });

    new Vcity.CitySelector({input:'city_to_choose'});
});