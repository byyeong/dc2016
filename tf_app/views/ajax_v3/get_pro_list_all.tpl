                                    {? res}
                                    <ul class="media-list">
                                        {@ res}
                                        <!-- todo : normal -->
                                        <li class="media {? .score != 0}marked{/}"> 
                                            <a href="#" onclick="get_apply(this, '{.id}'); return false;"> 
                                                <span class="media-object pull-left"><img src="{.picture}" class="img-responsive"></span>
                                                <div class="media-content">
                                                    <h4 class="media-heading">{.name} </h4>
                                                    <small class="group"> {.date_created}</small> 
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