
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"><!-- section -->
                <section> 
                    <input type="hidden" id="sid" value="{res.id}" />
                    <input type="hidden" id="cnt_se" value="{=sizeof(service)}" />
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-briefcase"></span><span class="break"></span>스타트업 정보</h2>
                            <div class="actions"> <span class="break"></span> <a href="/admin_startup" class="btn-add"  data-toggle="tooltip" title="스타트업 목록"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body">
                            <ul id="companyTab" class="nav nav-tabs">
                                <li class="active"><a href="#info-company" data-toggle="tab"> 기업 기본정보</a></li>
                                <li><a href="#info-company-add" data-toggle="tab">  기업 추가정보</a></li>
                                {? service}{@ service}
                                <li><a href="#info-service_{.key_+1}" data-toggle="tab">  {.name}</a></li>
                                {/}{:}
                                <li><a href="#info-service" data-toggle="tab">  서비스 정보</a></li>
                                {/}
                                <li><a href="#" onclick="add_service(this); return false;" data-toggle="tooltip" title="서비스 추가하기" ><span class=" glyphicon glyphicon-plus"></span></a></li>
                            </ul>
                            
                            <!-- tab-content -->
                            <div id="companyContent" class="tab-content"> 
                                
<!-- tab-pane1 -->
                                <div class="tab-pane active" id="info-company">
                                    <form class="form-horizontal" name="step1" id="step1" onsubmit="return false;">
                                        <input type="hidden" name="id" value="{res.id}" />
                                        <input type="hidden" name="cnt_sk" id="cnt_sk" value="{? sizeof(res_sk) > 0}{=sizeof(res_sk)}{:}1{/}" />
                                        <input type="hidden" name="cnt_int" id="cnt_int" value="{? sizeof(res_in) > 0}{=sizeof(res_in)}{:}1{/}" />
                                        <!-- fieldset -->
                                        <fieldset class="well">
                                            <h3>기업 기본정보</h3>
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회사명</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control"  id="inputCompanyName" name="name" value="{res.name}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >한줄설명</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" id="inputSummary" name="bio" value="{res.bio}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >로고</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="hidden" name="img" id="img" value="">
                                                    <!--<iframe width="100%" scrolling="no" height="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old={=safe_js(res.logo)}" allowtransparency="true"></iframe>//-->
                                                    <img class="img-thumbnail" src="{? res.logo}{res.logo}?date={=date('his')}{:}/img/default-img-member.png{/}" id="img_img" onclick="toggle_img();return false;">
                                                    <div id="div_img_change" style="display: none;">
                                                        <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img" ></iframe>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >대표자</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" id="inputOwner" name="ceo" value="{res.ceo}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >설립일</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-inline"> 
                                                        <!-- datepicker -->
                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" placeholder="" name="founded" value="{res.founded}" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker --> 
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >임직원수</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                    <!-- length-number -->
                                                    <div class="input-group length-number">
                                                        <input type="number" class="form-control" id="inputPersons" name="number" value="{res.number}">
                                                        <span class="input-group-addon">명</span> </div>
                                                    <!-- /length-number --> 
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >사업분야</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    {? res_in}{@ res_in}
                                                    <p class="form-group-tag" id="add_int_{.key_+1}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>  
                                                        <input type="text" class="form-control suggest_job" id="suggest_job" name="inter_{.key_+1}" value="{._value}" placeholder="사업분야를 입력해주세요." onkeydown="return ignoreEnter(event);">                                   
                                                    </p>
                                                    {/}{:}
                                                    <p class="form-group-tag" id="add_int_1">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>                                        
                                                        <input type="text" class="form-control suggest_job" name="inter_1" placeholder="사업분야를 입력해주세요." onkeydown="return ignoreEnter(event);">
                                                    </p>
                                                    {/}
                                                    <!-- /well --> 
                                                    <button type="button" class="btn btn-default btn-sm" onclick="add_int(this); return false;"><span class="glyphicon  glyphicon-plus"></span> 사업분야 추가</button>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >핵심기술</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    {? res_sk}{@ res_sk}
                                                    <p class="form-group-tag" id="add_sk_{.key_+1}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <input type="text" class="form-control suggest_skill" name="skill_{.key_+1}" value="{._value}" placeholder="핵심기술을 입력해주세요." onkeydown="return ignoreEnter(event);">                                                    </p>
                                                    {/}{:}
                                                    <p class="form-group-tag" id="add_sk_1">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>    
                                                        <input type="text" class="form-control suggest_skill" id="feeds_contents" name="skill_1" placeholder="핵심기술을 입력해주세요." onkeydown="return ignoreEnter(event);">                                                    </p>
                                                    {/}
                                                    <!-- /well --> 
                                                    <button type="button" class="btn btn-default btn-sm" onclick="add_sk(this); return false;"><span class="glyphicon  glyphicon-plus"></span> 핵심기술 추가</button>
                                                </div>
                                            </div>
                                            <!-- /form-group-->

                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >웹사이트</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="url" class="form-control"  id="inputWebsite" name="website" value="{res.website}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >블로그</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="url" class="form-control"  id="inputBlog" name="blog" value="{res.blog}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >SNS</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="input-group"> <span class="input-group-addon">Twitter</span>
                                                        <input type="text"  placeholder="mytwitterID" class="form-control" name="twitter" value="{res.twitter}">
                                                    </div>
                                                    <div class="input-group"> <span class="input-group-addon">Facebook</span>
                                                        <input type="text" placeholder="myfacebookID" class="form-control" name="facebook" value="{res.facebook}">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >메일주소</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="email" class="form-control" id="inputEmail" name="email" value="{res.email}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >주소</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" id="inputAddress" name="addr" value="{res.addr}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >전화번호</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="tel" class="form-control" id="inputTel" name="tel" value="{res.tel}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >상태 처리</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <select name="state" data-width="auto" class="selectpicker" >
                                                        <option value="0" {? res.state == 0}selected="selected"{/}>승인대기</option>
                                                        <option value="1" {? res.state == 1}selected="selected"{/}>승인</option>
                                                        <option value="2" {? res.state == 2}selected="selected"{/}>비공개</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                                    
                                            <div class="btn-toolbar">
                                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button type="button" class="btn btn-default">취소</button>
                                                    <button type="submit" class="btn btn-primary" onclick="go_step1(); return false;">확인</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
