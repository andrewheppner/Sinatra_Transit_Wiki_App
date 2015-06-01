$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $(".button-collapse").sideNav({belowOrigin: true});

  $('a#toggle-search').click(function()
    {
        var search = $('div#search');

        search.is(":visible") ? search.slideUp() : search.slideDown(function()
        {
            search.find('input').focus();
        });

        return false;
    });

  $('.collapsible').collapsible({
      accordion : false
    });

  $('.slider').slider({full_width: false, interval: 10000000, height: 300});

  $('#subway').click(function(){
    $('#icon').val('mdi-maps-directions-subway red-n');
  });

  $('#bus').click(function(){
    $('#icon').val('mdi-maps-directions-bus yellow-n');
  });

  $('#bike').click(function(){
    $('#icon').val('mdi-maps-directions-bike blue-n');
  });

  $('#train').click(function(){
    $('#icon').val('mdi-maps-directions-train green-n');
  });

});

