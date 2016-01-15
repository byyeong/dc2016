!function($) {

   var defaults = {
      sectionContainer: "section",
      …
   };

   $.fn.onepage_scroll = function(options) {
      var settings = $.extend({}, defaults, options);
      …
   }

}($)





var sections = $(settings.sectionContainer);
var topPos = 0;

$.each(sections, function(i) {
   $(this).css({
      position: "absolute",
      top: topPos + "%"
   }).addClass("ops-section").attr("data-index", i+1);
   topPos = topPos + 100;
});





function init_scroll(event, delta) {
   var deltaOfInterest = delta,
   timeNow = new Date().getTime(),
   quietPeriod = 200;
   
   // Cancel scroll if currently animating or within quiet period
   if(timeNow - lastAnimation < quietPeriod + settings.animationTime) {
      event.preventDefault();
      return;
   }

   if (deltaOfInterest < 0) {
      el.moveDown()
   } else {
      el.moveUp()
   }
   lastAnimation = timeNow;
}

$(document).bind('mousewheel DOMMouseScroll', function(event) {
   event.preventDefault();
   var delta = event.originalEvent.wheelDelta || -event.originalEvent.detail;
   init_scroll(event, delta);
});

var timeNow = new Date().getTime(),
quietPeriod = 200;
…
if(timeNow - lastAnimation < quietPeriod + settings.animationTime) {
   event.preventDefault();
   return;
}
…
lastAnimation = timeNow;

if (deltaOfInterest < 0) {
   el.moveDown()
} else {
   el.moveUp()
}

$.fn.transformPage = function(settings, pos, index) {
   …
   $(this).css({
      "-webkit-transform": ( settings.direction == 'horizontal' ) ? "translate3d(" + pos + "%, 0, 0)" : "translate3d(0, " + pos + "%, 0)",
      "-webkit-transition": "all " + settings.animationTime + "ms " + settings.easing,
      "-moz-transform": ( settings.direction == 'horizontal' ) ? "translate3d(" + pos + "%, 0, 0)" : "translate3d(0, " + pos + "%, 0)",
      "-moz-transition": "all " + settings.animationTime + "ms " + settings.easing,
      "-ms-transform": ( settings.direction == 'horizontal' ) ? "translate3d(" + pos + "%, 0, 0)" : "translate3d(0, " + pos + "%, 0)",
      "-ms-transition": "all " + settings.animationTime + "ms " + settings.easing,
      "transform": ( settings.direction == 'horizontal' ) ? "translate3d(" + pos + "%, 0, 0)" : "translate3d(0, " + pos + "%, 0)",
      "transition": "all " + settings.animationTime + "ms " + settings.easing
   });
   …
}
var defaults = {
   responsiveFallback: false
   …
};

function responsive() {
   if ($(window).width() < settings.responsiveFallback) {
      $("body").addClass("disabled-onepage-scroll");
      $(document).unbind('mousewheel DOMMouseScroll');
      el.swipeEvents().unbind("swipeDown swipeUp");
   } else {
      if($("body").hasClass("disabled-onepage-scroll")) {
         $("body").removeClass("disabled-onepage-scroll");
         $("html, body, .wrapper").animate({ scrollTop: 0 }, "fast");
      }

      el.swipeEvents().bind("swipeDown",  function(event) {
         if (!$("body").hasClass("disabled-onepage-scroll")) event.preventDefault();
         el.moveUp();
      }).bind("swipeUp", function(event){
         if (!$("body").hasClass("disabled-onepage-scroll")) event.preventDefault();
         el.moveDown();
      });

      $(document).bind('mousewheel DOMMouseScroll', function(event) {
         event.preventDefault();
         var delta = event.originalEvent.wheelDelta || -event.originalEvent.detail;
         init_scroll(event, delta);
      });
   }
}