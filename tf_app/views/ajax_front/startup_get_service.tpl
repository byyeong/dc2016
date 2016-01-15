
<script>
  $(function() {
    $( ".datepicker" ).datepicker({ dateFormat: 'yy.mm.dd' }).val();
  });
</script>
<script type="text/javascript" charset="utf-8">
  $(document).ready(function(){
    $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: false});
  });
</script>
                            <div class="panel-heading">
                                <h3>{? com.stype == 1}제품/서비스{/}{? com.stype == 2}포트폴리오{/} 정보</h3>
                                {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="add_service(this); return false;">추가하기 </button>{/}
                            </div>
                            
                            <div class="panel-body" id="edit_service_no_f" style="display: none">
                                <ul class="list-unstyled">
                                    <li class="item edit" id="eidt_ser"> 
                                        <!-- todo : Edit 상태 -->
                                        <!-- goodset -->
                                        <div class="goodset">
                                            <form class="form-edit-set" name="service_form_0" onsubmit="return false;" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="startup_id" value="{id}" />
                                                <fieldset>                  
                                                    <button title="" data-toggle="tooltip" aria-hidden="true" class="close" type="button" data-original-title="닫기" onclick="add_service(this); return false;">×</button>
                                                    <div class="edit-set goods-info">
                                                        <div class="form-group">
                                                            <span class="sr-only">제품 이름</span>
                                                            <input type="text" class="form-control input-sm" placeholder="제품 이름" name="name">
                                                            </input>
                                                        </div>
                                                        <!-- /form-group -->

                                                        <div class="form-group form-group-date">
                                                            <span class="sr-only" for="inputLaunchDate">런칭일자</span>
                                                            <!-- datepicker -->
                                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                                <div class="input-group bfh-datepicker-toggle input-group-sm" data-toggle="bfh-datepicker"> 
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                    <input type="text" class="form-control datepicker" placeholder="런칭일자" name="founded" readonly>
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
                                                                <input type="text" class="form-control input-sm" placeholder="제품/서비스를 한 줄로 명확하게 설명해 주세요" name="des_ele">
                                                            </div>
                                                            <!-- /form-group -->

                                                            <div class="form-group"> 
                                                                <span class="control-label">Problem</span>
                                                                <textarea class="form-control input-sm" placeholder="사업을 통해 해결하고자 하는 문제는 무엇이며, 왜 해결하고자 하시나요?" name="des_pro"></textarea>
                                                            </div>
                                                            <!-- /form-group -->

                                                            <div class="form-group"> 
                                                                <span class="control-label">Solution</span>
                                                                <textarea class="form-control input-sm" placeholder="앞서 말씀하신 문제를 어떠한 제품/서비스로 해결하고자 하시나요?" name="des_sol"></textarea>
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
                                                            <li class="active"><a href="#upImg" data-toggle="tab">이미지</a></li>
                                                            <li><a href="#upMov" data-toggle="tab">동영상</a></li>
                                                        </ul>
                                                        <div class="tab-content">
                                                            <div class="tab-pane active" id="upImg">
                                                                <p>이미지는 4개까지 업로드 가능합니다</p>
                                                                <input type="hidden" name="img1" id="img1_0" value="" />
                                                                <input type="hidden" name="img2" id="img2_0" value="" />
                                                                <input type="hidden" name="img3" id="img3_0" value="" />
                                                                <input type="hidden" name="img4" id="img4_0" value="" />
                                                                <ul class="list-inline">
                                                                    <li class="col-md-3">
                                                                        <label for="inputFileImg-1">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img1_0/150x150?old={=safe_js('/images/img-default.png')}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                    <li class="col-md-3">
                                                                        <label for="inputFileImg-2">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img2_0/150x150?old={=safe_js('/images/img-default.png')}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                    <li class="col-md-3">
                                                                        <label for="inputFileImg-3">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img3_0/150x150?old={=safe_js('/images/img-default.png')}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                    <li class="col-md-3">
                                                                        <label for="inputFileImg-4">
                                                                            <iframe scrolling="no" height="150px" width="150px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/img4_0/150x150?old={=safe_js('/images/img-default.png')}" allowtransparency="true"></iframe>
                                                                        </label>
                                                                    </li>
                                                                </ul>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <!-- /tap-pane -->
                                                            <div class="tab-pane" id="upMov">
                                                                <p>동영상은 Youtube 혹은 Vimeo에 등록된 영상의 주소를 입력해주세요. 4개까지 입력 가능합니다.</p>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie1">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie2">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie3">
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="input-group input-group-sm"> 
                                                                        <span class="input-group-addon"><span class="fa fa-fw fa-youtube-play"></span></span>
                                                                        <input type="text" class="form-control" placeholder="http://동영상 주소를 입력하세요" name="movie4">
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
                                                                    <input type="url" class="form-control" id="inputUrlHomepage" placeholder="http://Homepage" name="web_url">
                                                                </div>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="sr-only control-label">App Store</span>
                                                                <div class="input-group input-group-sm"> 
                                                                    <span class="input-group-addon"><span class="icon-fixed-width icon-apple"></span></span>
                                                                    <input type="url" class="form-control" id="inputUrlAppStore" placeholder="http://AppStor" name="ios_url">
                                                                </div>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="sr-only control-label">Google Play</span>
                                                                <div class="input-group input-group-sm"> 
                                                                    <span class="input-group-addon"><span class="fa fa-fw fa-android"></span></span>
                                                                    <input type="url" class="form-control" id="inputUrlGooglePlay" placeholder="http://GooglePlay" name="and_url">
                                                                </div>
                                                            </div>
                                                            <!-- /form-group--> 
                                                        </div>
                                                    </div>
                                                    <!-- /goods-links -->
                                                    
                                                    <!--  goods-condition -->
                                                    <div class="edit-set goods-condition">
                                                        <h4>제품 현황 <small>( 투자자 및 유관기관에만 보여지는 정보입니다.)</small></h4>
                                                        <button class="btn btn-default btn-xs" data-toggle="collapse" data-target=".collapse-editCondition">입력하기</button>

                                                        <div class="formwrap collapse collapse-editCondition">
                                                            <div class="form-group"> 
                                                                <span class="control-label">이용자수/판매량</span>
                                                                <textarea class="form-control input-sm" rows="3"  placeholder="" name="sales"></textarea>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">수익률</span>
                                                                <textarea class="form-control input-sm" rows="3"  placeholder="" name="revenue"></textarea>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">기타</span>
                                                                <textarea class="form-control input-sm" rows="3" placeholder="" name="etc"></textarea>
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">주요 타겟층</span>
                                                                <input type="text input-sm" class="form-control" name="targer">
                                                            </div>
                                                            <!-- /form-group-->
                                                            <div class="form-group"> 
                                                                <span class="control-label">그래프 (이미지)</span>
                                                                <p class="help-block">제품 현황을 알려줄수 잇는 그래프 자료를 업로드 하세요.</p>
                                                                <ul class="list-unstyled">
                                                                    <li class="form-group-file">
                                                                        <input type="hidden" name="gr1" id="gr1_0" value="" />
                                                                        <iframe scrolling="no" class="pull-left" height="80px" width="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/gr1_0/80x80?old={=safe_js('/img/default-img-pic.png')}" allowtransparency="true"></iframe>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr1_title">
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
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr2_title">
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
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr3_title">
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
                                                                            <input type="text" class="form-control" id="inputReference" placeholder="제목을 입력하세요" name="gr4_title">
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
                                                                <textarea class="form-control input-sm" rows="3" id="inputBuisnessmodel" placeholder="비즈니스 모델을 입력하세요" name="bm"></textarea>
                                                            </div>
                                                            <!-- /form-group -->

                                                            <div class="form-group"> 
                                                                <span class="control-label">적용기술</span>
                                                                <textarea class="form-control input-sm" rows="3" id="inputReference" placeholder="적용기술을 입력하세요" name="skill"></textarea>
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
                                                        <button class="btn btn-primary btn-sm" type="submit" onclick="submit_edit_service(this, 0); return false;">저장하기</button>
                                                        <button class="btn btn-default btn-sm pull-right" onclick="add_service(this); return false;">삭제하기</button>
                                                    </div>
                                                    <!-- /form-actions -->
                                                </fieldset>
                                            </form>
                                        </div>
                                        <!-- /goodset --> 
                                    </li>
                                </ul>
                            </div>
                            
                            <!-- TODO : none 상태 -->
                            <div class="panel-body" {? !service}style="display: none;"{/}> 
                                <ul class="list-unstyled">
                                {@ service}
                                    <li class="item" id="service_{.id}">
                                        <!-- todo : normal 상태 --> 
                                        <!-- goodset -->
                                        <div class="goodset">
                                            <h4><span class="fa fa-lightbulb-o"></span> {.name} </h4>
                                            <span classs="goods-launch"><span class="fa fa-time"></span></span> {.founded}</span>
                                            {? s && edi.user_id == s.id}<button class="btn btn-default btn-xs" onclick="edit_service(this, '{.id}'); return false;">수정하기 </button>{/}
                                            <div class="goods-basic">
                                                
                                                {? .des_ele}  
                                                <dl>
                                                    <dt>Elevator pitch</dt>
                                                    <dd>{.des_ele}</dd>
                                                </dl>
                                                {/}
                                                {? .des_pro}
                                                <dl>
                                                    <dt>Problem</dt>
                                                    <dd>{=add_brs(.des_pro)}</dd>
                                                </dl>
                                                {/}
                                                {? .des_sol}
                                                <dl>
                                                    <dt>Solution</dt>
                                                    <dd>{=add_brs(.des_sol)}</dd>
                                                </dl>
                                                {/}
                                                
                                                <dl>
                                                    <dt class="sr-only">제품 이미지</dt>
                                                    <dd class="goods-imgs">                                                 
                                                        <ul class="list-inline gallery clearfix"> 
                                                            {? .img1}
                                                            <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{.img1}" style="background:url({.img1_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans.png" class="img-responsive"></a>
                                                            </li>
                                                            {/}{? .img2}
                                                            <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{.img2}" style="background:url({.img2_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans.png" class="img-responsive"></a>
                                                           </li>
                                                           {/}{? .img3}
                                                           <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{.img3}" style="background:url({.img3_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans.png" class="img-responsive"></a>
                                                           </li>
                                                           {/}{? .img4}
                                                           <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{.img4}" style="background:url({.img4_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans.png" class="img-responsive"></a>
                                                           </li> 
                                                           {/}
                                                           {? .movie1}
                                                            <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{? .movie1_type == 1}http://www.youtube.com/watch?v={/}{? .movie1_type == 2}http://vimeo.com/{/}{.movie1}" style="background:url({.movie1_thumb}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans-play.png" class="img-responsive"></a>
                                                            </li>
                                                            {/}{? .movie2}
                                                            <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{? .movie2_type == 1}http://www.youtube.com/watch?v={/}{? .movie2_type == 2}http://vimeo.com/{/}{.movie2}" style="background:url({.movie2_thumb}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans-play.png" class="img-responsive"></a>
                                                           </li>
                                                           {/}{? .movie3}
                                                           <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{? .movie3_type == 1}http://www.youtube.com/watch?v={/}{? .movie3_type == 2}http://vimeo.com/{/}{.movie3}" style="background:url({.movie3_thumb}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans-play.png" class="img-responsive"></a>
                                                           </li>
                                                           {/}{? .movie4}
                                                           <li class="col-md-3">
                                                                <a rel="prettyPhoto[mixed_{.id}]" href="{? .movie4_type == 1}http://www.youtube.com/watch?v={/}{? .movie4_type == 2}http://vimeo.com/{/}{.movie4}" style="background:url({.movie4_thumb}) center center no-repeat #000; background-size:180px auto;">
                                                                <img src="/img/trans-play.png" class="img-responsive"></a>
                                                           </li> 
                                                           {/}
                                                        </ul>
                                                        <div class="clearfix"></div>
                                                    </dd>
                                                </dl>
                                                        
                                                <div class="goods-links pull-left">
                                                    {? .web_url}<a href="{.web_url}" target="_blank" class="btn btn-default btn-sm" data-toggle="tooltip" title="Homepage"><span class="fa fa-home fa-large"></span></a> {/}
                                                    {? .ios_url}<a href="{.ios_url}" target="_blank" class="btn btn-default btn-sm" data-toggle="tooltip" title="App Store"><span class="fa fa-apple fa-large"></span></a> {/}
                                                    {? .and_url}<a href="{.and_url}" target="_blank" class="btn btn-default btn-sm" data-toggle="tooltip" title="Google Play"><span class="fa fa-android fa-large"></span></a>{/}
                                                </div>
                                               
                                                <div class="pull-right">
                                                    {? s.admin || s && edi.user_id == s.id || (s.per & settings->permission6) == settings->permission6}
                                                    <button type="button" class="btn btn-default btn-sm" data-toggle="collapse" data-target=".goods-toggle_{.id}">
                                                        <span class="fa fa-expand-alt fa-large"></span>&nbsp; 제품현황 보기 
                                                    </button>
                                                    {:}
                                                    <button type="button" class="btn btn-default btn-sm" onclick="javascript:alert('해당 정보는 구성원, 투자자 및 유관기관 이용자들에게만 공개됩니다.');">
                                                        <span class="fa fa-expand-alt fa-large"></span>&nbsp; 제품현황 보기 
                                                    </button>
                                                    {/}
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <!-- /goods-basic -->
                                            
                                            <div class="goods-toggle_{.id} goods-toggle well well-sm collapse">
                                                {?.sales}
                                                <dl>
                                                    <dt>이용자수/판매량</dt>
                                                    <dd>{.sales}</dd>
                                                </dl>
                                                {/}
                                                {?.revenue}
                                                <dl>
                                                    <dt>수익률</dt>
                                                    <dd>{.revenue}</dd>
                                                </dl>
                                                {/}
                                                {?.etc}
                                                <dl>
                                                    <dt>기타</dt>
                                                    <dd>{.etc}</dd>
                                                </dl>
                                                {/}
                                                {?.target}
                                                <dl>
                                                    <dt>주요 타겟층</dt>
                                                    <dd>{.target}</dd>
                                                </dl>
                                                {/}
                                                {? .gr1 || .gr2 || .gr3 || .gr4}
                                                <dl>
                                                    <dt>그래프</dt>
                                                    <dd class="graph-imgs">
                                                        {?.gr1}
                                                        <ul class="list-inline">
                                                            <li class="col-md-3">
                                                                <a href="{.gr1}" rel="prettyPhoto[gallery2_{.id}]" style="background:url({.gr1_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;"> 
                                                                <img src="/img/trans.png" class="img-responsive" alt="{.gr1_title}">
                                                                <span class="img-title">{.gr1_title}</span>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                        {/}{?.gr2}
                                                        <ul class="list-inline">
                                                            <li class="col-md-3">
                                                                <a href="{.gr2}" rel="prettyPhoto[gallery2_{.id}]" style="background:url({.gr2_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;"> 
                                                                <img src="/img/trans.png" class="img-responsive" alt="{.gr2_title}">
                                                                <span class="img-title">{.gr2_title}</span>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                        {/}{?.gr3}
                                                        <ul class="list-inline">
                                                            <li class="col-md-3">
                                                                <a href="{.gr3}" rel="prettyPhoto[gallery2_{.id}]" style="background:url({.gr3_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;"> 
                                                                <img src="/img/trans.png" class="img-responsive" alt="{.gr3_title}">
                                                                <span class="img-title">{.gr3_title}</span>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                        {/}{?.gr4}
                                                        <ul class="list-inline">
                                                            <li class="col-md-3">
                                                                <a href="{.gr4}" rel="prettyPhoto[gallery2_{.id}]" style="background:url({.gr4_thumb}?date={=date('his')}) center center no-repeat #000; background-size:180px auto;"> 
                                                                <img src="/img/trans.png" class="img-responsive" alt="{.gr4_title}">
                                                                <span class="img-title">{.gr4_title}</span>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                        {/}
                                                        <div class="clearfix"></div> 
                                                    </dd>
                                                </dl>
                                                {/}
                                                {?.bm}
                                                <dl>
                                                    <dt>B/M</dt>
                                                    <dd>{.bm}</dd>
                                                </dl>
                                                {/}
                                                {?.skill}
                                                <dl>
                                                    <dt>적용기술</dt>
                                                    <dd>{.skill}</dd>
                                                </dl>
                                                {/}
                                                
                                                {? !.bm && !.skill && !.gr1 && !.gr2 && !.gr3 && !.gr4 && !.target && !.etc && !.revenue && !.sales}
                                                등록된 정보가 없습니다.
                                                {/}
                                            </div>
                                            <!-- /goods-condition --> 
                                        </div>
                                        <!-- /goodset --> 
                                    </li>
                                    <li class="item edit" id="eidt_ser" style="display: none;"> 
                                    </li>
                                {/}
                                </ul>
                                <!-- /alert --> 
                            </div>
                            <!-- /panel-body --> 
                            
                            
                            <div class="panel-body" id="edit_service_no" {? service}style="display: none"{/}>
                                <div class="alert alert-info">
                                    <p class="text-info">입력된 내용이 없습니다</p>
                                </div>
                            </div>
                                
<script type="text/javascript">
//<![CDATA[
function del_this1(_this) {
    $(_this).prev().val('');
    var _id = $(_this).prev().attr('id');
    var _val = '<iframe width="150px" scrolling="no" height="150px" frameborder="0" allowtransparency="true" src="/ajax/photo_form_file/'+_id+'/150x150?old=/img/default-img-pic.png" style="overflow: hidden; border: 0pt none; clear: both;" id="photo_uploader"></iframe>';
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
function set_detail(_this) {
    $(_this).parent().parent().parent().parent().find('.goods-detail').slideToggle();
}
function edit_service(_this, _id) {
    var _dis = $(_this).parent().parent().next().css('display');
    if (_dis === 'none') {
        var get_url = '/ajax_front/startup_get_service_e/'+_id;
        $.ajax({
            type : 'POST',
            url : get_url,
            dataType : 'html',
            success : function(_data) {
                $(_this).parent().parent().next().html(_data);
            }
        });
    }

    $(_this).parent().parent().next().toggle();

}

function submit_edit_service(_this, _id){
    $(_this).attr("disabled", "disabled");
    var frm = $('form[name=service_form_'+_id+']');

    var get_url = '/ajax_front/startup_edit_service';
    var set_data = frm.serialize();
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {
            $('form[name=service_form_'+_id+']').parent().parent().slideToggle();
            $(_this).removeAttr("disabled");
            if (_data.data) 
                get_service(_data.data);
            else 
                get_service();
        }
    });
}

function del_ser(_id){
    del_confirm('del_ser2('+_id+')');
}

function del_ser2(_id){
    var get_url = '/ajax_front/startup_del_service/'+_id;
    
    $.ajax({
        type : 'POST',
        url : get_url,
        dataType : 'json',
        success : function(_data) {
            $('form[name=service_form_'+_id+']').parent().slideToggle();
            get_service();
            $('#md-warning').modal('hide');
        }
    });
}

function close_edit_service(_this) {
    $(_this).parent().parent().parent().parent().parent().slideToggle();
}

function close_edit_service2(_this) {
    $(_this).parent().parent().parent().parent().parent().parent().slideToggle();
}

function add_service(_this)
{
    $('#edit_service_no_f').slideToggle();
}

function edit_toggle(_this)
{
    $(_this).parent().parent().parent().parent().slideToggle();
}
//]]>
</script>