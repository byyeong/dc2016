            
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    
                    <!-- panel #pane-main-listset -->
                    <div id="pane-main-listset" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span> 키비주얼 관리 <small> 사이즈는 670x182 이상입니다.</small></h2> 
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" method="post" action="/admin_contents/edit_pic">
                            <input type="hidden" name="sid" value="{s.id}" />
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="type" value="7" />
                            <!-- panel-body -->
                            <div class="panel-body">  
                                <fieldset>
                                    <legend>슬라이드 배너 관리</legend> 
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >키비주얼</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <label for="inputBanner">
                                                <input type="hidden" name="pic_1" id="pic_1" value="">
                                                <iframe width="100%" scrolling="no" height="182px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic_1/670x182?old={=safe_js(res.pic_1)}" allowtransparency="true"></iframe>
                                            </label> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Title</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" name="des_1" value="{res.des_1}" placeholder="title을 입력해주세요." >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <!-- /form-group -->
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >Sub Title</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" name="des_2" value="{res.des_2}" placeholder="sub title을 입력해주세요." >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <!-- /form-group -->
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >목록에서 노출</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" value="1" name="act_1" {? res.active_1}checked="checked"{/}> 공개
                                            </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- pane-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default" onclick="javascript:location.href='/admin_main/banner'">취소</button>
                                    <button type="submit" class="btn btn-primary">확인</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel #pane-main-listset --> 
                    
                    
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            <!-- /End Page Cotents --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

//]]>
</script>