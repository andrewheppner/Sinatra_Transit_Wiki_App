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

  $('.slider').slider({full_width: false, interval: 100000});

  $('#subway').click(function(){
    $('#icon').val('2');
  });    

});

