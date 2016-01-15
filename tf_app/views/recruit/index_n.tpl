<!-- rowContent -->
    <div class="rowContent" id="recruit"> 
        
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/recruit">Recruit</a></h2>
                <div class="pull-right">
                    <select data-width="auto" class="selectpicker sort-options pull-right" name="status">
                        <optgroup label="진행상태별 보기">
                            <option value="all" {?status == 'all'}selected="selected"{/}>전체</option>
                            <option value="ing" {?status == 'ing' || ing}selected="selected"{/}>진행중</option>
                            <option value="end" {?status == 'end'}selected="selected"{/}>마감</option>
                        </optgroup>
                    </select>

                    {? rec}
                    <button class="btn btn-primary" onclick="alert('권한을 가진 스타트업 정보가 없습니다.');"><span class="icon-pencil"></span> 채용정보 작성하기</button>
                    {:}
                    <button class="btn btn-primary" onclick=location.href='/recruit/add'> <span class="icon-pencil"></span> 채용정보 작성하기</button>
                    {/}
                    <div style="margin-top:7px; position:absolute; text-align: right; font-size:11px;"><a style="color:#999;" href="/support/views/55">채용 정보 등록이 어려우신가요?</a></div>
                </div>
            </div>
        </div>
        <!-- /page-header --> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"> 
                <div class="row">
                    <!-- contentn -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content">
                        <!-- media-list -->
                        <ul class="media-list post-list">
                            {@ res}
                            <li class="media"> 
                                <a class="pull-left media-object"  href="/startup/{.sid}"> 
                                    <img src="{.logo}" class="img-responsive"> 
                                </a>
                                <div class="media-body">
                                    <h3 class="media-heading">
                                        <a href="/startup/{.sid}">
                                            {.sname}
                                        </a>
                                    </h3>
                                    {? .bis}
                                    <ul class="list-inline list-tags"> 
                                        {@ .bis}
                                        <li>{.._value}</li>
                                        {/}
                                    </ul>
                                    {/}
                                    <p class="lead">{.bio}</p>

                                    {? .rec}{@ .rec}
                                    <div class="media-field well">
                                        <a href="/recruit/views/{..rid}">
                                            <h4>{..title}</h4>
                                            {? ..term}
                                            <dl class="dl-horizontal">
                                                <dt>고용형태</dt>
                                                <dd>{@ ..term}{? ...key_ == 0}{..._value}{:}, {..._value}{/}{/}</dd>
                                            </dl>
                                            {/}
                                            <dl class="dl-horizontal">
                                                <dt>업무분야</dt>
                                                <dd>{@ ..inv}{? ...key_ == 0}{..._value}{:}, {..._value}{/}{/}</dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                <dt>접수기간</dt>
                                                <dd>{? !..start && !..end}상시{:}{? ..start}{..start} ({=date_to_day_only(..start)}){/}{?..end} ~{..end} ({=date_to_day_only(..end)}) {/}{/}</dd>
                                            </dl>
                                        </a>
                                    </div>
                                    {/}{/}
                                    <!--div class="media-meta"> 
                                        <span class="author"><a href="/member/{.ids}"><img src="{.mpicture}" class="img-circle"> {.mname}</a></span> , 
                                        <span class="time"><span class="icon-time"></span> {=trans_date_ago(.date_created)}</span>
                                    </div-->
                                </div>
                            </li>
                            <!-- /media -->
                            {/}
                            
                        </ul>

                        <input type="hidden" id="page" value="{page}" />
                        {? sizeof(res) > 9}
                        <div class="pager"> <a href="#" class="btn btn-default" onclick="more_recruit(); return false;"> &darr;  더보기</a> </div>
                        {/}
                        <!-- /media-list --> 

                    </div>

                    <!-- sidebar -->
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                        <div class="panel  category">
                            {? status == 'ing' || ing}
                            <h3 class="panel-title">채용중인 직군</h3> 
                            {:}
                            <h3 class="panel-title">직군</h3> 
                            {/}
                            <ul class="list-unstyled">
                                <li><b><a href="/recruit{? ing}?ing={ing}{:}?status={status}{/}">전체</a> <small>({tot})</small></b></li>
                                {@ invL}{? .cnt > 0}
                                <li>
                                    {? inv == .id}<b>{/}
                                    {? !ing}<a href="/recruit?status={status}&inv={.id}">{._value} </a>{:}{._value}{/}
                                     <small>({.cnt})</small>{? inv == .id}</b>{/}
                                 </li>
                                {/}{/}
                            </ul> 
                        </div>
                        <!--/ panel -->
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
$("select[name=status]").change(function() 
{ 
    var _val = $("select[name=status] option:selected").val();
    document.location.href = "/recruit?status="+_val;
}); 
function more_recruit () {
    var _page = parseInt($('#page').val());
    _page = _page + 1;
    var get_url = '/ajax_front/more_recruit/'+ _page +'/{ing}';
    $.get(get_url, function(_data) {
        if (_data) {
            $('#page').val(_page);
            $('.post-list').append(_data);

            $(".ellipsis80").dotdotdot({
                height           : 80
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