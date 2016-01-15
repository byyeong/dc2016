<!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>카테고리 설정하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="카테고리 목록" data-toggle="tooltip" href="/admin_contents/category"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" action="/admin_contents/category_info/{res.id}" method="post">
                            <input type="hidden" name="id" value="{res.id}" />
                            <div class="panel-body">
                                <fieldset>
                                    <legend>카테고리 정보입력</legend>
                                    
                                     <div class="alert alert-info alert-dismissable">
                                        <!--<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>//-->
                                        <strong>참고하세요.</strong> 카테고리를 추가하면, 해당 카테고리에 필자를 등록할 수 있습니다. 
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">카테고리명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text"  class="form-control" name="name" value="{res.name}">
                                        </div>
                                    </div>  
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">카테고리 설명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <textarea class="form-control" rows="3" name="des">{res.des}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">카테고리 이미지</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="hidden" name="pic" id="pic" value="" />
                                            <p class="form-control-static">카테고리 이미지는 750X260 이상의 파일을 업로드 해주세요</p>
                                            <label for="inputBanner"><img class="img-thumbnail" src="{? res.picture}{res.picture}{:}/img/test.png{/}" id="pic_img" onclick="toggle_img();return false;"></label>
                                            <div id="div_img_change" style="display: none;">
                                                <iframe  height="1100" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?sub_dir={=substr(res.picture, 1)}&which=pic&r_width=750&r_height=260" ></iframe>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">노출 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="radio-inline">
                                                <input type="radio" {? !res.hidden}checked="checked"{/} name="hidden" value="0">
                                                보임
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" {? res.hidden}checked="checked"{/} name="hidden" value="1">
                                                숨김
                                            </label>
                                        </div>
                                    </div>
                                    
                                    
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary">저장</button>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 