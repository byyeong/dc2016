
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-event-edit -->
                    <div id="pane-event-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <button onClick="window.print()" class="btn btn-default btn-xs pull-right">인쇄하기</button>
                            <a class="btn btn-default btn-xs pull-right" href="/admin_program/applied_list/{res.id}">프로그램 참가자 목록보기</a>
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> Benefits 신청자</h2>
                        </div>
                        <!-- /panel-heading -->
                        <div class="panel-body">
                            {? per.ids}
                            <div class="media well" id="applicant-info"> 
                                <a href="/member/{per.ids}" class="pull-left media-object"><img class="img-responsive" src="{per.picture}" ></a>
                                <div class="media-body">
                                    <h5 class="media-heading"><a href="/member/{per.ids}">{per.name}</a></h5>
                                    <div class="item-status">
                                        <dl class="dl-horizontal "> 
                                            <dt style="text-align: left; width: 60px;">회사/팀</dt>
                                            <dd style="margin-left: 60px;"><a href="/startup/{per.com.sid}">{per.com.name}</a></dd>
                                            <dt style="text-align: left; width: 60px;">접수일자</dt>
                                            <dd style="margin-left: 60px;">{=date_to_kr(per.date_created)}</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <!-- /media -->
                            {/}
                            <div class="answered">
                                <br />
                                {? res.forms}
                                {? (res.basic & 1) == 1}
                                <dl>
                                    <dt>참가자 이름 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_name}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 2) == 2}
                                <dl>
                                    <dt>휴대폰 번호 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_tel}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 4) == 4}
                                <dl>
                                    <dt>이메일 주소 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_email}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 8) == 8}
                                <dl>
                                    <dt>간단한 자기소개 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_des}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 16) == 16}
                                <dl>
                                    <dt>팀 소개 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_t_des}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 32) == 32}
                                <dl>
                                    <dt>참가회사 / 팀명 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_team}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 64) == 64}
                                <dl>
                                    <dt>제품/서비스명 <span class="text-danger">*</span></dt>
                                    <dd>{per.f_service}</dd>
                                </dl>
                                {/}
                                {? (res.basic & 128) == 128}
                                <dl>
                                    <dt>제품/서비스 한 줄 소개 <span class="text-danger">*</span></dt>
                                    <dd>{per.s_des}</dd>
                                </dl>
                                {/}
                                {@ res.forms}
                                <dl>
                                    <dt>{.title}{? .req} <span class="text-danger">*</span>{/}</dt>
                                    {? .type == 'query'}
                                    {@ .opts}
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="form{.id}" value="{..key_ + 1}" {? .ress == ..key_ + 1}checked="checked"{/}>
                                            {..value_} </label>
                                    </div>
                                    {/}
                                    {:}
                                    <dd>{.ress}</dd>
                                    {/}
                                </dl>
                                {/}
                                {/}

                                
                                {? res.form_file}
                                {@ res.form_file}
                                <dl>
                                    <dt>{.title}{? .req} <span class="text-danger">*</span>{/}</dt>
                                    <dd>
                                        {? .val}
                                        <span class="icon-file"></span>
                                        <a href="/program/get_source?aid={per.id}&fid={.fid}">{.val}</a>
                                        {/}
                                    </dd>
                                </dl>
                                {/}
                                {/}
                            </div>
                            <!-- /answered  -->                              
                        </div> 
                    </div>
                    <!-- /panel #pane-event-edit --> 
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            <!-- /End Page Cotents --> 
        </div>
    </div>
</div>
<!-- /container --> 