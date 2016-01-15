<!-- rowContent -->
    <div class="rowContent"  id="competition">
        <div class="page-header">
            <div class="container">
                <h2><a href="/challenge">Challenge</a></h2>
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/challenge/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 경진대회 만들기</button>
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
                {? banner.pic_1}
                <div class="header-banner" style="background-image:url({banner.pic_1});" class="header-banner">
                    <a href="{banner.des_3}">
                        <div class="inner">
                            <h3>{banner.des_1}</h3>
                            <p>{banner.des_2}</p>
                        </div>
                    </a>
                </div>
                {/}

                <div class="row">
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        <!-- media-list -->
                        <ul class="media-list post-list">
                            {@ res}
                            <li class="media row"> 
                                {? .img}
                                <a class="pull-left media-object col-xs-12 col-sm-3 col-md-3"  href="/challenge/views/{? .url}{.url}{:}{.id}{/}"> 
                                    <img src="{.img}" class="img-responsive" > 
                                </a>
                                {/}
                                <div class="media-body col-xs-12 {? .img}col-sm-9 col-md-9{:}col-sm-12 col-md-12{/}">
                                    <h3 class="media-heading">
                                        <a href="/challenge/views/{? .url}{.url}{:}{.id}{/}">{.subject}</a> {? .is_ing} <span class="label label-primary" style="font-size: 11px;">접수 중</span>{/}
                                    </h3> 
                                    <p class="mulitple">{? .summary}{.summary}{:}{=mb_substr(strip_tags(.contents), 0, 400, 'UTF-8')}{/}</p>

                                    <div class="item-status">
                                        <dl class="dl-horizontal">
                                            <dt>주최/주관 </dt>
                                            <dd>{.organized}</dd>
                                            <dt>신청기한</dt>
                                            <dd>{.date_s} ({=date_to_day_only(.date_s)}) {.time_s} ~ {.date_e} ({=date_to_day_only(.date_e)}) {.time_e}</dd>
                                            <dt>발표일자</dt>
                                            <dd>{.announce_d} ({=date_to_day_only(.announce_d)}) {.announce_t}</dd>
                                        </dl>
                                    </div>

                                    <div class="media-meta"> 
                                        <span class="author"><a  href="/member/{.ids}"><img class="img-circle" src="{.picture}">{.name}</a></span> , 
                                        <span class="time"><span class="icon-time"></span> {=substr(.date_created, 0, 10)}</span>
                                    </div>
                                </div>
                            </li>
                            <!-- /media -->
                            {/}
                        </ul>
                        <!-- / media-list -->  

                        <input type="hidden" id="page" value="{page}" />
                        {? sizeof(res) > 9}
                        <div class="pager"> <a href="#" class="btn btn-default" onclick="more_competition('{status}', '{type}'); return false;"> &darr;  더보기</a> </div>
                        {/}
                    </div>
                    <!-- /content -->
                    
                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <!-- panel -->
                        <div id="loungebox" class="panel panel-default ">
                            <div class="panel-header">
                                <div class="cover">
                                    <h3 class="panel-title">D.CAMP Lounge</h3>
                                    <p>지금 D.CAMP에 {u_cnt}+명이 함께하고 있습니다</p>
                                </div>
                            </div>
                            <div class="panel-body">
                                <!-- media -->
                                <ul class="media-list">
                                    {@ lounge}
                                    <li class="media" id="com3397">
                                        <a class="media-left" href="/member/{.ids}">
                                            <img src="{.picture}" alt="{.name}" class="avatar img-circle">
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading">
                                                <a href="/member/{.ids}">{.name}</a> 
                                            </h4>
                                            <div class="media-content"> 
                                                <p>{=trans_url(add_brs(.contents))}</p>
                                            </div>
                                            {? .p_name}
                                            <div class="media-footer">
                                                <small>
                                                <a href="/lounge/event/{.p_id}">{.p_name} </a>
                                                </small>
                                            </div>
                                            {/}
                                            <div class="media-meta">
                                                <a class="date" href="/lounge/comment/{.id}">{=substr(.date_created, 0, -3)}</a>
                                                <span class="like">
                                                    <span class="glyphicon glyphicon-heart"></span> 
                                                    <span class="sr-only">좋아요 </span> 
                                                    <span class="cnt">{.like}</span>
                                                </span>
                                                <span class="comment">
                                                    <span class="glyphicon glyphicon-comment"></span> 
                                                    <span class="sr-only">댓글 </span>  
                                                    <span class="cnt">{.com}</span> 
                                                </span>
                                            </div>
                                        </div>
                                    </li>
                                    {/}
                                </ul> 
                            </div>
                            <div class="panel-footer">
                                <a href="/lounge">라운지 가기</a>
                            </div>
                        </div>
                        <!-- /panel--> 
                        <div class="panel">
                            <div class="fb-page" data-href="https://www.facebook.com/dcamp.kr" data-width="263" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/dcamp.kr"><a href="https://www.facebook.com/dcamp.kr">D.CAMP</a></blockquote></div></div>
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
$(document).ready(function(){ 
    _p = parseInt($('#page').val());
    if (_p > 1) {
        for (i = 2; i < _p+1; i++) { 
            more_competition ('{status}', '{type}', i);
        }
    }

    $("select[name=status]").change(function() 
    { 
        var _val = $("select[name=status] option:selected").val();
        document.location.href = "/challenge/"+_val+"/1?type={type}";
    }); 
    $("select[name=type]").change(function() 
    { 
        var _val = $("select[name=type] option:selected").val();
        document.location.href = "/challenge/{status}/1?type="+_val;
    }); 
}); 
function more_competition (_st, _ty, _p) {
    if (_ty === '') _ty = 0;
    
    if (!_p) {
        var _page = parseInt($('#page').val());
        _page = _page + 1;
    }
    else 
        var _page = _p;
    
    var get_url = '/ajax_v3/more_challenge/'+_st + '/' +_ty+'/'+ _page;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.post-list').append(_data);
            $('.mulitple').ellipsis({
                row: 2
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