<!-- /tab-pane1 -->
                                
                                
                                
<!-- tab-pane2 -->
                                <div class="tab-pane" id="info-company-add">
                                    <form class="form-horizontal" name="step2" id="step2" onsubmit="return false;">
                                        <input type="hidden" name="cnt_ref" id="cnt_ref" value="{? ref}{=sizeof(ref)}{:}1{/}" />
                                        <input type="hidden" name="cnt_inv" id="cnt_inv" value="{? inv}{=sizeof(inv)}{:}1{/}" />
                                        <input type="hidden" name="cnt_inc" id="cnt_inc" value="{? inc}{=sizeof(inc)}{:}1{/}" />
                                        <input type="hidden" name="cnt_fou" id="cnt_fou" value="{? fou}{=sizeof(fou)}{:}1{/}" />
                                        <!-- fieldset -->
                                        <fieldset  class="well">
                                            <h3>기업 추가정보</h3>
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 투자내역</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                    
                                                    <!-- todo :  추가하면 .well이 반복되어 생성 --> 
                                                    <!-- well -->
                                                    {? inv}{@ inv}
                                                    <div class="well well-small" id="add_investment_{.key_+1}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <div class="form-group"> 
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자자/기관</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="text" class="form-control" name="investor_{.key_+1}" value={.investor} >
                                                            </div>
                                                        </div>
                                                        <div class="form-group"> 
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이메일 주소</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="email" class="form-control" name="iv_email_{.key_+1}" value="{.email}" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 일자</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <div class="form-inline">
                                                                    <label class="sr-only" for="inputStartDate">투자일</label>
                                                                    <div class="bfh-datepicker" data-format="y.m.d">
                                                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                            <input type="text" class="form-control datepicker" name="date_{.key_+1}" value="{.date}" placeholder="" readonly>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 금액</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <div class="form-inline"> 
                                                                    <!-- lenght-number -->
                                                                    <div class="form-group">
                                                                        <label for="inputMoney" class="sr-only">금액입력</label>
                                                                        <div class="input-group length-money"> <span class="input-group-addon">₩</span>
                                                                            <input type="text" id="inputMoney" class="form-control" name="investment_{.key_+1}" value="{.investment}">
                                                                        </div>
                                                                    </div>
                                                                    <!-- /lenght-number --> 
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 형태</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="text" class="form-control" name="type_{.key_+1}" value="{.type}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    {/}{:}
                                                    
                                                    <div class="well well-small" id="add_investment_1">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <div class="form-group"> 
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자자/기관</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="text" class="form-control" name="investor_1" >
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group"> 
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이메일 주소</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="email" class="form-control" name="iv_email_1" >
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 일자</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                    <!-- datepicker -->
                                                                    <div class="bfh-datepicker" data-format="y-m-d">
                                                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                            <input type="text" class="form-control datepicker" id="inputStartDate" name="date_1" placeholder="" readonly>
                                                                        </div>
                                                                    </div>
                                                                    <!-- /datepicker -->  
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 금액</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <div class="input-group length-money"> 
                                                                            <span class="input-group-addon">₩</span>
                                                                            <input type="text" id="inputMoney" class="form-control" name="investment_1">
                                                                </div> 
                                                                <!-- /input-group  --> 
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >투자 형태</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="text" class="form-control" name="type_1" >
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    {/}
                                                    <!-- /well -->
                                                    
                                                    <button type="button" class="btn btn-default  btn-sm" onclick="add_inv(this); return false;"><span class="glyphicon  glyphicon-plus"></span> 다른 투자내역 추가</button>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이팅 프로그램 / 기관 참여 내역</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                    <!-- well -->
                                                    {? inc}{@ inc}
                                                    <div class="well well-small" id="add_incubate_{.key_+1}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이터</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="text" class="form-control" name="incubator_{.key_+1}" value="{.incubator}">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >프로그램 상세</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <textarea name="des_{.key_+1}" class="form-control" rows="3">{.description}</textarea>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이메일 주소</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="email" class="form-control" name="ic_email_{.key_+1}" value="{.email}">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이팅 기간</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <!-- form-group-date -->
                                                                <div class="form-group-date"> 
                                                                        <div class="bfh-datepicker" data-format="{.start}">
                                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                                <input type="text" class="form-control datepicker" name="start_{.key_+1}" value="{.start}" placeholder="" readonly>
                                                                            </div>
                                                                        </div>
                                                                     
                                                                    <span>&sim;</span>
                                                                      
                                                                        <div class="bfh-datepicker" data-format="{.end}">
                                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                                <input type="text" class="form-control datepicker" name="end_{.key_+1}" value="{.end}" placeholder="" readonly>
                                                                            </div>
                                                                        </div> 
                                                                </div>
                                                                <!-- /form-group-date --> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                    {/}{:}
                                                    <div class="well well-small" id="add_incubate_1">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이터</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="text" class="form-control" name="incubator_1" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >프로그램 상세</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <textarea name="des_1" class="form-control" rows="3"></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이메일 주소</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                                <input type="email" class="form-control" name="ic_email_1" >
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인큐베이팅 기간</div>
                                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                                <!-- form-group-date -->
                                                                <div class="form-group-date"> 
                                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                                <input type="text" class="form-control datepicker" name="start_1" value="" placeholder="" readonly>
                                                                            </div>
                                                                        </div> 
                                                                    <span>&sim;</span> 
                                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                                <input type="text" class="form-control datepicker" name="end_1" value="" placeholder="" readonly>
                                                                            </div>
                                                                        </div> 
                                                                </div>
                                                                <!-- /form-group-date --> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                    {/}
                                                    <!-- /well --> 
                                                    <!-- todo :  추가하면 .well이 반복되어 생성 -->
                                                    <button type="button" class="btn btn-default  btn-sm" onclick="add_inc(this); return false;"><span class="glyphicon  glyphicon-plus"></span> 다른 인큐베이터 추가</button>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >창업자 추가</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">                                                      
                                                    {? fou}{@ fou}
                                                    <p class="form-group-tag" id="add_founder_{.key_+1}">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <label class="sr-only"  for=" ">창업자 이름</label>
                                                        <input type="url" class="form-control" name="founder_{.key_+1}" value="{.founder}" placeholder="창업자 이름">
                                                    </p>
                                                    {/}{:}
                                                    <p class="form-group-tag" id="add_founder_1">
                                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                        <label class="sr-only"  for=" ">창업자 이름</label>
                                                        <input type="url" class="form-control" name="founder_1" placeholder="창업자 이름">
                                                    </p>
                                                    {/} 
                                                    <button type="button" class="btn btn-default btn-sm" onclick="add_fou(); return false;"><span class="glyphicon  glyphicon-plus"></span> 다른 창업자  추가</button>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="btn-toolbar">
                                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button type="button" class="btn btn-default">취소</button>
                                                    <button type="submit" class="btn btn-primary" onclick="go_step2(); return false;">확인</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                        <!-- /fieldset -->
                                        
                                    </form>
                                </div>
