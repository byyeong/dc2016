
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-event-edit -->
                    <div id="pane-event-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> 책 정보입력</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" action="/admin_event/book_add/{res.id}" method="post" name="add_book_f" onsubmit="return false;">
                            <input type="hidden" name="id" value="{res.id}" />
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>책 정보입력</legend>
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이벤트 일자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                             
                                             
                                             <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="dates" value="{res.dates}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 
                                              
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}12:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" id="end_3" name="end" value="{res.end}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 

 
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이벤트 페이지 URL</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="url" value="{res.url}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >책 표지</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="hidden" name="pic2" id="pic2" value="{res.img}">
                                            <!--<iframe width="100%" scrolling="no" height="300px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic/300x300?old={=safe_js(res.picture)}" allowtransparency="true"></iframe>//-->
                                            <img class="img-thumbnail" src="{?res.img}{res.img}?{=date('his')}{:}/img/common/148x221.png{/}" id="pic2_img" onclick="toggle_img();return false;">
                                            <div id="div_img_change" style="display: none;">
                                                <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic2&r_width=148&r_height=221" ></iframe>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >책 제목</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="title" value="{res.title}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >소 제목</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="subtitle" value="{res.subtitle}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >저자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="author" value="{res.author}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >출판사</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="publisher" value="{res.publisher}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >편찬일</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                             <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="c_date" value="{res.c_date}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >관련 분야</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="tags" value="{res.tags}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >멘토 프로필</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="hidden" name="pic" id="pic" value="{res.mento_img}">
                                            <iframe width="100%" scrolling="no" height="64px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic/64x64?old={=safe_js(res.mento_img)}" allowtransparency="true"></iframe>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >멘토 정보 : 직책/이름</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="mento_name" value="{res.mento_name}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >추천사</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <textarea  rows="10" class="form-control" id="inputDesc" name="mento_endor" >{res.mento_endor}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            <!-- panel-footer-->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <a type="button" class="btn btn-default" href="/admin_event/book_add/{res.id}?del=yes">삭제</a>
                                    <button type="submit" class="btn btn-primary" onclick="document.add_book_f.submit();">저장</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer-->
                        </form>
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

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

//]]>
</script>