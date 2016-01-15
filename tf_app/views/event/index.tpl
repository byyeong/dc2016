<!-- rowContent -->
<div class="rowContent" id="event">
    <div class="page-header">
        <div class="container">
            <h2><a href="/event">Event</a></h2>
            {? s.ids}
            <button  class="btn btn-primary pull-right" onclick=location.href='/event/add'><span class="icon-pencil"></span> 이벤트 만들기</button>
            {:}
            <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 이벤트 만들기</button>
            {/}
            <select data-width="auto" class="selectpicker sort-options pull-right" name="order">
                <optgroup label="정렬">
                    <option value="0" {? !order} selected{/}>최신순</option>
                    <option value="1" {? order == 1} selected{/}>마감 임박 순</option>
                </optgroup>
            </select>
            <select data-width="auto" class="selectpicker sort-options pull-right" name="status">
                <optgroup label="진행상태별 보기">
                    <option value="all" {? status == 'all'} selected{/}>전체</option>
                    <option value="ing" {? status == 'ing'} selected{/}>진행중인 이벤트</option>
                    <option value="end" {? status == 'end'} selected{/}>종료된 이벤트</option>
                </optgroup>
            </select>
            <select data-width="auto" class="selectpicker sort-options pull-right" name="type">
                <optgroup label="카테고리별 보기">
                    <option value="0" {? !type} selected{/}>전체</option>
                    {@ type_l}
                    <option value="{.id}" {? type == .id} selected{/}>{.name}</option>
                    {/}
                </optgroup>
            </select>
            
        </div>
    </div>
    <!-- /page-header --> 

    <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"> 
                {? banner.pic_1 && banner.active_1}
                <div style="background-image:url({banner.pic_1});" class="header-banner">
                    <a href="{banner.des_3}">
                        <div class="inner">
                            <h3>{banner.des_1}</h3>
                            <p>{banner.des_2}</p>
                        </div>
                    </a>
                </div>
                {/}

                <div class="row">
                    {@ res}
                    <div class="item card col-xs-12 col-sm-4 col-md-3">  
                        <div class="inner">
                            <a href="/event/apply/{.id}" class="featured-img">
                                <span style="background-image:url({? .picture}{.picture}{:}/images/img_thumb.png{/});">
                                    <img class="img-responsive" src="/images/img_trans.png" >
                                </span>
                            </a> 
                            <div class="caption">
                                <h3>
                                    <a href="/event/apply/{.id}" class="mulitple">{.title}</a>
                                </h3>
                                <dl class="dl-horizontal">
                                    <dt>신청기한</dt>
                                    <dd>{? .apply_start}{.apply_start} {/}{? .apply_end} ~ {.apply_end} {/} </dd>
                                    <dt>신청현황</dt>
                                    <dd>{? .eroll == 1}신청자 <span class="badge badge-success">{.rcnt}</span> / {/} 정원 <span class="badge badge-info">{?.cnt}{.cnt}{:}제한없음{/}</span></dd>
                                </dl>
                            </div>
                            <div class="footer">
                                <span class="category">
                                    <a href="/event/ing/?type={.eid}">{.ename}</a>
                                </span><span class="sep"></span>
                                <span class="author">
                                    <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.mname}">
                                        <img src="{.mpicture}" class="img-circle"> <span class="ellipsis">{.mname}</span>
                                    </a>
                                </span>
                                <span class="date">{=substr(.date_created, 0, 10)}</span>
                            </div>
                        </div>
                    </div>
                    <!-- /item --> 
                    {/}
                </div>
                <input type="hidden" id="page" value="{page}" />
                {? sizeof(res) > 15}
                <div class="pager"> <a href="#" class="btn btn-default" onclick="more_event('{status}', '{type}', '{order}'); return false;"> &darr;  더보기</a> </div>
                {/}
                <!-- media-list -->

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
        document.location.href = "/event/"+_val+"/?type={type}&order={order}";
    }); 
    $("select[name=type]").change(function() 
    { 
        var _val = $("select[name=type] option:selected").val();
        document.location.href = "/event/{status}/?type="+_val+"&order={order}";
    }); 
    $("select[name=order]").change(function() 
    { 
        var _val = $("select[name=order] option:selected").val();
        document.location.href = "/event/{status}/?type={type}&order="+_val;
    }); 
}); 
function more_event (_st, _ty, _or) {
    if (_ty === '') _ty = 0;
    var _page = parseInt($('#page').val());
    _page = _page + 1;
    var get_url = '/ajax_front/more_event/'+_st + '/' +_ty+'/'+_page +"/"+_or;
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.row').append(_data);
            $('.mulitple').ellipsis({
                row: 2
            });
            $('.ellipsis').ellipsis({
                row: 1
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