<!-- /tab-pane2 --> 
                                
                                
                                
<!-- tab-pane3 -->
                                {? service}{@ service}
                                <div class="tab-pane" id="info-service_{.key_+1}">
                                    <form class="form-horizontal" name="step3_{.key_+1}" id="step3" onsubmit="return false;">
                                        <input type="hidden" name="id" value="{.id}" >
                                        <input type="hidden" name="cnt_pic" id="cnt_pic" value="1" >
                                        <!-- fieldset -->
                                        <fieldset  class="well">
                                            <button type="button" class="btn btn-default btn-sm btn-delete" aria-hidden="true" onclick="del_box_s(this, '{.key_}', '{.id}'); return false;">서비스 삭제</button>
                                            <h3>서비스 정보</h3>
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 서비스 이름</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" name="name" value="{.name}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > Elevator pitch</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea  class="form-control" rows="3" name="des_ele" >{.des_ele}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Problem</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea  rows="3" class="form-control" name="des_pro" placeholder="예) 문제에 대해서 얼마나 알고 있는가? (통계, 예시, 연구자료, 링크)">{.des_pro}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Solution</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea  rows="3" class="form-control" name="des_sol" placeholder="예) 문제를 정의하고, 해결하는 방법이 왜 사용자들에게 좋으며, 다른것들과 차별성이 있는 구체적으로 설명하세요">{.des_sol}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                                        
                                            <!-- /form-group-->
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 서비스 이미지 업로드</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10 goods-imgs">
                                                    <ul class="nav nav-tabs">
                                                        <li class="active"><a href="#upImg_{.key_+1}" data-toggle="tab">이미지</a></li>
                                                        <li><a href="#upMov_{.key_+1}" data-toggle="tab">동영상</a></li>
                                                    </ul>
                                                    <div class="tab-content">
                                                        <div class="form-inline tab-pane active" id="upImg_{.key_+1}"> 
                                                            <p class="text-muted">최대4개 이미지까지 가능합니다.</p>
                                                            
                                                            <div class="fomr-group-sub form-inline">
                                                            <div class="form-group"> 
                                                                <input type="hidden" name="img1" id="img1_{.id}" value="{.img1}" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-1">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img1_{.id}/140x140?old={? .img1}{=safe_js(.img1_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            <div class="form-group"> 
                                                                <input type="hidden" name="img2" id="img2_{.id}" value="{.img2}" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-2">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img2_{.id}/140x140?old={? .img2}{=safe_js(.img2_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            <div class="form-group"> 
                                                                <input type="hidden" name="img3" id="img3_{.id}" value="{.img3}" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-3">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img3_{.id}/140x140?old={? .img3}{=safe_js(.img3_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            <div class="form-group"> 
                                                                <input type="hidden" name="img4" id="img4_{.id}" value="{.img4}" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-4">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img4_{.id}/140x140?old={? .img4}{=safe_js(.img4_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                        </div>
                                                        </div>
                                                            
                                                        <div class="tab-pane" id="upMov_{.key_+1}">
                                                            <p class="text-muted">동영상은 Youtube 혹은 Vimeo에 등록된 영상의 주소를 입력해주세요. 4개까지 입력 가능합니다.</p>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie1" value="{?.movie1_type == 1}http://www.youtube.com/watch?v={/}{?.movie1_type == 2}http://vimeo.com/{/}{? .movie1}{.movie1}{/}">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie2" value="{?.movie2_type == 1}http://www.youtube.com/watch?v={/}{?.movie2_type == 2}http://vimeo.com/{/}{? .movie2}{.movie2}{/}">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie3" value="{?.movie3_type == 1}http://www.youtube.com/watch?v={/}{?.movie3_type == 2}http://vimeo.com/{/}{? .movie3}{.movie3}{/}">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie4" value="{?.movie4_type == 1}http://www.youtube.com/watch?v={/}{?.movie4_type == 2}http://vimeo.com/{/}{? .movie4}{.movie4}{/}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /tab-content -->
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >제품-서비스 링크</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-group  form-inline">
                                                        <label for="inputUrlHomepage" class="sr-only">Homepage</label>
                                                        <div class="input-group">                                                            
                                                            <span class="input-group-addon"><span class="icon-fixed-width icon-home"></span></span>
                                                            <input type="url" placeholder="Homepage" name="web_url" id="inputUrlHomepage" class="form-control" value="{.web_url}">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                    <div class="form-group">
                                                        <label for="inputUrlAppStore" class="sr-only">App Store</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width  icon-apple"></span></span>
                                                            <input type="url" placeholder="App Store" name="ios_url" id="inputUrlAppStore" class="form-control" value="{.ios_url}">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                    <div class="form-group">
                                                        <label for="inputGooglePlay" class="sr-only">Google Play</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width  icon-android"></span></span>
                                                            <input type="url" placeholder="Google Play" name="and_url" id="inputGooglePlay" class="form-control" value="{.and_url}">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >런칭일자</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-inline">
                                                        <label class="sr-only" for="inputStartDate">투자일</label>
                                                        <!-- datepicker -->
                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" name="founded" placeholder="" value="{.founded}" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker --> 
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이용자수 / 판매량</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="3" class="form-control" name="sales">{.sales}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Revenue (수익률)</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="3" class="form-control" name="revenue">{.revenue}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >기타</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="3" class="form-control" name="etc">{.etc}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >주요 타겟층</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" name="target" value="{.target}">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >그래프 (이미지)</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <p class="form-control-static">제품 현황을 알려줄수 잇는 그래프 자료를 업로드 하세요.</p>
                                                    
                                                    <ul class="list-unstyled">
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr1" id="gr1_{.id}" value="{.gr1}" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr1_{.id}/80x80?old={? .gr1}{=safe_js(.gr1_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                            
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr1_title" value="{.gr1_title}">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                            <div class="clearfix" />
                                                        </li>
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr2" id="gr2_{.id}" value="{.gr2}" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr2_{.id}/80x80?old={? .gr2}{=safe_js(.gr2_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr2_title" value="{.gr2_title}">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                            <div class="clearfix" />
                                                        </li>
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr3" id="gr3_{.id}" value="{.gr3}" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr3_{.id}/80x80?old={? .gr3}{=safe_js(.gr3_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr3_title" value="{.gr3_title}">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                            <div class="clearfix" />
                                                        </li>
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr4" id="gr4_{.id}" value="{.gr4}" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr4_{.id}/80x80?old={? .gr4}{=safe_js(.gr4_thumb)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr4_title" value="{.gr4_title}">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                            <div class="clearfix" />
                                                        </li>
    
    
                                                        <!--
                                                        <li class="add">
                                                            <button class="btn btn-default btn-xs" onclick="add_graph(); return false;">추가하기</button>
                                                        </li>
                                                        //-->
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >B/M</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                <textarea class="form-control" rows="3" id="inputBuisnessmodel" placeholder="비즈니스 모델을 입력하세요" name="bm">{.bm}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >적용기술</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                <textarea class="form-control" rows="3" id="inputReference" placeholder="적용기술을 입력하세요" name="skill">{.skill}</textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="btn-toolbar">
                                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button type="button" class="btn btn-default">취소</button>
                                                    <button type="submit" class="btn btn-primary" onclick="go_step3('{.key_+1}'); return false;">확인</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                        <!-- /fieldset -->
                                    </form>
                                </div>
                                {/}{:}
                                <div class="tab-pane" id="info-service">
                                    <form class="form-horizontal" name="step3_0" id="step3" onsubmit="return false;">
                                        <input type="hidden" name="id" value="" >
                                        <input type="hidden" name="cnt_pic" id="cnt_pic" value="1" >
                                        <!-- fieldset -->
                                        <fieldset  class="well">
                                            <button type="button" class="btn btn-default btn-sm btn-delete" aria-hidden="true" onclick="del_box(this, '1', '0'); return false;">서비스 삭제</button>
                                            <h3>서비스 정보</h3>
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >제품-서비스 이름</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" name="name">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > Elevator pitch</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" name="des_ele" value="">
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Problem</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea  rows="3" class="form-control" name="des_pro" placeholder="예) 문제에 대해서 얼마나 알고 있는가? (통계, 예시, 연구자료, 링크)"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Solution</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea  rows="3" class="form-control" name="des_sol" placeholder="예) 문제를 정의하고, 해결하는 방법이 왜 사용자들에게 좋으며, 다른것들과 차별성이 있는 구체적으로 설명하세요"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 서비스 이미지 업로드</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10  goods-imgs">
                                                    <ul class="nav nav-tabs">
                                                        <li class="active"><a href="#upImg" data-toggle="tab">이미지</a></li>
                                                        <li><a href="#upMov" data-toggle="tab">동영상</a></li>
                                                    </ul>
                                                    <div class="tab-content">
                                                        <div class="form-inline tab-pane active" id="upImg"> 
                                                            <p class="text-muted">최대4개 이미지까지 가능합니다.</p> 
                                                            
                                                            <div class="fomr-group-sub form-inline">
                                                            <div class="form-group"> 
                                                                <input type="hidden" name="img1" id="img1_0" value="" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-1">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img1_0/140x140?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            <div class="form-group"> 
                                                                <input type="hidden" name="img2" id="img2_0" value="" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-2">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img2_0/140x140?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            <div class="form-group">  
                                                                <input type="hidden" name="img3" id="img3_0" value="" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-3">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img3_0/140x140?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            <div class="form-group">  
                                                                <input type="hidden" name="img4" id="img4_0" value="" />
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">&times;</button>
                                                                <label for="inputFileImg-4">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img4_0/140x140?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
    
                                                            </div>
                                                        </div>
                                                            
                                                        <div class="tab-pane" id="upMov">
                                                            <p  class="text-muted">동영상은 Youtube 혹은 Vimeo에 등록된 영상의 주소를 입력해주세요. 4개까지 입력 가능합니다.</p>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie1" value="">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie2" value="">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie3" value="">
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="input-group"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-youtube-play"></span></span>
                                                                    <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie4" value="">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--/tab-content -->
                                                 </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >제품-서비스 링크</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-group  form-inline">
                                                        <label for="inputUrlHomepage" class="sr-only">Homepage</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width   icon-home"></span></span>
                                                            <input type="url" placeholder="Homepage" name="web_url" id="inputUrlHomepage" class="form-control">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                    <div class="form-group">
                                                        <label for="inputUrlAppStore" class="sr-only">App Store</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width   icon-apple"></span></span>
                                                            <input type="url" placeholder="App Store" name="ios_url" id="inputUrlAppStore" class="form-control">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                    <div class="form-group">
                                                        <label for="inputGooglePlay" class="sr-only">Google Play</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width   icon-android"></span></span>
                                                            <input type="url" placeholder="Google Play" name="and_url" id="inputGooglePlay" class="form-control">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >런칭일자</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div class="form-inline">
                                                        <label class="sr-only" for="inputStartDate">투자일</label>
                                                        <!-- datepicker -->
                                                        <div class="bfh-datepicker" data-format="y.m.d">
                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                <input type="text" class="form-control datepicker" name="founded" placeholder="" readonly>
                                                            </div>
                                                        </div>
                                                        <!-- /datepicker --> 
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이용자수 / 판매량</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="3" class="form-control" name="sales"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Revenue (수익률)</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="3" class="form-control" name="revenue"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >기타</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="3" class="form-control" name="etc"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >주요 타겟층</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" class="form-control" name="target" >
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >그래프 (이미지)</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <p class="form-control-static">제품 현황을 알려줄수 잇는 그래프 자료를 업로드 하세요.</p>
                                                    
                                                    <ul class="list-unstyled">
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr1" id="gr1_0" value="" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr1_0/80x80?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr1_title" value="">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                        </li>
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr2" id="gr2_0" value="" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr2_0/80x80?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr2_title" value="">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                        </li>
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr3" id="gr3_0" value="" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr3_0/80x80?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr3_title" value="">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                        </li>
                                                        <li class="form-group-file">
                                                            <input type="hidden" name="gr4" id="gr4_0" value="" />
                                                            <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr4_0/80x80?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr4_title" value="">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                &times;
                                                                </button>
                                                                </span> 
                                                            </div>
                                                            <div class="clearfix" />
                                                        </li>
                                                        <!--
                                                        <li class="add">
                                                            <button class="btn btn-default btn-xs" onclick="add_graph(); return false;">추가하기</button>
                                                        </li>
                                                        //-->
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >B/M</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea class="form-control" rows="3" id="inputBuisnessmodel" placeholder="비즈니스 모델을 입력하세요" name="bm"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >적용기술</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea class="form-control" rows="3" id="inputReference" placeholder="적용기술을 입력하세요" name="skill"></textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="btn-toolbar">
                                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button type="button" class="btn btn-default">취소</button>
                                                    <button type="submit" class="btn btn-primary" onclick="go_step3('0'); return false;">확인</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                        <!-- /fieldset -->
                                    </form>
                                </div>
                                {/}
