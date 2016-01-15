<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>

                                        <div class="goodset">   
                                            <form class="form-edit-set" name="service_form_{res.id}" onsubmit="return false;" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="id" value="{res.id}" />
                                                <input type="hidden" name="startup_id" value="{res.startup_id}" />
                                                <fieldset>      
                                                    <button type="button" class="close" aria-hidden="true" data-toggle="tooltip" title="닫기" onclick="edit_toggle(this); return false;">&times;</button>
                                                    <div class="edit-set goods-info">
                                                        <div class="form-group">
                                                            <span class="sr-only">제품 이름</span>
                                                            <input type="text" class="form-control input-sm" placeholder="제품 이름"  name="name" value="{res.name}">
                                                            </input>
                                                        </div>
                                                        <!-- /form-group -->

                                                        <div class="form-group form-group-date">
                                                            <span class="sr-only" for="inputLaunchDate">런칭일자</span>
                                                            <!-- datepicker -->
                                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                                <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                    <input type="text" class="form-control datepicker" placeholder="런칭일자" name="founded" value="{res.founded}" readonly>
                                                                </div>
                                                            </div>
                                                            <!-- /datepicker --> 
                                                        </div>
                                                        <!-- /form-group-date --> 
                                                    </div>
                                                    
                                                    <!-- goods-desc -->
                                                    <div class="edit-set goods-desc">
                                                        <h4>제품설명</h4>
                                                        <div class="formwrap">
                                                            <div class="form-group"> 
                                                                <span class="control-label">Elevator pitch</span>
                                                                <input type="text" class="form-control input-sm" placeholder="제품/서비스를 한 줄로 명확하게 설명해 주세요" name="des_ele" value="{res.des_ele}">
                                                            </div>
                                                            <!-- /form-group -->

                                                            <div class="form-group"> 
                                                                <span class="control-label">Problem</span>
                                                                <textarea class="form-control input-sm" placeholder="사업을 통해 해결하고자 하는 문제는 무엇이며, 왜 해결하고자 하시나요?" name="des_pro">{res.des_pro}</textarea>
                                                            </div>
                                                            <!-- /form-group -->

                                                            <div class="form-group"> 
                                                                <span class="control-label">Solution</span>
                                                                <textarea class="form-control input-sm" placeholder="앞서 말씀하신 문제를 어떠한 제품/서비스로 해결하고자 하시나요?" name="des_sol">{res.des_sol}</textarea>
                                                            </div>
                                                            <!-- /form-group --> 
                                                        </div>
                                                    </div>
                                                    <!-- /goods-desc -->
                                                    
                                                    <!-- goods-imgs -->
                                                    <div class="edit-set goods-imgs">
                                                        <h4>제품 이미지</h4>

                                                        <!-- tab -->
                                                        <ul class="nav nav-tabs">
                                                            <li class="active"><a href="#upImg_{res.id}" data-toggle="tab">이미지</a></li>
                                                            <li><a href="#upMov_{res.id}" data-toggle="tab">동영상</a></li>
                                                        </ul>
                                                        <div class="tab-content">
                                                            <div class="tab-pane active" id="upImg_{res.id}">
                                                                <p>이미지는 4개까지 업로드 가능합니다</p>
                                      
                                                                <ul class="list-inline">
                                                                    <li class="col-md-3">
                                                                        <input type="hidden" name="img1" id="img1_{res.id}" value="{res.img1}" />
                                                                        <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">×</button>
                                                                        <label for="inputFileImg-1">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img1_{res.id}/150x150?old={? res.img1}{=safe_js(res.img1)}{:}{=safe_js('/images/img-default.png')}{/}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                    <li class="col-md-3">
                                                                        <input type="hidden" name="img2" id="img2_{res.id}" value="{res.img2}" />
                                                                        <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">×</button>
                                                                        <label for="inputFileImg-2">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img2_{res.id}/150x150?old={? res.img2}{=safe_js(res.img2)}{:}{=safe_js('/images/img-default.png')}{/}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                    <li class="col-md-3">
                                                                        <input type="hidden" name="img3" id="img3_{res.id}" value="{res.img3}" />
                                                                        <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">×</button>
                                                                        <label for="inputFileImg-3">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img3_{res.id}/150x150?old={? res.img3}{=safe_js(res.img3)}{:}{=safe_js('/images/img-default.png')}{/}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                    <li class="col-md-3">
                                                                        <input type="hidden" name="img4" id="img4_{res.id}" value="{res.img4}" />
                                                                        <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="삭제" onclick="del_this1(this); return false;">×</button>
                                                                        <label for="inputFileImg-4">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img4_{res.id}/150x150?old={? res.img4}{=safe_js(res.img4)}{:}{=safe_js('/images/img-default.png')}{/}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                </ul>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <!-- /tap-pane -->
                                                            <div class="tab-pane" id="upMov_{res.id}">
                                                                <p>동영상은 Youtube 혹은 Vimeo에 등록된 영상의 주소를 입력해주세요. 4개까지 입력 가능합니다.</p>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie1" value="{?res.movie1_type == 1}http://www.youtube.com/watch?v={/}{?res.movie1_type == 2}http://vimeo.com/{/}{? res.movie1}{res.movie1}{/}">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie2" value="{?res.movie2_type == 1}http://www.youtube.com/watch?v={/}{?res.movie2_type == 2}http://vimeo.com/{/}{? res.movie2}{res.movie2}{/}">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie3" value="{?res.movie3_type == 1}http://www.youtube.com/watch?v={/}{?res.movie3_type == 2}http://vimeo.com/{/}{? res.movie3}{res.movie3}{/}">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie4" value="{?res.movie4_type == 1}http://www.youtube.com/watch?v={/}{?res.movie4_type == 2}http://vimeo.com/{/}{? res.movie4}{res.movie4}{/}">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- /tap-pane --> 
                                                        </div>
                                                        <!-- /tab --> 

                                                    </div>
                                                    <!-- /goods-imgs -->
                                                    
                                                    <!-- goods-links -->
                                                    <div class="edit-set goods-links ">
                                                        <h4>제품링크</h4>
                                                        <div class="formwrap">
                                                            <div class="form-group"> 
                                                                <span class="sr-only control-label">Homepage</span>
                                                                <div class="input-group input-group-sm"> 
                                                                    <span class="input-group-addon"><span class="fa fa-fw fa-home"></span></span>
                                                                    <input type="url" class="form-control" id="inputUrlHomepage" placeholder="http://Homepage" name="web_url" value="{res.web_url}">
                                                                </div>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="sr-only control-label">App Store</span>
                                                                <div class="input-group input-group-sm"> 
                                                                    <span class="input-group-addon"><span class="fa fa-fw fa-apple"></span></span>
                                                                    <input type="url" class="form-control" id="inputUrlAppStore" placeholder="http://AppStor" name="ios_url" value="{res.ios_url}">
                                                                </div>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="sr-only control-label">Google Play</span>
                                                                <div class="input-group input-group-sm"> 
                                                                    <span class="input-group-addon"><span class="fa fa-fw fa-android"></span></span>
                                                                    <input type="url" class="form-control" id="inputUrlGooglePlay" placeholder="http://GooglePlay" name="and_url" value="{res.and_url}">
                                                                </div>
                                                            </div>
                                                            <!-- /form-group--> 
                                                        </div>
                                                    </div>
                                                    <!-- /goods-links -->
                                                    
                                                    <!--  goods-condition -->
                                                    <div class="edit-set goods-condition">
                                                        <h4>제품 현황<small>( 투자자 및 유관기관에만 보여지는 정보입니다.)</small></h4>
                                                        <button class="btn btn-default btn-xs" data-toggle="collapse" data-target=".collapse-editCondition_{res.id}">입력하기</button>

                                                        <div class="formwrap collapse collapse collapse-editCondition_{res.id}">
                                                            <div class="form-group"> 
                                                                <span class="control-label">이용자수/판매량</span>
                                                                <textarea class="form-control input-sm" rows="3"  placeholder="" name="sales">{res.sales}</textarea>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">수익률</span>
                                                                <textarea class="form-control input-sm" rows="3"  placeholder="" name="revenue">{res.revenue}</textarea>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">기타</span>
                                                                <textarea class="form-control input-sm" rows="3" placeholder="" name="etc">{res.etc}</textarea>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">주요 타겟층</span>
                                                                <input type="text" class="form-control input-sm" name="target" value="{res.target}">
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">그래프 (이미지)</span>
                                                                <p class="help-block">제품 현황을 알려줄수 잇는 그래프 자료를 업로드 하세요.</p>
                                                                <ul class="list-unstyled">
                                                                    <li class="form-group-file">
                                                                        <input type="hidden" name="gr1" id="gr1_{res.id}" value="{res.gr1}" />
                                                                        <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr1_{res.id}/80x80?old={? res.gr1}{=safe_js(res.gr1)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr1_title" value="{res.gr1_title}">
                                                                            <span class="input-group-btn">
                                                                                <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                            &times;
                                                                            </button>
                                                                            </span> 
                                                                        </div>
                                                                    </li>
                                                                    <li class="form-group-file">
                                                                        <input type="hidden" name="gr2" id="gr2_{res.id}" value="{res.gr2}" />
                                                                        <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr2_{res.id}/80x80?old={? res.gr2}{=safe_js(res.gr2)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr2_title" value="{res.gr2_title}">
                                                                            <span class="input-group-btn">
                                                                                <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                            &times;
                                                                            </button>
                                                                            </span> 
                                                                        </div>
                                                                    </li>
                                                                    <li class="form-group-file">
                                                                        <input type="hidden" name="gr3" id="gr3_{res.id}" value="{res.gr3}" />
                                                                        <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr3_{res.id}/80x80?old={? res.gr3}{=safe_js(res.gr3)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr3_title" value="{res.gr3_title}">
                                                                            <span class="input-group-btn">
                                                                                <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제" onclick="del_this3(this); return false;">
                                                                            &times;
                                                                            </button>
                                                                            </span> 
                                                                        </div>
                                                                    </li>
                                                                    <li class="form-group-file">
                                                                        <input type="hidden" name="gr4" id="gr4_{res.id}" value="{res.gr4}" />
                                                                        <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr4_{res.id}/80x80?old={? res.gr4}{=safe_js(res.gr4)}{:}{=safe_js('/img/default-img-pic.png')}{/}" allowtransparency="true"></iframe>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr4_title" value="{res.gr4_title}">
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
                                                            <!-- /form-group-->

                                                            <div class="form-group"> 
                                                                <span class="control-label">B/M</span>
                                                                <textarea class="form-control input-sm" rows="3" id="inputBuisnessmodel" placeholder="비즈니스 모델을 입력하세요" name="bm">{res.bm}</textarea>
                                                            </div>
                                                            <!-- /form-group -->

                                                            <div class="form-group"> 
                                                                <span class="control-label">적용기술</span>
                                                                <textarea class="form-control input-sm" rows="3" id="inputReference" placeholder="적용기술을 입력하세요" name="skill">{res.skill}</textarea>
                                                                <!--
                                                                <ul>
                                                                    <li>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="적용기술을 한가지씩 입력하세요">
                                                                            <span class="input-group-btn">
                                                                            <button class="btn btn-default" class="close" aria-hidden="true" data-toggle="tooltip" title="삭제">
                                                                            &times;
                                                                            </button>
                                                                            </span>
                                                                        </div>
                                                                    </li>
                                                                    <li class="add">
                                                                        <button class="btn btn-default btn-xs">추가하기</button>
                                                                    </li>
                                                                </ul>
                                                                //-->
                                                            </div>
                                                            <!-- /form-group --> 
                                                        </div>
                                                    </div>
                                                    <!-- /goods-condition -->
                                                    
                                                    <div class="form-group form-submit">
                                                        
                                                        <button class="btn btn-primary btn-sm" type="submit" onclick="submit_edit_service(this, '{res.id}'); return false;">저장하기</button>
                                                        <button class="btn btn-default btn-sm pull-right" onclick="del_ser('{res.id}'); return false;">삭제하기</button>
                                                    </div>
                                                    <!-- /form-actions -->
                                                </fieldset>
                                            </form>
                                        </div>
