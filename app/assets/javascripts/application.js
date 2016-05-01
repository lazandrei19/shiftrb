//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require cocoon
/*global $*/
//= require_tree .
$(() => {
$('.image-carousel').slick();
$("header .person .settings").click(function () {
  $("header .person .settings-dropdown").toggle();
});
$("header .person .notification-icon").click(function () {
  $("header .person svg.notification-icon").children('path#bg').css("fill", "#efefef");
  $("header .person .notification-dropdown").toggle();
});
});