                                    {? res}
                                    <ul class="media-list">
                                        {@ res}
                                        <!-- todo : normal -->
                                        <li class="media {? .score != 0}marked{/}"> 
                                            <a href="#" onclick="get_apply(this, '{.id}'); return false;"> 
                                                <span class="status pull-right">
                                                    <span class="sr-only">접수상태 : </span>
                                                    {? .status == 0}<span class="label label-default">대기</span>{/}
                                                    {? .status == 1}<span class="label label-primary">접수</span>{/}
                                                    {? .status == 2}<span class="label label-warning">반려</span>{/}
                                                </span>
                                                {? .score != 0}<span class="score pull-right"><span class="sr-only">심사률 : </span>
                                                    <span class="badge badge-success">{.score}</span>
                                                </span>{/}
                                                <span class="media-object pull-left"><img src="{?.picture}{.picture}{:}/img/default-img-member.png{/}" class="img-responsive"></span>
                                                <div class="media-content">
                                                    <h4 class="media-heading">{?.f_name}{.f_name}{:}{.name}{/} </h4>
                                                    <small class="group"> {?.f_team}{.f_team}{:}{.team}{/}</small> 
                                                </div>
                                            </a> 
                                        </li>
                                        {/}
                                    </ul>
                                    <div class="paging text-center">
                                        <ul class="pagination" style=" margin: 0;">
                                            {?page == 1}
                                            <li class="disabled"><a href="#">&laquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_ap_list('{id}', '{type}', {page - 1}, '{div}'); return false;">&laquo;</a></li>
                                            {/}
                                            {@paging.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_ap_list('{id}', '{type}', {.page}, '{div}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}
                                            {?page == paging.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_ap_list('{id}', '{type}', {page + 1}, '{div}'); return false;">&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>
                                    {:}결과가 없습니다.
                                    {/}