window.Manipulator = (function($) {
  'use strict';

  var hasConsole = window.console && typeof window.console.log === 'function';

  var Manipulator = function( element ) {
    var self = this;

    self.$el = $( element );
    self.init();
  };

  Manipulator.prototype.init = function() {
    var self = this;
    self.initShuffle();
  };

  // Column width and gutter width options can be functions
  Manipulator.prototype.initShuffle = function() {
    this.$el.shuffle({
      itemSelector: '.box',
      speed: 250,
      easing: 'ease',
      columnWidth: function( containerWidth ) {
        // .box's have a width of 18%
        return 0.18 * containerWidth;
      },
      gutterWidth: function( containerWidth ) {
        // .box's have a margin-left of 2.5%
        return 0.025 * containerWidth;
      }
    });

    // Shuffle is stored in the elements data with jQuery.
    // You can access the class instance here
    this.shuffle = this.$el.data('shuffle');
  };

  Manipulator.prototype.onAddClick = function(next, c) {

    var self = this;

    self.$el = $( document.getElementById('grid') );
    self.init();
    // Creating random elements. You could use an
    // ajax request or clone elements instead
    var self = this,
        frag = document.createDocumentFragment(),
        grid = self.$el[0],
        items = [],
        $items,i,box;

    var get_url = "/ajax_front/more_new/"+next+"/"+c;
    
    $.getJSON(get_url, function(_data) {
        if (_data) {
//            console.log(_data);

            $("#page").val(next);
            var count = Object.keys(_data).length;

            for (i = 0; i < count; i++) {
                var temp = eval(_data[i]);
//                console.log(temp.data);
                box = document.createElement('div');
                box.className = temp.cl;
                box.setAttribute('data-grops', temp.data);
                box.innerHTML=temp.html;

                items.push( box );
                frag.appendChild( box );
          };
          
          grid.appendChild( frag );
          $items = $(items);
          self.shuffle.appended( $items );
        }
    });

  };

  return Manipulator;

}(jQuery));

$(document).ready(function() {
  new window.Manipulator( document.getElementById('grid') );
});
