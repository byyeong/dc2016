<!-- rowContent -->
<div>type:{type}, pid:{pid}</div>
<div class="rowContent" id="about">
    <div class="page-header">
        <div class="container">
            <h2>About D.CAMP</h2>
            <select class="selectpicker pull-right" data-width="auto" onchange="location=this.value" >
                <optgroup label="Language">
                    <option value="/about" selected>한국어</option>
                    <option value="/about_en" >English</option>
                </optgroup>
            </select>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container" >
            <div class="row"> 
                 
                <div class="col-xs-12 col-sm-12 col-md-10  content" role="main"> 
                    <!-- media-list -->                         
                    <input type="hidden" id="page" value="{page}" /> 
                    <ul class="media-list feed-list" {? ! res}style="height: 300px"{/}>
                        {@ res}
                        <li class="media"> 
                            <a class="pull-left media-object" href="/member/{.ids}"> 
                                <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.name}" > 
                            </a>
                            <div class="media-body" id="com_{.id}"> 

                                {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                <h4 class="media-heading"><a href="/member/{.ids}">{.name}</a></h4> 
                                
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
                                        <a class="pull-left media-object" href="/member/{..ids}"> <img src="{..picture}" class="img-circle" data-toggle="tooltip" title="{..name}" > </a>
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
                        {:}
                        <li>등록된 보도자료가 없습니다.
                        </li>
                        {/}
                        <!-- /media -->
                    </ul>                     
                    {? sizeof(res) > 9}<div class="pager"> <a href="#" class="btn btn-default" onclick="more_press(this, '2'); return false;"> &darr;  더보기</a> </div>{/}
                    <!--  /media-list --> 
                </div> 
                <!-- /content -->
                
                <div class="col-xs-12 col-sm-12 col-md-2 sidebar">
                    <div class="affix hidden-print">
                        <ul class="nav ">
                            <li class="active"><a href="/about#dc-foundation">은행권청년창업재단</a></li>
                            <li><a href="/about#dc-dcamp">D.CAMP</a></li>
                            <li><a href="/about#dc-history">발자취</a></li>
                            <li><a href="/about#dc-space">공간소개</a></li>
                            <li><a href="/about#dc-program">D.Programs</a></li>
                            <li><a href="/about#dc-investment">투자활동</a></li>
                            <li><a href="/press">보도자료</a></li>
                            <li><a href="/about#dc-map">오시는 길</a></li>
                        </ul>
                    </div>
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

function more_press(_this, _page){

    var get_url = "/ajax_front/more_press/"+_page;
    var n_p = parseInt(_page)+1;
    $.post(get_url, function(_data) {
        if (_data !== '') {
            $(_this).parent().prev().append(_data);
            $(_this).attr('onclick', "more_press(this,"+n_p+"); return false;");

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
//]]>
</script> 