<!-- /tab-pane3 --> 
                                
                            </div>
                            <!-- /tab-content --> 
                            
                        </div>
                        <!-- /panel-body --> 
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section -->
            </div>
            <!-- /contentwrap --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
{? job}
$( ".suggest_job" ).autocomplete({source: {job}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}
    
{? skill}
$( ".suggest_skill" ).autocomplete({source: {skill}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}

function del_box(_this)
{
    $(_this).parent().remove();
}

function add_sk(_this)
{   
    var v = $("#cnt_sk").val();
    var get_url = "/ajax_front/member_add_s/1";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_sk").val(parseInt(v)+1);
        {? skill}
        $( ".suggest_skill" ).autocomplete({source: {skill}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

function add_int(_this)
{   
    var v = $("#cnt_int").val();
    var get_url = "/ajax_front/member_add_i/1";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_int").val(parseInt(v)+1);
        {? job}
        $( ".suggest_job" ).autocomplete({source: {job}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

function go_step1()
{
    if ($('#inputCompanyName').val().length < 1) {
        alert("회사명을 입력주세요.");
        return false;
    }
    var frm = $('form[name=step1]');
    var _id = $('#sid').val();
    var temp = '<input type="hidden" name="id" value="'+_id+'" />';
    frm.append(temp);

    var get_url = '/ajax/startup_add_step1';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            $('#sid').val(_data.id);
            alert("저장되었습니다.");
        }
    });
}

function del_this1(_this) {
    $(_this).prev().val('');
    var _id = $(_this).prev().attr('id');
    var _val = '<iframe width="140px" scrolling="no" height="140px" frameborder="0" allowtransparency="true" src="/ajax/photo_form_file/'+_id+'/140x140?old=/img/default-img-pic.png" style="overflow: hidden; border: 0pt none; clear: both;" id="photo_uploader"></iframe>';
    $(_this).next().html(_val);
}
function del_this3(_this) {
    {*$(_this).parent().parent().parent().remove();*}
    var _id = $(_this).parent().parent().prev().prev().attr('id');
    var _val = '<iframe width="80px" scrolling="no" height="80px" frameborder="0" allowtransparency="true" src="/ajax/photo_form_file/'+_id+'/80x80?old=/img/default-img-pic.png" style="overflow: hidden; border: 0pt none; clear: both;" id="photo_uploader" class="pull-left"></iframe>';
    $('#'+_id).val('');
    $(_this).parent().prev().val('');
    $(_this).parent().parent().prev().remove();
    $(_this).parent().parent().before(_val);
}

function go_step2()
{
    var frm = $('form[name=step2]');
    var _id = $('#sid').val();
    if (_id === "") {
        alert("기본 기업정보를 저장해주세요.");
        return false;
    }

    var temp = '<input type="hidden" name="id" value="'+_id+'" />';
    frm.append(temp);

    var get_url = '/ajax/startup_add_step2';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function() {

            alert("저장되었습니다.");
        }
    });
}

function go_step3(_id)
{
    var frm = $('form[name=step3_'+_id+']');
    var _sid = $('#sid').val();
    if (_sid === "") {
        alert("기본 기업정보를 저장해주세요.");
        return false;
    }
    var temp = '<input type="hidden" name="startup_id" value="'+_sid+'" />';
    frm.append(temp);

    var get_url = '/ajax/startup_add_step3';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function() {

            alert("저장되었습니다.");
        }
    });
}

function add_ref(_this)
{
    var v = $("#cnt_ref").val();
    var get_url = "/ajax/startup_add_reference";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_ref").val(parseInt(v)+1);
    });
}

