<script src="/js/jquery.dotdotdot.js"></script>
                                
                                {? type == 3}
                                <a class="btn btn-default btn-sm pull-right btn-gallery"  style="margin: 0 0 0 5px;" href="/lounge/event/{pid}"><i class="fa fa-users"></i> 이벤트 라운지 가기 <i class="fa fa-long-arrow-right"></i></a>
                                {/}

                                {? pic}
                                    <a title="" data-placement="top" class="btn btn-default btn-sm pull-right btn-gallery" href="{pic[0].image}" rel="prettyPhoto[galleryT]" ><span class="icon-picture"></span>&nbsp; 댓글사진 보기</a>
                                    {@ pic}{? .key_ != 0}<a href="{.image}" rel="prettyPhoto[galleryT]" style="display: none;"><span class="icon-picture"></span></a>{/}{/}
                                {/}
                                
                                <h3>
                                <span class="icon-edit"></span>&nbsp; 
                                {? type == 3}
                                {? datetimeDiff(ev.date_e, ev.end, date('y.m.d H:i'), '.') < 0}
                                행사 어떠셨나요? 만족도와 후기를 남겨주세요. 
                                {:}
                                행사에 대한 질문이나 의견을 남겨주세요. 
                                {/}
                                {/}
                                {? type > 3}
                                댓글
                                {/}
                                </h3>

                                <input type="hidden" id="page" value="{page}" />         
                                {? s}
                                <div class="media media-form rounded ">
                                    <a href="{?s}/member/{s.ids}{:}#{/}" class="pull-left media-object "> <img title="{s.name}" data-toggle="tooltip" class="img-circle" src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}"> </a>

                                    <div class="media-body">
                                        <form name="tl_form" onsubmit="return false;">
                                            <input type="hidden" name="p_type" value="{type}" />
                                            <input type="hidden" name="p_id" value="{pid}" />
                                            <input type="hidden" name="user_id" value="{s.id}"/>  
                                            <input type="hidden" name="sub" value="" />
                                            <input type="hidden" name="image" value="" />
                                            <fieldset>

                                                <!-- 이벤트 게시판 제외 -->
                                                <div class="row">
                                                    {? type > 2}
                                                    <div class="col-xs-12 col-sm-2 col-md-2 right form-group">
                                                        <label data-toggle="tooltip" title="이미지 업로드" for="inputPic">
                                                            <img class="img-thumbnail img-responsive" src="/img/default-img-pic.png">
                                                            <input type="file" style="display: none;" id="inputPic" onchange="img_up(this); return false;">
                                                        </label>
                                                    </div> 
                                                    {/}
                                                    <div class="col-xs-12 {? type > 2}col-sm-10 col-md-10{:}col-sm-12 col-md-12{/} left form-group">
                                                        <textarea placeholder=""class="form-control" row="3" name="contents" id="tl_f"></textarea>
                                                        <div class="liveurl-loader" style='background: url("/img/common/url-loader.gif") repeat scroll 0 0 rgba(0, 0, 0, 0); display: none; height: 11px; margin: 10px 0; width: 16px;'></div>
                                                        <div id="sub">
                                                            <div class="liveurl" style="display: none;">
                                                                <div class="sub_close close" title="Entfernen"></div>
                                                                <div class="inner">
                                                                    <div class="media-share rounded">
                                                                        <div class="share-image pull-left image" style="display: none;">
                                                                            <img alt="" src="http://i2.media.daumcdn.net/svc/image/U03/news/201311/29/essen/20131129091508674.jpg">
                                                                        </div>
                                                                        <div class="share-content details"> 
                                                                            <strong class="share-title"><a href="#" target="_blank" class="title"> </a> </strong>
                                                                            <div class="share-subtitle url" >media.daum.net</div>
                                                                            <div class="share-summary"><a href="#" target="_blank" class="description"></a></div>
                                                                        </div>
                                                                        <div class="clearfix"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- /form-group -->
                                                {? type == 1}
                                                <div class="form-tool pull-right">
                                                    {? s.id == pid}
                                                    <label class="checkbox-inline">
                                                        <input type="checkbox" name="is_news" value="1">뉴스
                                                    </label>
                                                    <span class="break"></span>
                                                    {? (s.per & settings->permission1) == settings->permission1}
                                                    <label class="checkbox-inline">
                                                        <input type="checkbox" name="is_press" value="1">보도자료
                                                    </label>
                                                    <span class="break"></span>
                                                    {/}
                                                    {/}
                                                    <label class="checkbox-inline">
                                                        <input type="checkbox" name="is_hidden" value="1">비밀글
                                                    </label>
                                                    <span class="break"></span>
                                                    <label title="" data-toggle="tooltip" class="checkbox-inline" data-original-title="페이스북에 공유하기">
                                                        <input type="checkbox" name="fb" value="1" {? !s.fb}disabled="disabled"{/}><span style="color:#357EBD" class="icon-fixed-width icon-facebook"></span>
                                                    </label>
                                                    <label title="" data-toggle="tooltip" class="checkbox-inline" data-original-title="트위터에 공유하기">
                                                        <input type="checkbox" name="tw" value="1" {? !s.tw}disabled="disabled"{/}><span style="color:#357EBD" class="icon-fixed-width icon-twitter"></span>
                                                    </label>
                                                </div>
                                                {/} 
                                                <button class="btn btn-primary btn-sm" onclick="submit_comment(this); return false;">저장하기</button>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                                {:}
                                <div class="well  text-center">
                                     <p>로그인을 하면 댓글을 남길 수 있습니다.</p>
                                     <a href="/login" class="btn btn-default btn-sm">로그인하기</a> 
                                </div>
                                {/}
                                
                                {? type == 3 && datetimeDiff(ev.date_e, ev.end, date('y.m.d H:i'), '.') < 0}
                                <div class="media-point">
                                    <div class="pull-right point-star">
                                        <dl class="dl-horizontal">
                                            <dt>행사별점</dt>
                                            <dd>
                                                <div class="rating">
                                                    <span {? star.star > 0}class="selected"{/}><i class="fa fa-star"></i></span>
                                                    <span {? star.star > 1}class="selected"{/}><i class="fa fa-star"></i></span>
                                                    <span {? star.star > 2}class="selected"{/}><i class="fa fa-star"></i></span>
                                                    <span {? star.star > 3}class="selected"{/}><i class="fa fa-star"></i></span>
                                                    <span {? star.star > 4}class="selected"{/}><i class="fa fa-star"></i></span>
                                                </div>
                                                <span class="sr-only">평점 : {star.star}</span>
                                                <small>({star.cnt}명 참여)</small>
                                                {? check}
                                                <button class="btn btn-default btn-sm rateToggle" disabled="disabled">참여했어요</button>
                                                {:}
                                                <button class="btn btn-default btn-sm rateToggle">별점주기</button>
                                                {/}
                                            </dd>
                                        </dl>
                                        <script type="text/javascript">
                                            $(document).ready(function(){  
                                                $('.rateToggle').click(function(){  
                                                    var state = $('.ratinglayer').css('display');  
                                                    if(state == 'none'){  
                                                        $('.ratinglayer').show();  
                                                    }else{  
                                                        $('.ratinglayer').hide();       
                                                    }
                                                });

                                                $('.close').click(function(){    
                                                    $('.ratinglayer').hide();   
                                                });
                                            });
                                        </script> 
                                        <div class="ratinglayer" style="display:none;">
                                            <form role="form">
                                                <fieldset>
                                                    <button type="button" class="close">
                                                        <span aria-hidden="true">&times;</span>
                                                        <span class="sr-only">Close</span>
                                                    </button>

                                                    <h4>행사 별점주기 </h4>                                            
                                                    <script src="/js/jquery.barrating.js"></script>
                                                    <script type="text/javascript">
                                                        $(function () {
                                                            $('#star-rating').barrating({ showSelectedRating:false });
                                                            $('.rating-enable').trigger('click');
                                                        });
                                                    </script>  
                                                    <div class="input select rating-f">
                                                        <select id="star-rating" name="rating">
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                        </select>
                                                    </div>
                                                    <button class="btn btn-default" onclick="add_star('{ev.id}'); return false;">확인</button>                                            
                                                </fieldset>
                                            </form> 
                                        </div>
                                    </div>
                                </div>
                                {/}

                                {? res}
                                <ul class="media-list feed-list">

                                    {@ res}{? !.is_hidden || .is_hidden && res.user_id == s.id || .is_hidden && pid == s.id}                                    
                                    <li class="media"> 
                                        {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                        <a class="pull-left media-object " href="/member/{.ids}"> 
                                            <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.name}"> 
                                        </a>
                                        <div class="media-body" id="com_{.id}">
                                            <h4 class="media-heading">
                                                <a href="/member/{.ids}">{.name}</a>
                                                <small><a href="/timeline/{.id}">&nbsp; {=trans_date_ago(.date_created)}</a></small>
                                            </h4>                                             
                                            <div class="media-content">
                                                {? .image}<div class="pull-right">
                                                    <a rel="prettyPhoto" style="background:url({.image}) center center no-repeat #000; background-size: 180px auto;" class="img-thumbnail" href="{.image}"><img src="/img/trans.png"></a>
                                                </div>{/}
                                                <div class="ellipsis" >{=add_brs(.contents)}
                                                <a class="readmore" style="display: inline;" >더보기 »</a></div>
                                                {? .sub}{.sub}{/}
                                            </div>
                                            <div class="media-meta">
                                                <div class="meta-actions" style="text-align: right;">
                                                    <div class="btn-group btn-like ">
                                                        <button type="button" class="btn btn-default btn-sm" onclick="comment_like(this, '{.id}', '{.is_like}'); return false;">
                                                            <span class="glyphicon glyphicon-heart"></span> 
                                                            <span class="sr-only">좋아요 </span>{? .like}<span id="li_cnt{.id}">{.like}</span> {/}
                                                        </button>
                                                        <button aria-controls="like-media" aria-expanded="true" data-target="#like-media{.id}" data-toggle="collapse" class="btn btn-default btn-sm" type="button" {? ! .like}style="display: none;"{/} onclick="get_like('{.id}'); return false;">
                                                            <span class="caret"></span>
                                                        </button>
                                                    </div>
                                                    <button aria-controls="re-media" aria-expanded="true" data-target="#re-media{.id}" data-toggle="collapse" class="btn btn-default btn-sm" type="button" onclick="open_com(this); return false;">
                                                        <span class="glyphicon glyphicon-comment"></span> <span class="sr-only">댓글 </span>  <span id="re_cnt{.id}">{=sizeof(.comm)}</span>
                                                    </button> 
                                                </div>
                                            </div>
                                            <div id="like-media{.id}" class="collapse"></div>
                                            
                                            <!-- sub media -->
                                            <ul class="media-list" style="display: none;">
                                                {@ .comm}
                                                <li class="media" id="com_{..id}"> 
                                                    {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                                    <a class="pull-left media-object " href="#"> <img src="{..picture}" class="img-circle" data-toggle="tooltip" title="{..name}" > </a>
                                                    <div class="media-body"> 
                                                        <h4 class="media-heading">
                                                            <a href="/member/{..ids}">{..name}</a>
                                                            <small>{=trans_date_ago(..date_created)}</small>
                                                        </h4> 
                                                        <div class="media-content">{..contents}</div>
                                                    </div>
                                                </li>
                                                {/}
                                            </ul>
                                            <!-- /sub media --> 
                                            
                                            {? s.id}
                                            <!-- sub media form -->
                                            <div class="media media-form rounded" style="display: none;"> 
                                                <a class="pull-left media-object " href="/member/{s.ids}"> 
                                                    <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{s.name}"> 
                                                </a>
                                                <div class="media-body">
                                                    <form name="tl_c_form_{.id}">
                                                        <input type="hidden" name="p_type" value="{type}" />
                                                        <input type="hidden" name="depth" value="1" />
                                                        <input type="hidden" name="parent" value="{.id}" />
                                                        <input type="hidden" name="p_id" value="{pid}" />
                                                        <input type="hidden" name="user_id" value="{s.id}" />
                                                        <fieldset>
                                                            <div class="form-group">
                                                                <label class="sr-only" for="inputTimeline">타임라인에 글쓰기</label>
                                                                <textarea row="3" class="form-control" id="inputTimeline" name="contents"></textarea>
                                                            </div>
                                                            <!-- /form-group -->
                                                            <button class="btn btn-primary btn-sm" onclick="submit_c_coment(this, '{.id}'); return false;">저장하기</button>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                            <!-- /sub media form --> 
                                            {/}
                                        </div>
                                    </li>
                                    {/}{/}
                                <!-- /media -->
                                </ul>
                                {/}
                                
                                {? sizeof(res) > 9}
                                <!-- /media-list -->
                                <div class="pager"> 
                                    <a href="#" class="btn btn-default" onclick="more_tl(this); return false;"> &darr;  더보기</a> 
                                </div>
                                {/}
                             

{? type == 1}
<script src="/js/jquery.liveurl.js"> </script>
<script type="text/javascript"> 
//<![CDAT

var curImages = new Array();

$('#tl_f').liveUrl({
    loadStart : function(){
        $('.liveurl-loader').show();
    },
    loadEnd : function(){
        $('.liveurl-loader').hide();
    },
    success : function(data) 
    {                     
        //console.log(data);
        var output = $('.form-group .liveurl');
        output.find('.title').text(data.title);
        output.find('.description').text(data.description);
        output.find('.url').text(data.url);
        output.find('.title').attr('href', data.url);
        output.find('.description').attr('href', data.url);
        output.find('.image').empty();

        if (data.title === '') {
            var _url = '/ajax_front/fetch_og';
            var _data ={
                "url" 		: data.url,
            };
            $.ajax({
                type : 'POST',
                url : _url,
                data : _data,
                dataType : 'json',
                success : function(_og) {
                    output.find('.title').text(_og.title);
                    if (_og.description)
                        output.find('.description').text(_og.description);
                    if (_og.image) {
                        output.find('.image').html('<img src="'+_og.image+'" />');
                        output.find('.image').show(); 
                    }
                }
            });
        }
        
        output.find('.close').one('click', function() 
        {
            var liveUrl     = $(this).parent();
            liveUrl.hide('fast');
            liveUrl.find('.video').html('').hide();
            liveUrl.find('.image').html('');
            liveUrl.find('.controls .prev').addClass('inactive');
            liveUrl.find('.controls .next').addClass('inactive');
            liveUrl.find('.thumbnail').hide();
            liveUrl.find('.image').hide();

            $('textarea').trigger('clear'); 
            curImages = new Array();
        });
        
        

        output.show('fast');

        if (data.video !== null) {                       
            var ratioW        = data.video.width  /350;
            data.video.width  = 350;
            data.video.height = data.video.height / ratioW;

            var video = 
            '<object width="' + data.video.width  + '" height="' + data.video.height  + '">' +
                '<param name="movie"' +
                      'value="' + data.video.file  + '"></param>' +
                '<param name="allowScriptAccess" value="always"></param>' +
                '<embed src="' + data.video.file  + '"' +
                      'type="application/x-shockwave-flash"' +
                      'allowscriptaccess="always"' +
                      'width="' + data.video.width  + '" height="' + data.video.height  + '"></embed>' +
            '</object>';
            output.find('.video').html(video).show();

        }
    },
    addImage : function(image)
    {   
        var output  = $('.form-group .liveurl');
        var jqImage = $(image);
        jqImage.attr('alt', 'Preview');

        if ((image.width / image.height)  > 7 
        ||  (image.height / image.width)  > 4 ) {
            // we dont want extra large images...
            return false;
        } 

        curImages.push(jqImage.attr('src'));
        //output.find('.image').append(jqImage);
        output.find('.image').css({'background-image': "url("+jqImage.attr('src')+")", 'background-repeat': 'no-repeat', 'background-position': 'center'});

        if (curImages.length === 1) {
            // first image...
            output.find('.thumbnail .current').text('1');
            output.find('.thumbnail').show();
            output.find('.image').show();
            jqImage.addClass('active');

        }
         
        if (!curImages) {
            console.log('000000');
            output.find('.image').remove();
        }

        if (curImages.length === 2) {
            output.find('.controls .next').removeClass('inactive');
        }

        output.find('.thumbnail .max').text(curImages.length);
    }
});


$('.liveurl ').on('click', '.controls .button', function() 
{
    var self        = $(this);
    var liveUrl     = $(this).parents('.liveurl');
    var content     = liveUrl.find('.image');
    var images      = $('img', content);
    var activeImage = $('img.active', content);

    if (self.hasClass('next')) 
         var elem = activeImage.next("img");
    else var elem = activeImage.prev("img");

    if (elem.length > 0) {
        activeImage.removeClass('active');
        elem.addClass('active');  
        liveUrl.find('.thumbnail .current').text(elem.index() +1);

        if (elem.index() +1 === images.length || elem.index()+1 === 1) {
            self.addClass('inactive');
        }
    }

    if (self.hasClass('next')) 
         var other = elem.prev("img");
    else var other = elem.next("img");

    if (other.length > 0) {
        if (self.hasClass('next')) 
               self.prev().removeClass('inactive');
        else   self.next().removeClass('inactive');
   } else {
        if (self.hasClass('next')) 
               self.prev().addClass('inactive');
        else   self.next().addClass('inactive');
   }
});
//]]>
</script>                   
{/}
<link rel="stylesheet" href="/css/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />
<script src="/js/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
//<![CDAT
$(document).ready(function() {
    $(".ellipsis").dotdotdot({
        after: "a.readmore",
        tolerance            : 1,
        height           : 70,
        callback: hideLinkIfNoTruncation
    }).find('a.readmore').click(clicked)
});

function clicked() {
    var div=$(this).closest('.ellipsis')
    div.height('auto').trigger('destroy').find('.readmore').remove()
    return false
}

function hideLinkIfNoTruncation(isTruncated, origContent) {
    if (!isTruncated) {
        $('.readmore',this).remove()
    } 
}

$(document).ready(function(){
    $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
});

function open_com(_this) {
    $(_this).parent().parent().next().next().slideToggle();
    $(_this).parent().parent().next().next().next().slideToggle();
    $(_this).parent().parent().next().find('textarea').focus();
} 

function submit_comment(_this){
    var frm = $('form[name=tl_form]');
    if ($(_this).parent().parent().find('textarea[name=contents]').val().length < 1) {
        alert('내용을 입력해주세요.');
        return false;
    }
    $(_this).hide();
    
    if ($('.liveurl').css('display') === 'block') {
        var _sub = $('#sub').html();
        $('input[name=sub]').val(_sub);
    }

    var get_url = '/ajax_front/add_timeline';
    var set_data = frm.serialize();

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            get_timeline('{type}', '{pid}', 1);
        }
    });
}

