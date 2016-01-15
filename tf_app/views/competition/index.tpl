<!-- rowContent -->
    <div class="rowContent"  id="competition">
        <div class="page-header">
            <div class="container">
                <h2><a href="/competition">Competition</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/competition/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 경진대회 만들기</button>
                {/}
                {/}
                <select data-width="auto" class="selectpicker sort-options pull-right" name="type">
                    <optgroup label="정렬">
                        <option value="0" {? !type} selected{/}>최신순</option>
                        <option value="1" {? type == 1} selected{/}>마감 임박 순</option>
                    </optgroup>
                </select>
                <select data-width="auto" class="selectpicker sort-options pull-right" name="status">
                    <optgroup label="진행상태별 보기">
                        <option value="all" {? status == 'all'} selected{/}>전체</option>
                        <option value="ing" {? status == 'ing'} selected{/}>진행중</option>
                        <option value="end" {? status == 'end'} selected{/}>마감</option>
                    </optgroup>
                </select>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"> 
                    <!-- media-list -->
                    <ul class="media-list post-list">
                        {@ res}
                        <li class="media">
                             
                            {? .img}<a class="pull-left media-object"  href="/competition/views/{.id}"> <img src="{.img}" class="img-responsive"> </a>{/}
                            
                            <div class="media-body">
                                <h3 class="media-heading"><a href="/competition/views/{.id}">{.subject}</a></h3>
                                
                                <div class="sidebar pull-right">
                                    {? .edate < date('Y.m.dH:i')}<p> <span class="label label-default">완료</span> </p>{/}
                                    <div class="item-status">
                                        <dl class="dl-horizontal">
                                            {?.organized}
                                            <dt>주최&middot;주관</dt>
                                            <dd>{.organized}</dd>{/}
                                            <dt>신청기한</dt>
                                            <dd>{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</dd>
                                            <dt>발표일자</dt>
                                            <dd>{.announce_d} ({=date_to_day_only(.announce_d)}) {.announce_t}</dd>
                                            {? !.platform && .platform_out}<dt>OC URL</dt>
                                            <dd><a href="{.platform_out}" target="_blank">{.platform_out}</a></dd>
                                            {/}
                                        </dl>
                                    </div>
                                </div>
                            
                                <p class="ellipsis100">{=substr(strip_tags(.contents), 0, 1000)}</p>
                                <div class="media-meta"> 
                                    <span class="author"><a  href="/member/{.ids}"><img class="img-circle" src="{.picture}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                            </div>
                            
                        </li>
                        <!-- /media -->
                        {/}
                    </ul>

                    <input type="hidden" id="page" value="{page}" />
                    {? sizeof(res) > 9}
                    <div class="pager"> <a href="#" class="btn btn-default" onclick="more_competition('{status}', '{type}'); return false;"> &darr;  더보기</a> </div>
                    {/}
                    
                    <!-- / media-list -->  
            </div>
            <!-- /container --> 
            
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 

<script type="text/javascript">
//<![CDAT
$(document).ready(function(){ 
    $("select[name=status]").change(function() 
    { 
        var _val = $("select[name=status] option:selected").val();
        document.location.href = "/competition/"+_val+"/1?type={type}";
    }); 
    $("select[name=type]").change(function() 
    { 
        var _val = $("select[name=type] option:selected").val();
        document.location.href = "/competition/{status}/1?type="+_val;
    }); 
}); 

function more_competition (_st, _ty) {
    if (_ty === '') _ty = 0;
    var _page = parseInt($('#page').val());
    _page = _page + 1;
    var get_url = '/ajax_front/more_competition/'+_st + '/' +_ty+'/'+ _page;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.post-list').append(_data);

            $(".ellipsis100").dotdotdot({
                height           : 100
            });
        }
        else {
            $('.pager').hide();
            alert('마지막 페이지 입니다.');
        }
    });
}
//]]>
</script> 