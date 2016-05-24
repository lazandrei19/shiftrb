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
  var $search = $(".search");
  var $searchInput = $search.find(".search-input");
  var $searchDropdown = $search.find(".search-dropdown");
  var $userRegistrationForm = $(".user-registration-form");
  var $avatarFileUpload = $userRegistrationForm.find(".input-avatar");
  var $avatarFakeFile = $userRegistrationForm.find(".fake-avatar-input");
  var $nameInputs = $userRegistrationForm.find(".multiple-inputs.user-inputs");
  var $firstName = $nameInputs.find(".first-name");
  var $lastName = $nameInputs.find(".last-name");
  var $completeName = $nameInputs.find(".complete-name");
  var $names = $nameInputs.children().not(".complete-name");
  var $newProjectForm = $(".new-project-form");
  var $logoFileUpload = $newProjectForm.find(".new-project-input-logo");
  var $logoFakeFile = $newProjectForm.find(".fake-logo-input");
  var $project = $(".container > .project");
  var $lightbox = $project.siblings(".lightbox");
  var $lightboxImage = $lightbox.find(".lightbox-image");
  var $replyButtons = $project.find(".feedbacks .reply");
  var $description = $project.find(".description-content");
  var $moreDesc = $description.children(".more");
  var $complete = $description.children(".complete");
  var $first140 = $description.children(".first140");
  var $carousel = $description.children(".carousel");
  var $carouselImages = $carousel.find(".carousel-image-container");
  var $carouselControl = $carousel.children(".carousel-control");
  var $carouselControlImages = $carouselControl.children(".carousel-control-image-container");
  var $members = $project.children("members");
  var $moreMembers = $members.find(".more");
  var $hiddenMembers = $members.find(".hidden");
  var $searchResults = $(".search-results");
  var $usersSearchArea = $searchResults.find(".users");
  var $projectsSearchArea = $searchResults.find(".projects");
  var $searchMoreUsers = $usersSearchArea.find(".more-user");
  var $searchMoreProjects = $projectsSearchArea.find(".more-project");
  var projectPage = 1;
  var userPage = 1;

  /*
   * PROJECTS AREA
   */

  //Reply button
  $replyButtons.click(openReplyBox);

  //Open description
  $moreDesc.click(function() {
    $moreDesc.hide();
    if($complete.length > 0) {
      $first140.hide();
      $complete.show();
      if ($carousel.length > 0) {
        $carousel.show();
      }
    } else if ($carousel.length > 0) {
      $carousel.show();
    }
  });

  //Show more memebers
  $moreMembers.click(function() {
    $moreMembers.hide();
    $hiddenMembers.show();
  });

  /*
   * Beggining of carousel control
   */
  $carouselImages.eq(0).addClass("active");
  $carousel.children(".arrow-right").click(function() {
    var $active = $carouselImages.siblings().find(".active");
    if($active.index() + 1 < $carouselImages.length) {
      $active.next().addClass("active");
      $active.removeClass("active");
    }
  });
  $carousel.children(".arrow-left").click(function() {
    var $active = $carouselImages.siblings().find(".active");
    if($active.index() > 0) {
      $active.prev().addClass("active");
      $active.removeClass("active");
    }
  });
  $carouselImages.click(function(ev) {
    var src = $(ev.target).attr("src");
    openLightbox(src);
  });
  $carouselControlImages.click(function(ev) {
    var $active = $carouselImages.siblings().find(".active");
    $active.removeClass("active");
    $carouselImages.eq($(ev.target).parent().index()).addClass("active");
  });

  function openLightbox (img_src) {
    $lightboxImage.attr("src", img_src);
    $lightbox.show();
    $(window).keydown(function(e) {
      if(e.keyCode === 27)
        $lightbox.hide();
    });
  }

  /*
   * End of carousel control
   */

  function openReplyBox(e) {
    $(e.target).parents(".feedback-content").next().children(".reply-form").toggle();
  }

  /*
   * End of projects
   * Form Helper
   */

  $names.change(() => {
    $completeName.val($firstName.val() + " " + $lastName.val());
  });

  $avatarFileUpload.change(() => {
    $avatarFakeFile.text($avatarFileUpload.val().split('\\').pop());
  });

  $logoFileUpload.change(() => {
    $logoFakeFile.text($logoFileUpload.val().split('\\').pop());
  });

  $('.workplace-adder').cocoon_limiter();

  /*
   * Dropdown helpers
   */

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

  $searchInput.focusin(() => {
    $searchDropdown.show();
  });

  $searchInput.focusout(() => {
    setTimeout(() => {
      $searchDropdown.hide();
    }, 100);
  });

  $searchInput.keyup(() => {
    $.ajax("/predictions/?q=" + $searchInput.val(), {
      success: function(data) {
        $searchDropdown.html(data);
      }
    });
  });

  $searchMoreProjects.click(() => {
    $.ajax({
      url: "/misc/moreProjects?q=" + $searchInput.val() + "&page=" + ++projectPage,
      success: function(data) {
        if (data.length > 0)
          $searchMoreProjects.parent().before(data);
        else
          $searchMoreProjects.parent().hide();
      }
    });
  });

  $searchMoreUsers.click(() => {
    $.ajax({
      url: "/misc/moreUsers?q=" + $searchInput.val() + "&page=" + ++userPage,
      success: function(data) {
        if (data.length > 0)
          $searchMoreUsers.parent().before(data);
        else
          $searchMoreUsers.parent().hide();
      }
    });
  });
});