function submit_c_coment(_this, _id){
    var frm = $('form[name=tl_c_form_'+_id+']');
    if ($(_this).parent().parent().find('textarea[name=contents]').val().length < 1) {
        alert('내용을 입력해주세요.');
        return false;
    }
    $(_this).hide();
    var get_url = '/ajax_front/add_timeline_comm';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            $(_this).parent().find('textarea').val("");
            $(_this).parent().parent().parent().parent().prev().append(_data);
            $(_this).show();
        }
    });
}

function close_form(_this) {
    $(_this).parent().parent().parent().parent().slideToggle();
}

function del_comm(_id, _is_com)
{
    del_confirm('del_comm2('+_id+', '+_is_com+')');
}

function del_comm2( _id, _is_com)
{

    var get_url = '/ajax_front/del_com/'+_id+'/'+_is_com;
    $.get(get_url, function() {
        if (_is_com) {
            $('#com_'+_id).parent().remove();
        } else {
            $('#com_'+_id).remove();
        }
        $('#md-warning').modal('hide');
    });

}

function more_tl(_this) {
    var p = $('#page').val();
    var next = parseInt(p) + 1;
    var get_url = "/ajax_front/more_timeline/{type}/{pid}/"+next;

    $.post(get_url, function(_data) {
        if (_data !== '') {
            $('#page').val(next);
            $(_this).parent().prev().append(_data);

            $(".ellipsis").dotdotdot({
                after: "a.readmore",
                tolerance            : 1,
                height           : 70,
                callback: hideLinkIfNoTruncation
            }).find('a.readmore').click(clicked)
        } else {
            $(_this).parent().remove();
            alert("마지막 페이지입니다.");
        }
    });
}

