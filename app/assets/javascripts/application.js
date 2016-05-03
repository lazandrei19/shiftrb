//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require cocoon
/*global $*/
$(() => {
  var $person = $("header .person")
  var $settingsIcon = $person.find(".settings");
  var $settingsDropdown = $person.find(".settings-dropdown");
  var $notificationIcon = $person.find(".notification-icon");
  var $notificationDropdown = $person.find(".notification-dropdown");

  $settingsIcon.click(function () {
    $settingsDropdown.toggle();
  });
  $notificationIcon.click(function () {
    $notificationIcon.children('path#bg').css("fill", "#efefef");
    $notificationDropdown.toggle();
  });
});