function add_inv(_this)
{
    var v = $("#cnt_inv").val();
    var get_url = "/ajax/startup_add_investment";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_inv").val(parseInt(v)+1);
    });
}

function add_inc(_this)
{
    var v = $("#cnt_inc").val();
    var get_url = "/ajax/startup_add_incubate";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_inc").val(parseInt(v)+1);
    });
}

function add_fou()
{   
    var v = $("#cnt_fou").val();
    var get_url = "/ajax/startup_add_founder";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $('#add_founder_'+v).after(_data);
        $("#cnt_fou").val(parseInt(v)+1);
    });
}

function add_pic()
{   
    var v = $("#cnt_pic").val();
    var v2 = parseInt(v)+1;
    var data = $('#add_pic').html();
    data = '<div id="add_pic_'+v2+'" class="well well-sm">'+ data +'</div>';
    $('#add_pic').before(data);
    $('#add_pic_'+v2+' input').attr("name", "pic_"+v2);
    $("#cnt_pic").val(v2);
}

function add_service(_this)
{
    var v = $("#cnt_se").val();
    var v2 = parseInt(v)+1;
    var get_url = "/ajax/startup_add_service";
    var set_data ={
        "data": v2,
    };
    
    $.post(get_url, set_data,function(_data) {
        $("#cnt_se").val(parseInt(v)+1);
        $('#companyTab li').removeClass('active');
        $('#companyContent div').removeClass('active');
        $('#companyContent').append(_data);
        $(_this).parent().before('<li class="active"><a href="#info-service_'+v2+'" data-toggle="tab">  서비스 정보</a></li>');
        
    });
}

function del_box(_this)
{
    $(_this).parent().remove();
}

function del_box_s(_this, _id, _sid)
{
    if (_sid !== "0") {
        if (confirm("해당 서비스를 삭제할까요?")){    //확인
            var get_url = "/ajax/startup_del_service/"+_sid;
                $.post(get_url,function() {
            });
        }else{   //취소
                return;
        }
        
    }
{*    $(_this).parent().parent().parent().remove();*}
    $('#companyTab .active').remove();
    $('#companyTab li').last().prev().addClass("active");
    $('.tab-pane').last().addClass("active");
}

//]]>
</script>