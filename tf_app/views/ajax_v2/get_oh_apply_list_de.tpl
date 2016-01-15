                                    <ul class="media-list">
                                        {@ res}
                                        <li class="media marked"> 
                                            {? admin}<a href="/admin_office/oh_apply_detail/{.id}"> 
                                            {:}<a href="/office_hours/m_apply/{.id}">{/}
                                                <span class="score pull-right">
                                                    <span class="sr-only">선정여부</span>
                                                    {? .status == 1}<span class="badge badge-primary">선정</span>{/}
                                                    {? .status == 2}<span class="badge badge-default">미선정</span>{/}
                                                </span> 
                                                <span class="media-object pull-left"><img src="{.picture}" class="img-responsive"></span>
                                                <div class="media-content">
                                                    <h4 class="media-heading">{.name} </h4>
                                                    <small class="group">{.team}</small> 
                                                </div>
                                            </a> 
                                        </li>
                                        {/}
                                    </ul>
                                    <div class="paging text-center">
                                        <ul class="pagination pagination-sm">
                                            {?page == 1}
                                            <li class="disabled"><a href="#">&laquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, '{type}', '{id}', '{page - 1}'); return false;">&laquo;</a></li>
                                            {/}

                                            {@paging.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_oh_apply_list_de(this, '{type}', '{id}', '{.page}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}

                                            {?page == paging.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, '{type}', '{id}', '{page + 1}'); return false;" >&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>