    <!-- rowContent -->
    <div class="rowContent" id="permalink"> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container" >
                <div class="full-content">
                    
                    <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2">
                        <div class="media-author text-center">
                            <div class="profile-img"><span class="img-circle"><img src="{res.picture}" class="img-circle"></span></div>
                            <h3><a href="{? res.p_type == 2}/startup/{res.p_id}{:}/member/{res.ids}{/}">{res.name}</a></h3> 
                        </div>
                        
                        <!-- panel -->
                        <div class="panel panel-default media-wrapper bottom">
                            <div class="arrow"></div>
                            <div class="panel-body"> 
                                <div class="media-content "> 
                                    {=add_brs(res.contents)}
                                    {? res.sub}{res.sub}{/}                                    
                                    <div class="media-meta">
                                        <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(res.date_created)}</span>  
                                        {? s}<button class="btn btn-link btn-xs" onclick="open_com(); return false;">댓글쓰기</button>{/}
                                    </div>
                                </div>
                                <!-- /media-content -->
                            </div>
                            <!--/ panel-body -->
                            <div class="panel-footer">
                                <ul class="media-list feed-list">
                                    {@ comm}
                                    <li class="media" id="com_{.id}"> 
                                        {? s.id == .user_id}<button type="button" class="close" aria-hidden="true" onclick="del_comm('{.id}', 0); return false;">&times;</button>{/}
                                        <a class="pull-left media-object" href="#"> <img src="{.picture}" class=" img-circle" data-toggle="tooltip" title="{.name}"> </a>
                                        <div class="media-body"> 
                                            <h4 class="media-heading"><a href="/member/{.ids}">{.name}</a></h4>   
                                            <div class="media-content">{.contents}</div>
                                            <div class="media-meta">
                                                <span class="time"><span class="fontawesome icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span>
                                            </div>
                                        </div>
                                    </li>
                                    {/}
                                </ul>
                                <div class="media media-form rounded add_com" style="display: none;"> 
                                    <a class="pull-left media-object " href="/member/{s.ids}"> 
                                        <img src="{?s.picture}{s.picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{s.name}"> 
                                    </a>
                                    <div class="media-body">
                                        <form name="tl_c_form_{res.id}">
                                            <input type="hidden" name="p_type" value="{res.p_type}" />
                                            <input type="hidden" name="depth" value="1" />
                                            <input type="hidden" name="parent" value="{res.id}" />
                                            <input type="hidden" name="p_id" value="{res.p_id}" />
                                            <input type="hidden" name="user_id" value="{s.id}" />
                                            <fieldset>
                                                <div class="form-group">
                                                    <label class="sr-only" for="inputTimeline">타임라인에 글쓰기</label>
                                                    <textarea row="3" class="form-control" id="inputTimeline" name="contents"></textarea>
                                                </div>
                                                <!-- /form-group -->
                                                <button class="btn btn-default btn-sm" onclick="submit_c_coment(this, '{res.id}'); return false;">저장하기</button>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div> 
                                <!-- /media-form -->
                            </div>
                            <!-- /panel-footer -->
                        </div>
                        <!-- /panel -->
                    </div>
                    <div class="clearfix"></div>
                    
                </div>
                <!-- /content -->                 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent -->
    
<script type="text/javascript">
//<![CDAT

function open_com() {
    $('.add_com').slideToggle();
    $('.add_com textarea').focus();
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