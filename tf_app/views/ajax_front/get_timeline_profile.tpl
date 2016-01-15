
                                    {? opt == 1}
                                    <div class="panel-heading">
                                        <strong>업데이트</strong>
                                    </div>
                                    {/}
                                    {? opt == 2}
                                    <div class="panel-heading">
                                        <strong>방명록</strong>
                                    </div>
                                    {/}
                                    <div class="panel-body">
                                        <input type="hidden" id="page" value="{page}" />

                                        {? (type == 1 && opt == 1 && pid == s.id) || (type == 1 && opt == 2 && pid != s.id) || (opt == 1 && type == 2 && edi) || (opt == 2 && type == 2 && !edi)}
                                        <div class="media form-edit-set">
                                            <form role="form" name="tl_form" onsubmit="return false;">
                                                <fieldset>
                                                    {? type == 2 && opt == 1}
                                                    <a class="media-left" href="{?s}/startup/{st.id}{:}#{/}">
                                                        <img src="{?st.logo}{st.logo}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{st.name}">
                                                    </a>
                                                    {:}
                                                    <a class="media-left" href="{?s}/member/{s.ids}{:}#{/}">
                                                        <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}">
                                                    </a>
                                                    {/}
                                                    <div class="media-body">
                                                        <div class="form-group">
                                                            <label class="sr-only">내용</label>
                                                            <textarea row="3" class="form-control" placeholder="" name="contents" id="tl_f"></textarea>
                                                            <div class="liveurl-loader" style='background: url("/img/common/url-loader.gif") repeat scroll 0 0 rgba(0, 0, 0, 0); display: none; height: 11px; margin: 10px 0; width: 16px;'></div>
                                                            <div id="sub">
                                                                <div class="liveurl" style="display: none;">
                                                                    <div class="inner">
                                                                        <div class="media-share rounded">
                                                                            <button onclick="close_sub(this); return false;" title="삭제" data-toggle="tooltip" class="close delete" type="button">×</button>
                                                                            <img alt="" class="in_image image share-image pull-left" src="" style="display: none;">
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
                                                        <!-- /form-group -->

                                                        <div class="form-group">
                                                            {? type == 2 && opt == 1}
                                                            <label class="checkbox-inline">
                                                                <input type="checkbox" name="is_news" value="1">뉴스
                                                            </label>
                                                            {:}

                                                            {? s.id == pid}
                                                            <label class="checkbox-inline">
                                                                <input type="checkbox" name="is_news" value="1">뉴스
                                                            </label>
                                                            {? (s.per & settings->permission1) == settings->permission1}
                                                            <label class="checkbox-inline">
                                                                <input type="checkbox" name="is_press" value="1">보도자료
                                                            </label>
                                                            {/}
                                                            {/}
                                                            <label class="checkbox-inline">
                                                                <input type="checkbox" name="is_hidden" value="1">비밀글
                                                            </label>
                                                            {? opt == 1}
                                                            <label class="checkbox-inline" data-toggle="tooltip" title="페이스북에 공유하기">
                                                                <input type="checkbox" name="fb" value="1" {? !s.fb}disabled="disabled"{/}><i class="fa fa-facebook"></i><span class="sr-only">페이스북에 공유하기</span>
                                                            </label>
                                                            <label class="checkbox-inline" data-toggle="tooltip" title="트위터에 공유하기">
                                                                <input type="checkbox" name="tw" value="1" {? !s.tw}disabled="disabled"{/}><i class="fa fa-twitter"></i><span class="sr-only">트위터에 공유하기</span>
                                                            </label>
                                                            {/}
                                                            {/}
                                                        </div>

                                                        <!-- /form-group -->
                                                        <div class="form-group form-submit">
                                                            {? s.id}
                                                                {? opt == 1 && s.fb.public}
                                                                <button class="btn btn-primary btn-sm" onclick="submit_comment_up(this, {opt}, {s.fb.public}); return false;">저장하기</button>
                                                                {: opt == 1 }
                                                                <button class="btn btn-primary btn-sm" onclick="submit_comment_up(this, {opt}); return false;">저장하기</button>
                                                                {:}
                                                                <button class="btn btn-primary btn-sm" onclick="submit_comment(this, {opt}); return false;">저장하기</button>
                                                                {/}
                                                            {:}
                                                            <div class="btn btn-primary btn-sm" onclick="javascript:location.href='/login'">로그인 해주세요</div>
                                                            {/}
                                                        </div>
                                                        <!-- /form-group -->
                                                    </div>
                                                    <input type="hidden" name="p_type" value="{type}" />
                                                    <input type="hidden" name="p_id" value="{pid}" />
                                                    <input type="hidden" name="user_id" value="{s.id}"/>  
                                                    <input type="hidden" name="sub" value="" />
                                                    <input type="hidden" name="image" value="" />
                                                </fieldset>
                                            </form>
                                        </div> 
                                        {/}

                                        <!-- media-list -->
                                        <ul class="media-list">
                                            {? res}
                                            {@ res}
                                            {? !.is_hidden || .is_hidden && res.user_id == s.id || .is_hidden && pid == s.id}
                                            <li class="media">
                                                {? type == 2 && opt == 1}
                                                <a class="media-left" href="/startup/{st.id}"> 
                                                    <img src="{? st.logo}{st.logo}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{st.name}">
                                                </a>
                                                {:}
                                                <a class="media-left" href="/member/{.ids}"> 
                                                    <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.name}">
                                                </a>
                                                {/}
                                                <div class="media-body" id="com_{.id}">
                                                    <div class="media-heading">
                                                        {? s.id == .user_id}
                                                        <button type="button" class="close delete" data-toggle="tooltip" title="삭제" onclick="del_comm('{.id}', 1); return false;">&times;</button>
                                                        {/}
                                                        <strong><a href="/member/{.ids}">{.name}</a></strong>
                                                        <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.date_created)}</span> 
                                                        {? s}
                                                        <button class="btn btn-default btn-xs" onclick="open_com(this); return false;">댓글쓰기</button>    
                                                        {/}                                                   
                                                    </div>
                                                    <div class="media-content">
                                                        <div class="ellipsis" >{=trans_url(add_brs(.contents))}</div>
                                                        {? .sub}
                                                        <div class="media-share">
                                                            {.sub}
                                                        </div>
                                                        {/}
                                                    </div>
                                                    <!-- /media-share --> 
                                                     
                                                    <ul class="media-list">
                                                        {@ .comm}
                                                        <li class="media" id="com_{..id}"> 
                                                            {? ..s_id}
                                                            <a class="media-left" href="/startup/{..s_id}"> 
                                                                <img src="{..s_logo}" class="media-object img-circle" data-toggle="tooltip" title="{..s_name}">
                                                            </a>
                                                            {:}
                                                            <a class="media-left" href="/member/{..ids}"> 
                                                                <img src="{..picture}" class="media-object img-circle" data-toggle="tooltip" title="{..name}">
                                                            </a>
                                                            {/}
                                                            <div class="media-body">
                                                                <div class="media-heading">
                                                                    {? s.id == ..user_id}
                                                                    <button type="button" class="close delete" data-toggle="tooltip" title="삭제" onclick="del_comm('{..id}', 0); return false;">&times;</button>
                                                                    {/}
                                                                    <strong><a href="/member/{..ids}">{..name}</a></strong>
                                                                    <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(..date_created)}</span> 
                                                                </div>
                                                                <p>{=trans_url(add_brs(..contents))}</p>
                                                            </div>
                                                        </li> 
                                                        {/}
                                                        <!-- /media -->
                                                        <li class="media form-edit-set" style="display: none;">
                                                            <form role="form" name="tl_c_form_{.id}">
                                                                <fieldset>
                                                                    {? type == 2 && opt == 1 && edi}
                                                                    <a class="media-left" href="/startup/{st.id}"> 
                                                                        <img src="{?st.logo}{st.logo}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{st.name}">
                                                                    </a>
                                                                    {:}
                                                                    <a class="media-left" href="/member/{s.ids}"> 
                                                                        <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{s.name}">
                                                                    </a>
                                                                    {/}
                                                                    <div class="media-body">
                                                                        <div class="form-group">
                                                                            <label class="sr-only">댓글내용</label>
                                                                            <textarea row="3" class="form-control" placeholder="댓글을 입력하세요" id="inputTimeline" name="contents"></textarea>
                                                                        </div>
                                                                        {? s.id}
                                                                        <div class="form-group form-submit">
                                                                            <button class="btn btn-default btn-sm" onclick="submit_c_coment(this, '{.id}'); return false;">저장하기</button>
                                                                        </div>
                                                                        {:}
                                                                        <div class="btn btn-primary btn-sm" onclick="javascript:location.href='/login'">로그인 해주세요</div>
                                                                        {/}
                                                                    </div>
                                                                    <input type="hidden" name="p_type" value="{type}" />
                                                                    <input type="hidden" name="depth" value="1" />
                                                                    <input type="hidden" name="parent" value="{.id}" />
                                                                    <input type="hidden" name="p_id" value="{pid}" />
                                                                    <input type="hidden" name="opt" value="{opt}" />
                                                                </fieldset>
                                                            </form>
                                                        </li> 
                                                        <!-- /media -->
                                                    </ul>
                                                    <!-- /media-list --> 
                                                </div>
                                            </li>
                                            <!-- /media --> 
                                            {/}
                                            {/}
                                            {:}
                                            <li class="alert alert-info">
                                                <p class="text-info"><strong>Oops!</strong> 
                                                    {? opt == 1}작성된 글이 없습니다.
                                                    {:}작성된 방명록이 없습니다. 
                                                    {/} 
                                                </p>
                                            </li>
                                            {/}
                                        </ul>
                                        <!-- /media-list -->

                                        {? sizeof(res) > 9}
                                        <div class="pager"> <a href="#" class="btn btn-default btn-sm" onclick="more_tl(this, {type}, {pid}, {opt}); return false;"> &darr;  더보기</a> </div>
                                        {/}
                                    </div>
                                    <!-- /panel-body --> 

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
                "url"       : data.url,
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
                        output.find('.in_image').attr('src', _og.image);
                        output.find('.in_image').show(); 
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

        console.log(jqImage.attr('src'));
        output.find('.in_image').attr('src', jqImage.attr('src'));
        if (jqImage.attr('src')) {
            console.log(11)
            $('.in_image').show();
        }

    }
});

//]]>
</script> 