
                            <div class="panel-heading">
                                <h3>타임라인</h3>
                            </div>
                            <!-- /panel-heading -->
                            
                            <div class="panel-body feed-list">

                                <input type="hidden" id="page" value="{page}" />         
                                <div class="media media-form rounded">
                                    <a href="{?s}/member/{s.ids}{:}#{/}" class="pull-left"> <img title="{s.name}" data-toggle="tooltip" class="media-object img-circle" src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}"> </a>

                                    <div class="media-body">
                                        <form name="tl_form" onsubmit="return false;">
                                            <input type="hidden" name="p_type" value="{type}" />
                                            <input type="hidden" name="p_id" value="{pid}" />
                                            <input type="hidden" name="user_id" value="{s.id}"/>  
                                            <input type="hidden" name="sub" value="" />
                                            <fieldset>
                                                <div class="form-group">
                                                    <textarea placeholder=""class="form-control" row="3" name="contents" id="tl_f"></textarea>
                                                    <div class="liveurl-loader" style='background: url("/img/common/url-loader.gif") repeat scroll 0 0 rgba(0, 0, 0, 0); display: none; height: 11px; margin: 10px 0; width: 16px;'></div>
                                                    <div id="sub">
                                                    <div class="liveurl" style="display: none;">
                                                        <div class="sub_close close" title="Entfernen"></div>
                                                        <div class="inner">
                                                            <div class="media-share rounded">
                                                                <div class="share-image pull-left image">
                                                                    <img alt="" src="http://i2.media.daumcdn.net/svc/image/U03/news/201311/29/essen/20131129091508674.jpg">
                                                                </div>
                                                                <div class="share-content details"> 
                                                                    <strong class="share-title"><a href="#"  class="title"> 바람 불어 외로운 날에는 짬뽕을 먹자 </a> </strong>
                                                                    <div class="share-subtitle url" >media.daum.net</div>
                                                                    <div class="share-summary"><a href="#" class="description"> 몹시 출출하여 무언가 뜨끈하고 얼큰한 것이 먹고 싶은 추운 가을 저녁, 옷깃을 여미고 중국집에 들어가 앉아 짬뽕을 주문한다. 코끝을 찌르는 익숙한 향, 길게 썬 해산물과 돼지고기 몇 점 올려 빨간 고추기름 묻은 면을 후루룩 들이켜다보면 뜨거운 것이 목구멍을 타고 배 속까지 내려간다. 배 속이 얼큰하게 꽉 들어찬 포만감,</a></div>
                                                                </div>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                </div>
                                                <!-- /form-group -->
                                                <div class="form-tool pull-left">
                                                    <label class="checkbox-inline">
                                                        <input type="checkbox" name="is_news" value="1">뉴스
                                                    </label>
                                                    <span class="break"></span>
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
                                                <div class="pull-right">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_comment(this); return false;">저장하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>

                                {? res}
                                <ul class="media-list">

                                    {@ res}
                                    <li class="media"> 
                                        <a class="pull-left" href="/member/{.ids}"> 
                                            <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.name}" style="width:40px;"> 
                                        </a>
                                        <div class="media-body" id="com_{.id}">
                                            <div class="media-heading">
                                                <h4><a href="/member/{.ids}">{.name}</a></h4>
                                                <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span>
                                                {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                            </div>
                                            <p>{.contents}{? .sub}{.sub}{/}</p>
                                            <div class="media-actions">
                                                <!--<button class="btn btn-default btn-xs"><span class="fontawesome icon-thumbs-up-alt"></span>&nbsp; 좋아요</button>-->
                                                {? s}<button class="btn btn-default btn-xs" onclick="open_com(this); return false;">댓글쓰기</button>{/}
                                            </div>

                                            <!-- sub media -->
                                            {@ .comm}
                                            <div class="media" id="com_{..id}"> 
                                                <a class="pull-left" href="/member/{..ids}"> <img src="{..picture}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}"  style="width:40px;"> </a>
                                                <div class="media-body">
                                                    <div class="media-heading">
                                                        <h4><a href="/member/{..ids}">{..name}</a></h4>
                                                        <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(..date_created)}</span>
                                                        {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                                    </div>
                                                    <p>{..contents}</p>
                                                </div>
                                            </div>
                                            {/}
                                            <!-- /sub media --> 

                                            <!-- sub media form -->
                                            <div class="media media-form rounded" style="display: none;"> 
                                                <a class="pull-left" href="/member/{s.ids}"> 
                                                    <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}" style="width:40px;"> 
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
                                                            <button class="btn btn-default btn-sm" onclick="submit_c_coment(this, '{.id}'); return false;">저장하기</button>
                                                        </fieldset>
                                                    </form>
                                                </div>
                                            </div>
                                            <!-- /sub media form --> <!-- sub media -->
                                            {@ .comm}
                                            <div class="media" id="com_{..id}"> 
                                                <a class="pull-left" href="#"> <img src="{..picture}" class="media-object img-circle" data-toggle="tooltip" title="{..name}"  style="width:40px;"> </a>
                                                <div class="media-body">
                                                    <div class="media-heading">
                                                        <h4><a href="/member/{..ids}">{..name}</a></h4>
                                                        <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(..date_created)}</span>
                                                        {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                                    </div>
                                                    <p>{..contents}</p>
                                                </div>
                                            </div>
                                            {/}
                                            <!-- /sub media --> 
                                        </div>
                                    </li>
                                    {/}
                                <!-- /media -->
                                </ul>
                                {/}
                                
                                {? sizeof(res) > 9}
                                <!-- /media-list -->
                                <div class="pager"> <a href="#" class="btn btn-default" onclick="more_tl(this); return false;"> &darr;  더보기</a> </div>
                                {/}
                            </div>
                            <!-- /panel-body -->


<script src="/js/jquery.liveurl.js"> </script>
<script> 

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
            var output = $('.liveurl');
            output.find('.title').text(data.title);
            output.find('.description').text(data.description);
            output.find('.url').text(data.url);
            output.find('.image').empty();

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
            var output  = $('.liveurl');
            var jqImage = $(image);
            jqImage.attr('alt', 'Preview');

            if ((image.width / image.height)  > 7 
            ||  (image.height / image.width)  > 4 ) {
                // we dont want extra large images...
                return false;
            } 

            curImages.push(jqImage.attr('src'));
            output.find('.image').append(jqImage);

            if (curImages.length === 1) {
                // first image...

                output.find('.thumbnail .current').text('1');
                output.find('.thumbnail').show();
                output.find('.image').show();
                jqImage.addClass('active');

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
</script>                   

<script type="text/javascript">
//<![CDAT

function open_com(_this) {
    $(_this).parent().parent().find('.timeLine-form').slideToggle();
    $(_this).parent().parent().find('.timeLine-form textarea').focus();
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
            $(_this).parent().parent().parent().parent().before(_data);
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
        $('#com_'+_id).parent().remove();
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
            $('.media-list').append(_data);
        } else {
            $(_this).parent().remove();
            alert("마지막 페이지입니다.");
        }
    });
}
//]]>
</script> 