function img_up(_this) {
    var fd = new FormData();    
    fd.append( 'file', $('#inputPic')[0].files[0] );
    $.ajax({
          url: '/ajax_front/img_temp_upload',
          data: fd,
          processData: false,
          contentType: false,
          type: 'POST',
          dataType : 'json',
          success: function(data){
            if (data.error_str) {
                alert(data.error_str);
            }
            else {
                $(_this).prev().attr("src", data.img);
                $('input[name=image]').val(data.img);
            }
          }
    });
}

function comment_like(_this, _id, _type) 
{
    $(_this).attr('disabled', 'disabled');
    $.ajax({
        type : 'POST',
        url : '/ajax_front/add_timeline_like/' + _id + "/" + _type,
        dataType : 'json',
        success : function(_data) {
            if (_data.error) {
                alert('이미 좋아요 했습니다.');
                $(_this).removeAttr('disabled');
                return false;
            }
            else if (_data.login) {
                alert('로그인 해주세요.');
                $(_this).removeAttr('disabled');
                return false;
            }
            if (_data.cnt == 0) {
                $(_this).parent().removeClass('active');
                html_ = '<button onclick="comment_like(this, '+_id+', 0); return false;" '
                    +'class="btn btn-default btn-sm" type="button"><span class="glyphicon glyphicon-heart"></span>'
                    +'<span class="sr-only">좋아요</span></button>';
                $(_this).parent().html(html_);
            }
            else {
                if (_type == 1) type_ = 0
                else type_ = 1 
                $(_this).parent().addClass('active');
                html_ = '<button onclick="comment_like(this,  '+_id+', '+type_+'); return false;" class="btn btn-default btn-sm" type="button">'
                    +'<span class="glyphicon glyphicon-heart"></span></span><span class="sr-only">좋아요 </span><span id="li_cnt'+_id+'">'+_data.cnt+'</span></button>'
                    +'<button onclick="get_like('+_id+'); return false;" type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target="#like-media'+_id+'" aria-expanded="false" aria-controls="like-media"><span class="caret"></span></button>';
                $(_this).parent().html(html_);
            }
            $(_this).removeAttr('disabled');
        }
    });
}

