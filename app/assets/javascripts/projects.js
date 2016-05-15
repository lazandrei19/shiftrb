//= require turbolinks
/*global $*/
$(() => {
  var $project = $(".container > .project");
  var $lightbox = $project.siblings(".lightbox");
  var $lightboxImage = $lightbox.find(".lightbox-image");
  var $replyButtons = $project.find(".feedbacks .reply");
  var $description = $project.find(".description-content");
  var $moreDesc = $description.children(".more");
  var $complete = $description.children(".complete");
  var $first140 = $description.children(".first140");
  var $carousel = $description.children(".carousel");
  var $carouselImages = $carousel.find("carousel-image-container");
  var $carouselControl = $carousel.children(".carousel-control");
  var $carouselControlImages = $carouselControl.children(".carousel-control-image-container");
  var $members = $project.children("members");
  var $moreMembers = $members.find(".more");
  var $hiddenMembers = $members.find(".hidden");

  $replyButtons.click(openReplyBox);
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
  $moreMembers.click(function() {
    $moreMembers.hide();
    $hiddenMembers.show();
  });
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

  function openReplyBox(e) {
    $(e.target).parents(".feedback-content").next().children(".reply-form").toggle();
  }

});
