<!-- rowContent -->
    <div class="rowContent"  id="news"> 
        
        <div class="page-header">
            <div class="container">
                <h2><a href="/news">News</a></h2>
            </div>
        </div>
        <!-- /page-header -->
        
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div class="row"> 
                    
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content"> 
                    
                        <!-- media-list -->                         
                        <input type="hidden" id="page" value="{page}" /> 
                        <ul class="media-list feed-list">
                            {@ res}
                            <li class="media"> 
                                <a class="pull-left media-object" href="{? .p_type == 2}/startup/{.p_id}{:}/member/{.ids}{/}"> 
                                    <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.name}" > 
                                </a>
                                <div class="media-body" id="com_{.id}"> 
                                    {? (s.per & settings->permission1) == settings->permission1}
                                    <button title="숨기기" data-toggle="tooltip" aria-hidden="true" class="close btn-hidden" type="button" onclick="hide_news('{.id}'); return false;"><span class="icon-check-minus"></span></button>
                                    {/}
                                    {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                    <h4 class="media-heading"><a href="{? .p_type == 2}/startup/{.p_id}{:}/member/{.ids}{/}">{.name}</a></h4> 
                                    
                                    <div class="media-content">
                                        <div class="ellipsis_n" >{=add_brs(.contents)}
                                            <a class="readmore" style="display: inline;" >더보기 »</a>
                                        </div>
                                        {? .sub}{.sub}{/}
                                    </div>
                                    
                                    <div class="media-meta">
                                        <span class="time"><span class="fontawesome icon-time"></span><a href="/timeline/{.id}">&nbsp; {=trans_date_ago(.date_created)}</a></span>
                                        {? s}<button class="btn btn-link btn-xs" onclick="open_com(this); return false;">댓글쓰기</button>{/}
                                    </div>

                                    <!-- sub media -->
                                    <ul class="media-list">
                                        {@ .comm}
                                        <li class="media" id="com_{..id}"> 
                                             {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                            <a class="pull-left media-object" href="#"> <img src="{..picture}" class="img-circle" data-toggle="tooltip" title="{..name}" > </a>
                                            <div class="media-body"> 
                                                <h4 class="media-heading"><a href="/member/{..ids}">{..name}</a></h4> 
                                                <div class="media-content">{..contents}</div>
                                                <div class="media-meta">
                                                    <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(..date_created)}</span>
                                                </div>
                                            </div>
                                        </li>
                                        {/}
                                    </ul>
                                    <!-- /sub media --> 
                                    
                                    <!-- sub media form -->
                                    <div class="media-form rounded" style="display: none;"> 
                                        <a class="pull-left media-object" href="/member/{s.ids}"> 
                                            <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class=" img-circle" data-toggle="tooltip" title="{s.name}" style="width:40px;"> 
                                        </a>
                                        <div class="media-body">
                                            <form name="tl_c_form_{.id}">
                                                <input type="hidden" name="p_type" value="{.p_type}" />
                                                <input type="hidden" name="depth" value="1" />
                                                <input type="hidden" name="parent" value="{.id}" />
                                                <input type="hidden" name="p_id" value="{.p_id}" />
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
                                </div>
                            </li>
                            {/}
                            <!-- /media -->
                        </ul>                     
                        {? sizeof(res) > 9}<div class="pager"> <a href="#" class="btn btn-default" onclick="more_news(this, '2'); return false;"> &darr;  더보기</a> </div>{/}
                        <!--  /media-list --> 
                    </div>
                    <!-- /content --> 
                    
                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar"> 
                    
                        <!-- panel-->
                        <div class="panel  news-editor"> 
                            <h3 class="panel-title">Best News Editors </h3> 
                                <ul class="list-unstyled">
                                    {@ editors}
                                    <li>
                                        <a href="/member/{.ids}">
                                            <img title="{.name}" data-toggle="tooltip" class="img-circle" src="{.picture}">
                                            <strong>{.name}</strong>
                                            <span class="icon-caret-right pull-right"></span>
                                        </a>
                                    </li>
                                    {/}
                                </ul> 
                        </div>
                        <!-- /panel-->
                    </div>
                    <!-- /sidebar --> 
                </div>
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 
    
   
<script type="text/javascript">
//<![CDAT

$(document).ready(function() {
    $(".ellipsis_n").dotdotdot({
        after: "a.readmore",
        tolerance            : 1,
        height           : 70,
        callback: hideLinkIfNoTruncation
    }).find('a.readmore').click(clicked)
});

function clicked() {
    var div=$(this).closest('.ellipsis_n')
    div.height('auto').trigger('destroy').find('.readmore').remove()
    return false
}

function hideLinkIfNoTruncation(isTruncated, origContent) {
    if (!isTruncated) {
        $('.readmore',this).remove()
    } 
}

function more_news(_this, _page){

    var get_url = "/ajax_front/more_news/"+_page;
    var n_p = parseInt(_page)+1;
    $.post(get_url, function(_data) {
        if (_data !== '') {
            $(_this).parent().prev().append(_data);
            $(_this).attr('onclick', "more_news(this,"+n_p+"); return false;");

            $(".ellipsis_n").dotdotdot({
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

function open_com(_this) {
    $(_this).parent().next().next().slideToggle();
    $(_this).parent().next().next().find('textarea').focus();
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
        } else {
            $(_this).parent().remove();
            alert("마지막 페이지입니다.");
        }
    });
}

function hide_news (_id) {
    msg_confirm('hide_news2('+_id+')', '이 뉴스를 숨길까요?');
}

function hide_news2 (_id) {
    var get_url = '/ajax_front/hide_news/'+_id;
    $.get(get_url, function() {
        $('#com_'+_id).parent().slideToggle();
        $('.modal').modal('hide');
    });
}
//]]>
</script> 