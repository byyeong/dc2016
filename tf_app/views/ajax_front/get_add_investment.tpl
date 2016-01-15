<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title"><span class="icon-building"></span> <span class="break"></span> 창업유관기관 등록하기</h3>
            </div>
            <!-- /modal-header -->
            <div class="modal-body">
                <form class="form-horizontal" role="form" name="add_inv_form" >
                    <input type="hidden" name="stype" value="2" />
                    <input type="hidden" name="user_id" value="{s.id}" />
                    <input type="hidden" id="form_inv" name="form_inv" value="{form}" />
                    <fieldset>
                        <div class="form-group">
                            <div  class="col-lg-3 control-label">회사/조직명</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="회사/조직명" id="md-invEditor_com" name="name" value="{data}">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div  class="col-lg-3 control-label">한 줄 설명</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="한 줄 설명" name="bio">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">로고</div>
                            <div class="col-lg-9">
                                <input type="hidden" name="img" id="img" value="">
                                <!--<iframe width="100%" scrolling="no" height="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img/160x160?old=" allowtransparency="true"></iframe>//-->
                                <img class="img-thumbnail" src="/img/default-img-company.png" id="img_img" onclick="toggle_img();return false;">
                                <div id="div_img_change" style="display: none;">
                                    <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img" ></iframe>
                                </div>
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-lg-3 control-label"> 설립일 </div>
                            <div class="col-lg-9"> 
                                <input type="text" class="form-control" name="founded" placeholder="2013.10.01">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-3 control-label">임직원수</div>
                            <div class="col-lg-9">
                                <div class="input-group"> <span class="input-group-addon"><span class="icon-group"></span></span>
                                    <input type="number" class="form-control" name="number">
                                    <span class="input-group-addon">명</span> </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">투자분야</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="bussiness" >
                                <span class="help-block">콤마(,)를 사용해서 구분해주세요</span> </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">투자전략</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="tech" >
                                <span class="help-block">콤마(,)를 사용해서 구분해주세요</span> </div>
                        </div>
                        <!-- /form-group -->
                        
                        <!--
                        <div class="form-group">
                            <div class="col-lg-3 control-label">웹사이트</div>
                            <div class="col-lg-9">
                                <input type="url" class="form-control" value="http://" name="website">
                                <div class="alert alert-dismissable web_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 웹사이트의 형식이 맞지 않습니다.</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">블로그</div>
                            <div class="col-lg-9">
                                <input type="url" class="form-control" value="http://" name="blog">
                                <div class="alert alert-dismissable blog_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 블로그의 형식이 맞지 않습니다.</p>
                                </div>
                            </div>
                        </div>

                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">SNS</div>
                            <div class="col-lg-9">
                                <p class="input-group"> <span class="input-group-addon"><span class="icon-twitter"></span> &nbsp;  Twitter</span>
                                    <input type="text" placeholder="twitter url" class="form-control" name="twitter" >
                                </p>
                                <p class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span> &nbsp;  Facebook</span>
                                    <input type="text" placeholder="facebook url" class="form-control" name="facebook">
                                </p>
                            </div>
                        </div>
                        //-->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">메일주소</div>
                            <div class="col-lg-9">
                                <input type="email" class="form-control" placeholder="" name="email">
                                <!-- alert -->
                                <div class="alert alert-dismissable email_err" style="display: none;">
                                    <p class="text-danger"><strong>Oops!</strong> 이메일의 형식이 맞지 않습니다. </p>
                                </div>
                                <!-- /alert -->
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">주소</div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" placeholder="" name="addr">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-lg-3 control-label">연락처</div>
                            <div class="col-lg-9">
                                <input type="tel" class="form-control" placeholder="" name="tel">
                            </div>
                        </div>
                        <!-- /form-group -->
                    </fieldset>
                </form>
            </div>
            <!-- /modal-body -->

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="st_submit(this); return false;">확인</button>
            </div>
            <!-- /modal-footer --> 
        </div>
        <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 