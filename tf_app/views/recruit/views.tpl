<!-- rowContent -->
<div class="rowContent" id="recruit"> 
    
    <div class="page-header">
        <div class="container">
            <h2><a href="/recruit">Recruit</a></h2>
            <button onclick="location.href='/recruit/add'" class="btn btn-primary pull-right"> <span class="icon-pencil"></span> 채용정보 작성하기</button>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container">
            <div class="row"> 
                
                <!-- content -->
                <div class="col-xs-12 col-sm-12 col-md-9 content">
                    <div class="article">
                        <div class="article-header"> 
                             <h3><a href="#">{res.title}</a></h3> 
                             <div class="meta"> 
                                <span class="author"><a  href="/member/{res.ids}">{res.mname}</a></span>&nbsp; 
                                <span class="time"><span class="icon-time"></span> {= trans_date_ago(res.date_created)}</span> &nbsp;                               
                                {? res.user_id == s.id}<a class="btn btn-default btn-xs" href="/recruit/add/{res.id}">수정하기</a>{/}
                             </div>
                        </div>
                        <div class="article-body">
                            <div class="item-status row">
                                <div class="col-xs-12 col-sm-3 col-md-3 company">
                                    <a href="/startup/{res.sid}"> <img src="{?res.slogo}{res.slogo}{:}/img/default-img-company.png{/}" class="img-thumbnail"></a> 
                                </div> 
                                <dl class="col-xs-12 col-sm-9 col-md-9  dl-horizontal">
                                    <dt>회사정보</dt>
                                    <dd>
                                        <a href="/startup/{res.sid}">{res.name}</a> {? res.addr} / {res.addr}{/} 
                                    </dd>
                                    <dt>채용공고기간</dt>
                                    <dd>{res.start} ({=date_to_day_only(res.start)}){?res.end} ~ {res.end} ({=date_to_day_only(res.end)}){/} {? res.end < date('Y.m.d')} <span class="label label-default">완료</span>{/}</dd>
                                    {? res.part}
                                    <dt>업무분야</dt>
                                    <dd>{@ res.part}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}{? res.job}
                                    <dt>채용분야</dt>
                                    <dd>{@ res.job}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}{? res.local}
                                    <dt>지역</dt>
                                    <dd>{@ res.local}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}{? res.carrer}
                                    <dt>경력</dt>
                                    <dd>{@ res.career}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}{? res.dev}
                                    <dt>개발분야</dt>
                                    <dd>{@ res.dev}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}{? res.term}
                                    <dt>고용형태</dt>
                                    <dd>{@ res.term}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}{? res.lang}
                                    <dt>언어</dt>
                                    <dd>{@ res.lang}{? .key_ == 0}{._value}{:}, {._value}{/}{/}</dd>
                                    {/}
                                    <dt>접수/문의</dt>
                                    <dd>{res.tel} / <a href="mailto:">{res.email}</a></dd>
                                 </dl> 
                             </div>
                                                     
                            <!-- article -->
                            <div class="fb-like" data-href="http://dcamp.kr/recruit/views/{res.id}" data-width="The pixel width of the plugin" data-height="The pixel height of the plugin" data-colorscheme="light" data-layout="standard" data-action="like" data-show-faces="true" data-send="false"></div>
                            <br/><br/>
                            
                            <article> 
                                {res.contents}                            
                            </article> 
                        </div>
                    </div>
                    <!-- / article --> 

                    <!-- comment -->
                    <div id="comment" >
<script type="text/javascript">
//<![CDATA[
get_timeline(4, '{res.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment').html(_data);
    });
}
//]]>
</script> 
                    </div>
                    <!-- /comment -->
                    
                    
                    <!-- pager -->
                    <!--
                    <ul class="pager">
                        <li><a href="#">&larr; 이전</a></li>
                        <li><a href="#">다음 &rarr;</a></li>
                    </ul>
                    //-->
                    <!-- /pager --> 
                    
                </div>
                <!-- /content --> 
                
                <!-- sidebar -->
                {? st_res}
                <div class="sidebar col-xs-12 col-sm-12 col-md-3">
                    <!-- panel -->
                    <div class="panel  recentpost">
                        <h3 class="panel-title">인기 Recruit</h3> 
                        <ul class="media-list post-list">
                             {@ st_res}{? .title}
                            <li class="media"> 
                                {?.logo}<a class="pull-left media-object" href="/recruit/views/{.rid}"> <img src="{?.logo}{.logo}{:}/img/default-img-company.png{/}" class="img-responsive" > </a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/recruit/views/{.rid}">{.sname}</a></h4>
                                    <div class="media-meta">
                                        <span class="date">{@ .part}{? ..key_ == 0}{.._value}{:}, {.._value}{/}{/}</span> 
                                    </div>
                                </div>
                                <!-- /media-content --> 
                            </li>
                            {/}{/}
                        </ul> 
                    </div>
                    <!-- /panel-->
                    <div class="panel">
                        <div class="fb-page" data-href="https://www.facebook.com/dcamp.kr" data-width="263" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/dcamp.kr"><a href="https://www.facebook.com/dcamp.kr">D.CAMP</a></blockquote></div></div>
                    </div>
                </div>
                {/}
                <!-- /sidebar --> 
                
            </div>
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
    
</div>
<!-- /rowContent --> 