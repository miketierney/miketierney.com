$(document).ready(function() {
  $("#vcard a").hover(
    function() {
      $("#vcard a span").show();
      $("#vcard a span").animate({
        top: "18px",
        opacity: 1
        }, 250 );
    },
    function() {
      $("#vcard a span").animate({
        top: "10px",
        opacity: 0
      }, 250 );
      setTimeout("$('#vcard a span').hide();", 250);
      $("#vcard a span").animate({
        top: "24px",
      }, 250 );
    });
});