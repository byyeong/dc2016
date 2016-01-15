$(window).ready(function(e){

	for(var i=0; i<turn_point.length; i++){
		var turn = turn_point[i];
		turn.target = $(turn.target);
	}

	scrollAction();
	resizeAction();
	$(document).on("scroll", scrollAction);
	$(window).on("resize", resizeAction);
});

var background_src;

var turn_point = [
	{
		start : 0,
		end : 1079,
		target : ".fixer1",
		zIndex : -1
	},
	{
		start : 1080,
		end : 999999,
		target : ".fixer2",
		zIndex : -1
	}
];

function scrollAction(e){
	var scrollTop = $(document).scrollTop();

	for(var i=0; i<turn_point.length; i++){
		var turn = turn_point[i];
		if(turn.start <= scrollTop && scrollTop <= turn.end){
			
			if(turn.zIndex !== 0){
				for( j=0; j<turn_point.length; j++){
					var _turn = turn_point[j];
					
					//-- 선택된 턴일경우
					if(i === j){
						_turn.target.css("z-index", _turn.zIndex = 0);
					}
					//-- 그외의 경우
					else{
						_turn.target.css("z-index", _turn.zIndex = -1);
					}
				}
			}

			break;
		}
	}
}

function resizeAction(e){
	var width = $(document).width();
	console.log(width);
	if(width >= 1920){
		$(".background-fixer").css({
				width:"100%",
				height:"initial"
		});
	}else{
		$(".background-fixer").css({
				width:"initial",
				height:"initial"
		});
	}
}