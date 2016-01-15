                        <div class="panel competitor-list"  id="markedList">
                            
                            <h3 class="panel-title">심사 목록</h3>
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#mark-none" data-toggle="tab">남은심사 </a><span class="badge badge-warning">{yet_c}</span></li>
                                <li><a href="#mark-total" data-toggle="tab">전체 </a><span class="badge badge-info">{all_c}</span></li>
                                <li><a href="#mark-complete" data-toggle="tab">심사완료 </a><span class="badge badge-primary"> {aft_c}</span></li>
                                
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="mark-none">
                                    <ul class="media-list">
                                        {@ yet}
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
                                    {? yet}
                                    <div class="paging text-center">
                                        <ul class="pagination pagination-sm">
                                            {?page == 1}
                                            <li class="disabled"><a href="#">&laquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, 3, '{id}', '{page - 1}'); return false;">&laquo;</a></li>
                                            {/}

                                            {@paging3.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_oh_apply_list_de(this, 3, '{id}', '{.page}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}

                                            {?page == paging3.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, 3, '{id}', '{page + 1}'); return false;" >&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>
                                    {/}
                                </div>
                                <!-- /tab-pane --> 
                                <div class="tab-pane" id="mark-total">
                                    <ul class="media-list">
                                        {@ all}
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
                                    {? all}
                                    <div class="paging text-center">
                                        <ul class="pagination pagination-sm">
                                            {?page == 1}
                                            <li class="disabled"><a href="#">&laquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, 1, '{id}', '{page - 1}'); return false;">&laquo;</a></li>
                                            {/}

                                            {@paging1.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_oh_apply_list_de(this, 1, '{id}', '{.page}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}

                                            {?page == paging1.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, 1, '{id}', '{page + 1}'); return false;" >&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>
                                    {/}
                                </div>
                                <!-- /tab-pane -->
                                
                                <div class="tab-pane" id="mark-complete">
                                    <ul class="media-list">
                                        {@ aft}
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
                                    {? aft}
                                    <div class="paging text-center">
                                        <ul class="pagination pagination-sm">
                                            {?page == 1}
                                            <li class="disabled"><a href="#">&laquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, 1, '{id}', '{page - 1}'); return false;">&laquo;</a></li>
                                            {/}

                                            {@paging2.pages}
                                            {?.type == "dot"}
                                            <li class="disabled"><a href="#">...</a></li>
                                            {:}
                                            <li {?.type == "current"}class="active"{/}><a href="#" onclick="get_oh_apply_list_de(this, 2, '{id}', '{.page}'); return false;">{.page}</a></li>
                                            {/}
                                            {/}

                                            {?page == paging2.tot_page}
                                            <li class="disabled"><a href="#">&raquo;</a></li>
                                            {:}
                                            <li><a href="#" onclick="get_oh_apply_list_de(this, 2, '{id}', '{page + 1}'); return false;" >&raquo;</a></li>
                                            {/}
                                        </ul>
                                    </div>
                                    {/}
                                </div>
                                <!-- /tab-pane -->
                            </div>
                            <!-- /tab-content --> 
                        </div>
                        <!-- panel --> 