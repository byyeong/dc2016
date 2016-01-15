            
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    
                    <!-- panel #pane-main-listset -->
                    <div id="pane-main-listset" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span> 배너 관리 <small> 배너 사이즈는 1280x270 입니다.</small></h2> 
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" method="post" action="/admin_main/banner">
                            <input type="hidden" name="sid" value="{s.id}" />
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="type" value="1" />
                            <!-- panel-body -->
                            <div class="panel-body">  
                                <fieldset>
                                    <legend>슬라이드 배너 관리</legend> 
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >배너</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                <label for="inputBanner">
                                                    <input type="hidden" name="pic_1" id="pic_1" value="">
                                                    <iframe width="100%" scrolling="no" height="270px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic_1/1280x270?old={=safe_js(res.pic_1)}" allowtransparency="true"></iframe>
                                                </label> 
                                                
                                             <p class="form-inline">  
                                                <input type="text" class="form-control" name="url_1" value="{res.url_1}" placeholder="http:// URL을 입력하세요" >  
                                                 
                                                <select class="selectpicker" data-width="auto" name="target_1">
                                                    <option value="_self" {? res.target_1 == '_self'}selected="selected"{/}>내부링크 (_self)</option>
                                                    <option value="_blank" {? res.target_1 == '_blank'}selected="selected"{/}>새창링크 (_blank)</option>
                                                </select> 
                                             </p>
                                             <div>
                                                <input type="text" class="form-control" name="des_1" value="{res.des_1}" placeholder="title" >
                                                <input type="text" class="form-control" name="des_2" value="{res.des_2}" placeholder="middle" >
                                                <input type="text" class="form-control" name="des_3" value="{res.des_3}" placeholder="링크 타이틀" >
                                            </div>
                                             <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <!--div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >배너 2</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label for="inputBanner">
                                                <input type="hidden" name="pic_2" id="pic_2" value="">
                                                <iframe width="100%" scrolling="no" height="310px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic_2/750x310?old={=safe_js(res.pic_2)}" allowtransparency="true"></iframe>
                                            </label>
                                            <p class="form-inline">  
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" id="act_2" value="1" name="act_2" {? res.active_2}checked="checked"{/}>보임
                                                </label>

                                                <input type="text" class="form-control" name="url_2" value="{res.url_2}" placeholder="http:// URL을 입력하세요" >
                                             
                                                <select class="selectpicker" data-width="auto" name="target_2">
                                                    <option value="_self" {? res.target_2 == '_self'}selected="selected"{/}>내부링크 (_self)</option>
                                                    <option value="_blank" {? res.target_2 == '_blank'}selected="selected"{/}>새창링크 (_blank)</option>
                                                </select> 
                                             </p>
                                             <div><input type="text" class="form-control" name="des_2" value="{res.des_2}" placeholder="설명을 입력하세요" ></div>
                                              
                                        </div>
                                    </div>
                                    
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >배너 3</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                             <label for="inputBanner">
                                                <input type="hidden" name="pic_3" id="pic_3" value="">
                                                <iframe width="100%" scrolling="no" height="310px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic_3/750x310?old={=safe_js(res.pic_3)}" allowtransparency="true"></iframe> 
                                            </label>
                                            <p class="form-inline">  
                                                <label class="checkbox-inline">
                                                    <input type="checkbox" id="act_3" value="1" name="act_3" {? res.active_3}checked="checked"{/}>보임
                                                </label>

                                                <input type="text" class="form-control" name="url_3" value="{res.url_3}" placeholder="http:// URL을 입력하세요" >
                                             
                                                <select class="selectpicker" data-width="auto" name="target_3">
                                                    <option value="_self" {? res.target_3 == '_self'}selected="selected"{/}>내부링크 (_self)</option>
                                                    <option value="_blank" {? res.target_3 == '_blank'}selected="selected"{/}>새창링크 (_blank)</option>
                                                </select>                                         
                                             </p>
                                             <div><input type="text" class="form-control" name="des_3" value="{res.des_3}" placeholder="설명을 입력하세요" ></div>
                                             
                                        </div>
                                    </div-->
                                   
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