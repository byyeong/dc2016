<!-- rowContent -->
    <div class="rowContent"  id="competition">
        <div class="page-header">
            <div class="container">
                <h2><a href="/benefits">Benefits</a></h2>
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/benefits/edit'><span class="icon-pencil"></span> 프로그램 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 프로그램 만들기</button>
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
                        <option value="ing" {? status == 'ing'} selected{/}>진행중</option>
                        <option value="end" {? status == 'end'} selected{/}>마감</option>
                    </optgroup>
                </select>
                <select data-width="auto" class="selectpicker sort-options pull-right" name="type">
                    <optgroup label="카테고리별 보기">
                        <option value="0" {? !type} selected="selected"{/}>전체 카테고리</option>
                        {@ cat}
                        <option value="{.id}" {? .id == type} selected="selected"{/}>{.category}</option>
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
                            <a href="/benefits/views/{.id}" class="featured-img">
                                <span style="background-image:url({? .img}{.img}{:}/img/default-img-pic.png{/});">
                                    <img class="img-responsive" src="/images/img_trans.png" >
                                </span>
                                <img class="sr-only" src="{? .img}{.img}{:}/img/default-img-pic.png{/}" >
                            </a> 
                            <div class="caption"> 
                                <span class="category">{.category}</span>
                                <h3>
                                    <a href="/benefits/views/{.id}" class="mulitple">
                                    {.title}
                                    </a>
                                </h3>
                                <dl class="dl-horizontal">
                                    <dt>지원기관 </dt>
                                    <dd class="ellipsis">{.agency}</dd>
                                    <dt>접수기간</dt>
                                    <dd>{? .a_start}{=substr(.a_start, 0, 10)} ~ {=substr(.a_end, 0, 10)}{:}상시{/}</dd>
                                </dl>
                            </div>
                            <div class="footer">
                                <span class="author">
                                    <a href="/member/{.ids}" data-toggle="tooltip" data-placement="top" title="{.name}({.ids})">
                                        <img src="{? .picture}{.picture}{:}/images/img_default.png{/}" class="img-circle"> <span class="ellipsis">{.name}({.ids})</span>
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
                {? sizeof(res) > pagesize - 1}
                <div class="pager"> <a href="#" class="btn btn-default" onclick="more_program('{status}', '{type}'); return false;"> &darr;  더보기</a> </div>
                {/}
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
        document.location.href = "/benefits/"+_val+"/1?type={type}&order={order}";
    }); 
    $("select[name=type]").change(function() 
    { 
        var _val = $("select[name=type] option:selected").val();
        document.location.href = "/benefits/{status}/1?type="+_val+"&order={order}";
    });
    $("select[name=order]").change(function() 
    { 
        var _val = $("select[name=order] option:selected").val();
        document.location.href = "/benefits/{status}/1?type={type}&order="+_val;
    }); 
}); 
function more_program (_st, _ty) {
    if (_ty === '') _ty = 0;
    var _page = parseInt($('#page').val());
    _page = _page + 1;
    var get_url = '/ajax_v3/more_program/'+_st+'/'+ _page+'?type='+_ty+'&order={order}';
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.row').append(_data);

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