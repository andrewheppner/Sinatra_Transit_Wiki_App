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
    $('#backup').val('Subway')
  });

  $('#bus').click(function(){
    $('#icon').val('mdi-maps-directions-bus yellow-n');
    $('#backup').val('Bus')
  });

  $('#bike').click(function(){
    $('#icon').val('mdi-maps-directions-bike blue-n');
    $('#backup').val('Bike')
  });

  $('#train').click(function(){
    $('#icon').val('mdi-maps-directions-train green-n');
    $('#backup').val('Train')
  });

  $('.button-row').on('mouseenter', 'button', function(e){
    if ($('#transit-name').val() === "") {
      $('#transit-name').val($(this).attr('title'));
    }
  })
  $('.button-row').on('mouseleave', 'button', function(e){
    if ($('#transit-name').val() === $(this).attr('title')) {
      $('#transit-name').val("");
    }
  })

  $(document).ready(function(){
    $('.parallax').parallax();
  });

});

