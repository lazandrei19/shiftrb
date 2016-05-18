//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require lodash
//= require turbolinks
//= require cocoon
//= require cocoon_limiter
/*global $*/
$(() => {
  var $person = $("header .person");
  var $settingsIcon = $person.find(".settings");
  var $settingsDropdown = $person.find(".settings-dropdown");
  var $notificationIcon = $person.find(".notification-icon");
  var $notificationDropdown = $person.find(".notification-dropdown");
  var $userRegistrationForm = $(".user-registration-form");
  var $avatarFileUpload = $userRegistrationForm.find(".input-avatar");
  var $avatarFakeFile = $userRegistrationForm.find(".fake-avatar-input");
  var $nameInputs = $userRegistrationForm.find(".multiple-inputs.user-inputs");
  var $firstName = $nameInputs.find(".first-name");
  var $lastName = $nameInputs.find(".last-name");
  var $completeName = $nameInputs.find(".complete-name");
  var $names = $nameInputs.children().not(".complete-name");

  $names.change(() => {
    $completeName.val($firstName.val() + " " + $lastName.val());
  });

  $settingsIcon.click(() => {
    $settingsDropdown.toggle();
  });

  $notificationIcon.click(() => {
    $.ajax("/misc/clearNotif", {
      method: "PUT"
    });
    $notificationIcon.children('path#bg').css("fill", "#efefef");
    $notificationDropdown.toggle();
  });

  $avatarFileUpload.change(() => {
    $avatarFakeFile.text($avatarFileUpload.val().split('\\').pop());
  });

  $('.workplace-adder').cocoon_limiter();
});

window.onbeforeunload = function(e) {
  $.ajax("/misc/clearFirstTime");
};