    <!-- rowContent -->
    <div id="officehours" class="rowContent"> 
        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/office_hours">Office Hours</a></h2>
            </div>
        </div>
        <!-- /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container">
                <div class="row">
                <!-- Start Contents -->
                
                    <!-- content -->
                    <div class="content col-xs-12 col-sm-12 col-md-8">

                        <!-- article -->
                        <div class="article">
                            <div class="article-header">
                                <h3>with {mento.derpartment} {mento.name} {mento.position}</h3>
                            </div>
                            <div class="article-body">
                                <!-- status-info -->
                                <div class="item-status">
                                    <div class="alert alert-warning">
                                        현재 접수 중이 아닙니다. 
                                        {? s.id}
                                        <button class="btn btn-default btn-xs" onclick="set_alarm('{mento.id}'); return false;">접수 기간 알림받기</button>
                                        {:}
                                        <button class="btn btn-default btn-xs" onclick="javascript:alert('로그인 후 이용할 수 있습니다.');">접수 기간 알림받기</button>
                                        {/}
                                    </div>
                                </div>
                                <!-- /status-info -->

                                <!-- mentor-info -->
                                <div class="mentor-info">
                                    <div class="row">
                                        <div class="left col-xs-12 col-sm-2 col-md-3">
                                            <div class="vimg">
                                                <span style="background-image:url({mento.picture});">
                                                    <img src="/images/img_trans.png"  class="img-responsive">
                                                </span>
                                                <img src="{mento.picture}" class="sr-only">
                                            </div>
                                        </div>
                                        <div class="right col-xs-12 col-sm-10 col-md-9">
                                            <h4>
                                                <strong>{mento.name}</strong>
                                                <small>{mento.derpartment}{? mento.position}({mento.position}){/}</small>
                                            </h4>
                                            <dl>
                                                <dt>소개</dt>
                                                <dd>
                                                    {=add_brs(mento.description)}
                                                </dd>
                                            </dl>
                                            {? bios}
                                            <dl>
                                                <dt>약력</dt>
                                                <dd>
                                                    <ul>
                                                        {@ bios}
                                                        <li>{.bios}</li>
                                                        {/}
                                                    </ul>
                                                </dd>
                                            </dl>
                                            {/}
                                            {? article}
                                            <dl>
                                                <dt>관련기사</dt>
                                                <dd>
                                                    <ul>
                                                        {@ article}
                                                        <li><a href="{=check_http(.url)}" target="_blank">{.title}</a></li>
                                                        {/}
                                                    </ul>
                                                </dd>
                                            </dl>
                                            {/}
                                        </div>
                                    </div>
                                </div>
                                <!-- /mentor-info -->

                            </div>
                        </div>
                        <!-- /article -->

                        <!-- formApply -->
                        <div class="formApply">
                            <header>
                                <h3><i class="fa fa-pencil-square-o"></i> 참가 신청하기</h3>
                            </header>

                            <div class="alert alert-warning">
                                현재 접수 중이 아닙니다. 
                                {? s.id}
                                <button class="btn btn-default btn-xs" onclick="set_alarm('{mento.id}'); return false;">접수 기간 알림받기</button>
                                {:}
                                <button class="btn btn-default btn-xs" onclick="javascript:alert('로그인 후 이용할 수 있습니다.');">접수 기간 알림받기</button>
                                {/}
                            </div>

                        </div>
                        <!-- /formApply -->

                        <!-- #comment -->
                        <div id="comment">
                        </div>
                        <!-- /#comment -->
<script type="text/javascript">
//<![CDATA[
get_timeline(8, '{mento.id}', 1);
function get_timeline(_type, _id, _page)
{
    var get_url = '/ajax_front/get_timeline_2015/'+_type+'/'+_id+'/'+_page;
    $.get(get_url, function(_data) {
        $('#comment').html(_data);
    });
}
//]]>
</script>
                        

                    </div>
                    <!-- /content -->
                    {? other}
                    <!-- sidebar -->
                    <div class="sidebar col-xs-12 col-sm-12 col-md-4">
                        <section class="list-mentors">
                            <header>
                                <h3>Mentors</h3>
                            </header>
                            <ul class="list-unstyled">
                                {@ other}
                                <li> 
                                    <a href="/office_hours/views/{.hid}">
                                        <div class="vimg">
                                            <span style="background-image:url({.picture});">
                                                <img src="/images/img_trans.png"  class="img-responsive">
                                            </span>
                                            <img src="{.picture}" class="sr-only">
                                        </div>
                                        <h4>
                                            <strong class="ellipsis">{.name}</strong>
                                            <small class="ellipsis">{.department}{? .position}({.position}){/}</small>
                                        </h4>
                                    </a>
                                </li>
                                {/}
                            </ul>
                        </section>
                    </div>
                    <!-- /sidebar -->
                    {/}
                <!-- /End Contents -->
                </div>
            </div>
        </div>
        <!-- /page-content -->
    </div>
    <!-- /rowContent -->