function get_like(_id) 
{
    if ( $("#like-media"+_id).hasClass('in') == false ) {
        $.ajax({
            type : 'POST',
            url : '/ajax_front/get_timeline_like/' + _id,
            dataType : 'html',
            success : function(_data) {
                $("#like-media"+_id).html(_data);
            }
        });
    } 
        
}

function add_star(_id)
{
    var sel_star = $("#star-rating option:selected").val();
    $.ajax({
        type : 'POST',
        url : '/ajax_front/add_star_event/' + _id + '/' + sel_star,
        dataType : 'json',
        success : function(_data) {

            if (_data.error == "login") {
                alert('로그인 해주세요.');
            }
            else if (_data.error == "aleady") {
                alert('이미 참여했어요.');
            }
            else {
                alert('별점이 저장되었었어요.');
                $('.point-star').find('small').html('('+_data.data.cnt+'명 참여)');
                $('.rating > span').removeClass('selected');
                $('.rateToggle').attr('disabled', 'disabled');
                $('.rateToggle').html('참여했어요');
                if (_data.data.star > 0) $('.rating > span').eq(0).addClass('selected');
                if (_data.data.star > 1) $('.rating > span').eq(1).addClass('selected');
                if (_data.data.star > 2) $('.rating > span').eq(2).addClass('selected');
                if (_data.data.star > 3) $('.rating > span').eq(3).addClass('selected');
                if (_data.data.star > 4) $('.rating > span').eq(4).addClass('selected');

            }

            $('.ratinglayer').hide();
            $('.br-widget > a').removeClass('br-selected');
            $('.br-widget > a').eq(0).addClass('br-selected');

                
        }
    });
}

//]]>
</script> 
