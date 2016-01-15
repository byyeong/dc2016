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
                        {? .act_type == 1}{? .data.title}
                        <li class="media"> <a class="pull-left" href="/member/{s.ids}"> <img src="{s.picture}" class="media-object img-circle" data-src="holder.js/40x40" data-toggle="tooltip" title="{s.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> 이벤트 참여 현황</h4>
                                <span class="time"><span class="icon-time"></span>&nbsp; {.date_created}</span>
                                <p>회원님이 참여 신청한 <strong><a href="/event/apply/{.data.id}">{.data.title}</a></strong> 이벤트 진행 상황입니다. 
                                    {? .act_result == 0}<span class="label label-info">참여 접수 중</span></p>{/}{? .act_result == 1}<span class="label label-info">승인</span></p>{/}
                                {? .act_result == 0}
                                <ul>
                                    <li>이벤트명 : {.data.title}</li>
                                    <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                    <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                    <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.sname} {.data.opt}층{/}</li>
                                </ul>
                                {/}
                            </div>
                        </li>
                        {/}{/}
                        {? .act_type == 2}{? .data.purpose}
                        <li class="media"> <a class="pull-left" href="/member/{s.ids}"> <img src="{s.picture}" class="media-object img-circle" data-src="holder.js/40x40" data-toggle="tooltip" title="{s.name}"  > </a>
                            <div class="media-body">
                                <h4 class="media-heading"> 공간공유 신청 현황 </h4>
                                <span class="time"><span class="icon-time"></span>&nbsp; 2013.09.30</span>
                                <p>회원님이 참여 신청한 <strong><a href="#">{.data.purpose}</a></strong> 공간공유 신청 진행 상황입니다. 
                                    {? .act_result == 0}<span class="label label-info">신청 접수 중</span></p>{/}{? .act_result == 1}<span class="label label-info">승인</span></p>{/}
                                    {? .act_result == 2}<span class="label label-info">반려</span></p>{/}
                                {? .act_result == 0}
                                <ul>
                                    <li>목적 : {.data.purpose}</li>
                                    <!--<li>접수기간 : 2013년 7월 11일(목) 11:00 ~2013년 7월 21일(일) 18:00</li>-->
                                    <li>일정 : {.data.date} {.data.start}~{.data.end}</li>
                                    <li>장소 : {? .data.space_etc}{.data.space_etc}{:}{.data.name} {.data.opt}층{/}</li>
                                </ul>
                                {/}
                            </div>
                        </li>
                        {/}{/}
                        {/}
                        {/}