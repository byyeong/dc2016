
            
                <div class="col-xs-12 col-sm-12 col-md-9 content">                
                     
                     <div class="content-header">
                        <h3 class="content-heading"><span class="icon-location-arrow"></span> 액티비티 </h3>
                    </div>                      

                    <input type="hidden" id="page" value="1" />                
                    
                    {? !res}
                    <!-- todo: 액티비티가 없을 경우 출력 -->
                    <div class="media-none alert alert-info">
                        <strong>Oops!</strong> 
                        아직 액티비티가 없습니다. <br>
                        이벤트 참여신청, 공간공유 신청 등 회원님의 다양한 활동을 기다리고 있습니다.
                    </div>
                    {:}                   
                    
                    
                    <!-- media-list -->
                    <ul class="media-list feed-list">
                        {@ res}
                        {? .msg}
                        <li class="media"> 
                            {? .act_type == 1}
                            <a class="pull-left media-object" href="/member/{.ow_ids}"> <img src="{? .ow_picture}{.ow_picture}{:}/img/default-img-member.png{/}" class="img-circle" data-toggle="tooltip" title="{.ow_name}"> </a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="/member/{.ow_ids}">{.ow_name}</a></h4>
                                <div class="media-content">{.msg}</div>
                            </div>
                            {/}
                            {? .act_type == 2}
                            <a class="pull-left media-object " href="/startup/{.ow_id}"> <img src="{?.ow_logo}{.ow_logo}{:}/img/default-img-company.png{/}" class="img-circle"  data-toggle="tooltip" title="{.ow_name}"> </a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="/startup/{.ow_id}">{.ow_name}</a></h4>
                                <div class="media-content">{.msg}</div>
                            </div>
                            {/}
                        </li>
                        {:}
                        {? .target_type == 1}{? .data.title}
                        {?.is_made}
                        <li class="media"> 
                            <a class="pull-left media-object" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> 이벤트 신청 현황</h4> 
                                <div class="media-content">                               
                                    <p>{.mem.name}님이 신청한 <strong><a href="/event/apply/{.data.id}">{.data.title}</a></strong> 이벤트 진행 상황입니다. 
                                        {? .act_result == 0}<span class="label label-info">승인대기</span></p>{/}
                                        {? .act_result == 1}<span class="label label-success">승인</span></p>{/}
                                        {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                    <ul>
                                        <li>이벤트명 : {.data.title}</li>
                                        <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                        <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                        <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.sname} {.data.opt}층{/}</li>
                                    </ul>
                                </div>
                                <div class="media-meta"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                            </div>
                        </li>
                        {:}
                        <li class="media"> <a class="pull-left" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class="media-object img-circle" data-src="holder.js/40x40" data-toggle="tooltip" title="{.mem.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> 이벤트 참여 현황</h4>
                                <div class="media-content">                                
                                    <p>{.mem.name}님이 참여 신청한 <strong><a href="/event/apply/{.data.id}">{.data.title}</a></strong> 이벤트 진행 상황입니다. 
                                        {? .act_result == 0}<span class="label label-info">참여 접수</span></p>{/}
                                        {? .act_result == 1}<span class="label label-success">참여대상</span></p>{/}
                                        {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                    <ul>
                                        <li>이벤트명 : {.data.title}</li>
                                        <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                        <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                        <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.sname} {.data.opt}층{/}</li>
                                    </ul>
                                </div>
                                <div class="media-meta"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                            </div>
                        </li>
                        {/}
                        {/}{/}
                        {? .target_type == 2}{? .data.purpose}
                        <li class="media"> 
                            <a class="pull-left media-object" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> 공간공유 신청 현황 </h4>
                                <div class="media-content">
                                    <p>{.mem.name}님이 참여 신청한 <strong><a href="#">{.data.purpose}</a></strong> 공간공유 신청 진행 상황입니다. 
                                        {? .act_result == 0}<span class="label label-info">승인대기</span></p>{/}
                                        {? .act_result == 1}<span class="label label-success">승인</span></p>{/}
                                        {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                    <ul>
                                        <li>목적 : {.data.purpose}</li>
                                        <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                        <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                        <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.name} {.data.opt}층{/}</li>
                                    </ul>
                                </div>
                                <div class="media-met"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                            </div>
                        </li>
                        {/}{/}
                        {? .target_type == 11}
                        <li class="media"> 
                            <a class="pull-left media-object" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> 경진대회 참여 현황 </h4>
                                <div class="media-content">
                                    <p>{.mem.name}님이 신청한 <strong><a href="/competition/views/{.data.id}">{.data.subject}</a></strong> 경진대회 참여 현황입니다. 
                                        {? .act_result == 0}<span class="label label-info">승인대기</span></p>{/}
                                        {? .act_result == 1}<span class="label label-success">승인</span></p>{/}
                                        {? .act_result == 2}<span class="label label-warning">반려</span></p>{/}
                                    <ul>
                                        <li>경진대회명 : {.data.subject}</li>
                                        <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                        <li>주최·주관 : {.data.organized}</li>
                                        <li>참가기간 : {.data.date_s} ({=date_to_day_only(.data.date_s)}) {.data.time_s} ~ {.data.date_e} ({=date_to_day_only(.data.date_e)}) {.data.time_e}</li>
                                        <li>발표일자 : {.data.announce_d} ({=date_to_day_only(.data.announce_d)}) {.data.announce_t}</li>
                                    </ul>
                                </div>
                                <div class="media-met"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                            </div>
                        </li>
                        {/}
                        {? .target_type == 13}
                        <li class="media"> 
                            <a class="pull-left media-object" href="/member/{.mem.ids}"> <img src="{?.mem.picture}{.mem.picture}{:}/img/default-img-member.png{/}" class=" img-circle"  data-toggle="tooltip" title="{.mem.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> Office Hours 참여 현황 </h4>
                                <div class="media-content">
                                    <p>{.mem.name}님이 신청한 <strong><a href="/office_hours/views/{.res.id}">{.res.subject}</a></strong> Office Hours 참여 현황입니다. 
                                        {? .act_result == 0}<span class="label label-info">심사중</span></p>{/}
                                        {? .act_result == 1}<span class="label label-success">선정</span></p>{/}
                                        {? .act_result == 2}<span class="label label-warning">미선정</span></p>{/}
                                    <ul>
                                        <li>주최&middot;주관 : {.res.hosted}</li>
                                        <li>참가 장소 : {.res.place}</li>
                                        <li>참가 일자 : {=substr(.res.e_start, 0, 10)} ({=date_to_day_only(.res.e_start)}) {=substr(.res.e_start, 11)} ~ {=substr(.res.e_end, 0, 10)} ({=date_to_day_only(.res.e_end)}) {=substr(.res.e_end, 11)}</li>
                                        <li>접수 기간 : {=substr(.res.a_start, 0, 10)} ({=date_to_day_only(.res.a_start)}) {=substr(.res.a_start, 11)} ~ {=substr(.res.a_end, 0, 10)} ({=date_to_day_only(.res.a_end)}) {=substr(.res.a_end, 11)} </li>
                                        <li>발표 일자 : {=substr(.res.r_date, 0, 10)} ({=date_to_day_only(.res.r_date)}) {=substr(.res.r_date, 11)} / 메일을 통해 개별 안내 </li>
                                    </ul>
                                </div>
                                <div class="media-meta"><span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span></div>
                            </div>
                        </li>
                        {/}
                        {/}
                        {/}
                    </ul>
                    {? sizeof(res) > 9}
                    
                    <div class="pager"> <a href="#" class="btn btn-default" onclick="more_act(this); return false;"> &darr;  더보기</a> </div>
                    {/}
                    {/} 
                    <!-- /media-list -->
                    
                </div>
                <!-- /content --> 


<script type="text/javascript">
//<![CDATA[

    function more_act(_this) {
        var p = $('#page').val();
        var next = parseInt(p) + 1;
        var get_url = "/ajax_front/more_act/1/{s.id}/"+next;

        $.post(get_url, function(_data) {
            if (_data !== '') {
                $('#page').val(next);
                $('.media-list').append(_data);
            } else {
                $(_this).parent().remove();
                alert("마지막 페이지입니다.");
            }
        });
    }

//]]>
</script>    