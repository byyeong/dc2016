<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>                                
                                <div class="tab-pane active" id="info-service_{v}">
                                    <form class="form-horizontal" name="step3_{v}" id="step3" onsubmit="return false;">
                                        <!-- fieldset -->
                                        <fieldset  class="well">
                                            <button type="button" class="btn btn-default btn-sm btn-delete" aria-hidden="true" onclick="del_box_s(this, '{v}', '0'); return false;">서비스 삭제</button>
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
                                                    <textarea  class="form-control" rows="3"  name="des_ele" value=""></textarea>
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
                                            
                                            <!-- /form-group-->
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" > 서비스 이미지 업로드</div>
                                                <div class="col-lg-9  goods-imgs">
                                                    <ul class="nav nav-tabs">
                                                        <li class="active"><a href="#upImg_{v}" data-toggle="tab">이미지</a></li>
                                                        <li><a href="#upMov_{v}" data-toggle="tab">동영상</a></li>
                                                    </ul>
                                                    <div class="tab-content">
                                                        <div class="form-inline tab-pane active" id="upImg_{v}"> 
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
                                                                <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">×</button>
                                                                <label for="inputFileImg-4">
                                                                    <iframe scrolling="no" height="140px" width="140px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img4_0/140x140?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        </div>
                                                            
                                                        <div class="tab-pane" id="upMov_{v}">
                                                            <p class="text-muted">동영상은 Youtube 혹은 Vimeo에 등록된 영상의 주소를 입력해주세요. 4개까지 입력 가능합니다.</p>
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
                                                    <!-- /tab-content -->
                                                </div>
                                            </div>
                                            <!-- /form-group-->
                                            
                                            <div class="form-group"> 
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label" >제품-서비스 링크</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                
                                                    <div class="form-group">
                                                        <label for="inputUrlHomepage" class="sr-only">Homepage</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width icon-home"></span></span>
                                                            <input type="url" placeholder="Homepage" name="web_url" id="inputUrlHomepage" class="form-control">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                    <div class="form-group">                                                        
                                                        <label for="inputUrlAppStore" class="sr-only">App Store</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width icon-apple"></span></span>
                                                            <input type="url" placeholder="App Store" name="ios_url" id="inputUrlAppStore" class="form-control">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group-->
                                                    <div class="form-group">                                                        
                                                        <label for="inputGooglePlay" class="sr-only">Google Play</label>
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="icon-fixed-width icon-android"></span></span>
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
                                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
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
                                                <div class="col-lg-offset-3">
                                                    <button type="button" class="btn btn-default">취소</button>
                                                    <button type="submit" class="btn btn-primary" onclick="go_step3('{v}'); return false;">확인</button>
                                                </div>
                                            </div>
                                        </fieldset>
                                        <!-- /fieldset -->
                                    </form>
                                </div>