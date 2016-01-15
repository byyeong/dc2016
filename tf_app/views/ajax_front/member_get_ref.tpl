
                                <ul class="media-list feed-list">
                                    {? res}
                                    {@ res}
                                    <li class="media" id="ref_list_{.mrid}">
                                        <a class="media-left" href="/member/{.ids}"> 
                                            <img src="{? .picture}{.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-toggle="tooltip" title="{.name}">
                                        </a>
                                        <div class="media-body">
                                            <div class="media-heading">
                                                {? s.id == .user_id}
                                                <button type="button" class="close delete" data-toggle="tooltip" title="삭제" onclick="del_ref('{.mrid}'); return false;">&times;</button>
                                                {/}
                                                <strong><a href="/member/{.ids}">{.name}</a></strong>
                                                <span class="date"><span class="glyphicon glyphicon-time"></span>{=trans_date_ago(.mr_created)}</span>
                                            </div>
                                            <p>{.reference}</p>
                                        </div>
                                    </li>
                                    <!-- /media -->
                                    {/}
                                    {:}
                                    <li class="alert alert-info">
                                        <p class="text-info"><strong>Oops!</strong> 작성된 추천사가 없습니다.</p>
                                    </li>
                                    {/}
                                </ul>
                            
<script type="text/javascript">
//<![CDATA[
function add_ref() {
    $('#ref_form').slideToggle();
}

function close_ref(_this){
    $(_this).parent().next().slideToggle();
}

function close_ref2(_this){
    $(_this).parent().parent().parent().parent().slideToggle();
}

function del_ref(_id){
    del_confirm('del_ref2('+_id+')');
}

function del_ref2(_id){
    var get_url = '/ajax_front/member_del_ref/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('#ref_list_'+_id).slideToggle();
            $('#md-warning').modal('hide');
        }
    });
}
//]]>
</script> 
