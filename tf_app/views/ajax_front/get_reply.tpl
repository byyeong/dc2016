
                            <div class="panel-heading">
                                <h3 class="panel-title"><span class="icon-edit"></span> 댓글 <small>{tot}}</small></h3>
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
                                                </div>
                                                </div>
                                                <!-- /form-group -->
                                                {? type == 1}
                                                <div class="form-tool pull-left">
                                                    {? s.id == pid}
                                                    <label class="checkbox-inline">
                                                        <input type="checkbox" name="is_news" value="1">뉴스
                                                    </label>
                                                    <span class="break"></span>
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
                                                <div class="pull-right">
                                                    <button class="btn btn-primary btn-sm" onclick="submit_comment(this); return false;">저장하기</button>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>

                                {? res}
                                <ul class="media-list">

                                    {@ res}{? !.is_hidden || .is_hidden && res.user_id == s.id || .is_hidden && pid == s.id}                                    <li class="media"> 
                                        <a class="pull-left" href="/member/{.ids}"> 
                                            <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.name}" style="width:40px;"> 
                                        </a>
                                        <div class="media-body" id="com_{.id}">
                                            <div class="media-heading">
                                                <h4><a href="/member/{.ids}">{.name}</a></h4>
                                                {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 1); return false;">&times;</button>{/}
                                            </div>
                                            <p>{.contents}{? .sub}{.sub}{/}</p>
                                            <div class="media-actions">
                                                <span class="time"><span class="fontawesome icon-time"></span><a href="/timeline/{.id}">&nbsp; {=trans_date_ago(.date_created)}</a></span>
                                                {? s}<button class="btn btn-link btn-xs" onclick="open_com(this); return false;">댓글쓰기</button>{/}
                                            </div>

                                            <!-- sub media -->
                                            <ul class="media-list">
                                                {@ .comm}
                                                <li class="media" id="com_{..id}"> 
                                                    <a class="pull-left" href="#"> <img src="{..picture}" class="media-object img-circle" data-toggle="tooltip" title="{..name}"  style="width:40px;"> </a>
                                                    <div class="media-body">
                                                        <div class="media-heading">
                                                            <h4><a href="/member/{..ids}">{..name}</a></h4>

                                                            {? s.id == ..user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{..id}', 0); return false;">&times;</button>{/}
                                                        </div>
                                                        <p>{..contents}</p>
                                                        <div class="media-actions">
                                                            <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(..date_created)}</span>
                                                        </div>
                                                    </div>
                                                </li>
                                                {/}
                                            </ul>
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
                                            <!-- /sub media form --> 
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
                            </div>
                            <!-- /panel-body -->

<script type="text/javascript">
//<![CDAT

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
//]]>
</script> 
