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
  $(".container > .project .description .first140").hide();
  $(".container > .project .description .complete").show();
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
});