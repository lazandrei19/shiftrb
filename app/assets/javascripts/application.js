//= require jquery
//= require jquery_ujs
//= require lodash
//= require turbolinks
//= require cocoon
/*global $*/
$(() => {
  var $person = $("header .person");
  var $settingsIcon = $person.find(".settings");
  var $settingsDropdown = $person.find(".settings-dropdown");
  var $notificationIcon = $person.find(".notification-icon");
  var $notificationDropdown = $person.find(".notification-dropdown");

  $settingsIcon.click(() => {
    console.log('a');
    $settingsDropdown.toggle();
  });

  $notificationIcon.click(() => {
    $notificationIcon.children('path#bg').css("fill", "#efefef");
    $notificationDropdown.toggle();
  });
});
