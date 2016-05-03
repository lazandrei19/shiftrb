//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require cocoon
/*global $*/
//= require_tree .
$(() => {
$(".container > .project .feedbacks .reply").click(function(e) {
  
  $(e.target).parents(".feedback-content").next().children(".reply-form").toggle();
});
$(".container > .project .description .more").click(function() {
  $(".container > .project .description .more").hide();
  if($(".container > .project .description .complete").length > 0) {
    $(".container > .project .description .first140").hide();
    $(".container > .project .description .complete").show();
    if ($(".container > .project .description .carousel").length > 0) {
      $(".container > .project .description .carousel").show();
    }
  } else if ($(".container > .project .description .carousel").length > 0) {
    $(".container > .project .description .carousel").show();
  }
});
$(".container > .project .members .more").click(function() {
  $(".container > .project .members .more").hide();
  $(".container > .project .members .hidden").show();
});
$("header .person .settings").click(function () {
  $("header .person .settings-dropdown").toggle();
});
$("header .person .notification-icon").click(function () {
  $("header .person svg.notification-icon").children('path#bg').css("fill", "#efefef");
  $("header .person .notification-dropdown").toggle();
});
var $carousel = $(".image-carousel");
$carousel.find(".carousel-image-container").eq(0).addClass("active");
$carousel.children(".arrow-right").click(function() {
  var $active = $carousel.find(".active");
  if($active.index() + 1 < $carousel.children(".carousel-images").children().length) {
    $active.next().addClass("active");
    $active.removeClass("active");
  }
});
$carousel.children(".arrow-left").click(function() {
  var $active = $carousel.find(".active");
  if($active.index() > 0) {
    $active.prev().addClass("active");
    $active.removeClass("active");
  }
});
$carousel.find(".carousel-image-container").click(function(ev) {
  var src = $(ev.target).attr("src");
  openLightbox(src);
});
var $carouselControl = $(".carousel-control");
$carouselControl.children(".carousel-control-image-container").click(function(ev) {
  var $active = $carousel.find(".active");
  $active.removeClass("active");
  $carousel.find(".carousel-image-container").eq($(ev.target).parent().index()).addClass("active");
});
});

function openLightbox (img_src) {
  var $lightbox = $(".lightbox");
  console.log($lightbox.find(".lightbox-image"));
  $lightbox.find(".lightbox-image").attr("src", img_src);
  $lightbox.show();
  $(window).keydown(function(e) {
    if(e.keyCode === 27)
      $lightbox.hide();
  });
}