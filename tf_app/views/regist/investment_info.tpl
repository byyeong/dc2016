<!-- content -->
<div id="regist-startup" class="content"> 
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2"> 
    
            <!-- header -->
            <div class="header">
                <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>창업유관기관</small></1>
            </div>
            <!-- /header --> 
     
            <!-- panel -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h2><span class="icon-building"></span> 창업유관기관 등록하기</h2>
                </div> 
                <form class="form-horizontal" role="form" name="regist_st" action="/regist/investment_entered" method="post">
                    <input type="hidden" name="stype" value="2" />
                    <fieldset>
                        <div class="panel-body">
                        
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">회사/조직명</div>
                                <div class="col-sm-8 col-md-9">  
                                    <input type="text" class="form-control" placeholder="회사/조직명" name="name" value="{name}" > 
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">한 줄 설명</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="text" class="form-control" placeholder="" name="bio">
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">로고</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="hidden" name="img" id="img" value="" />
                                    <iframe scrolling="no" height="160px" width="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old=" allowtransparency="true"></iframe>
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label"> 설립일 </div>
                                <div class="col-sm-8 col-md-9">
                                    <!-- datepicker -->
                                    <div class="bfh-datepicker" data-format="y.m.d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" id="inputStartDate" name="founded" >
                                        </div>
                                    </div>
                                    <!-- /datepicker --> 
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">임직원수</div>
                                <div class="col-sm-8 col-md-9">
                                    <div class="input-group"> 
                                        <span class="input-group-addon"><span class="icon-group"></span></span>
                                        <input type="number" class="form-control" name="number">
                                        <span class="input-group-addon">명</span>
                                    </div>
                                    <!-- /input-group -->
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">투자분야</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="text" class="form-control" name="bussiness">
                                    <span class="help-block">콤마(,)를 사용해서 구분해주세요</span>
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">투자전략</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="text" class="form-control" name="tech">
                                    <span class="help-block">콤마(,)를 사용해서 구분해주세요</span>
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">웹사이트</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="url" class="form-control" value="http://" name="website">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">블로그</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="url" class="form-control" value="http://" name="blog">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">SNS</div>
                                <div class="col-sm-8 col-md-9">
                                    <p class="input-group"> <span class="input-group-addon"><span class="icon-twitter"></span>  &nbsp;  Twitter</span>
                                        <input type="text" placeholder="mytwitterID" class="form-control" name="twitter">
                                    </p>
                                    <!-- /input-group -->
                                    <p class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span> &nbsp;  Facebook</span>
                                        <input type="text" placeholder="myfacebookID" class="form-control" name="facebook">
                                    </p>
                                     <!-- /input-group -->
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">메일주소</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="email" class="form-control" placeholder="" name="email">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">주소</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="text" class="form-control" placeholder="" name="addr">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-md-3 control-label">연락처</div>
                                <div class="col-sm-8 col-md-9">
                                    <input type="tel" class="form-control" placeholder="" name="tel">
                                </div> 
                            </div>
                            <!-- /form-group --> 
                            
                        </div>
                        <!-- /panel-body -->
                        
                        <div class="panel-footer">
                            <div class="col-sm-offset-4 col-md-offset-3">
                                <a href="javascript:window.location.reload();" class="btn btn-default" >취소</a>
                                <a href="#" class="btn btn-primary" onclick="submit_st(); return false;">확인</a>
                            </div>
                        </div>
                        <!-- /panel-footer -->
                    </fieldset>
                </form>
            </div>
            <!-- /panel --> 
            
             
        </div>
    </div> 
</div>
<!-- /content-->

<script type="text/javascript">
//<![CDAT

function submit_st(){
    if ($('input[name=name]').val().length < 1) {
        alert("회사/조직명을 입력해주세요.");
        return false;
    }
    document.regist_st.submit();
}

//]]>
</script> 