$(document).ready(function() {
  $("#vcard a").hover(showVcardLabel, hideVcardLabel);
});

function showVcardLabel() {
  $("#vcard a span").show();
  $("#vcard a span").animate({
    top: "18px",
    opacity: 1
    }, 250 );
}

function hideVcardLabel() {
  $("#vcard a span").animate({
    top: "10px",
    opacity: 0
  }, 250 );
  setTimeout("$('#vcard a span').hide();", 250);
  $("#vcard a span").animate({
    top: "24px",
  }, 250 );
}