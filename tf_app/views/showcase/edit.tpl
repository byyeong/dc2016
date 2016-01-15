    <!-- rowContent -->
    <div id="product" class="rowContent"> 

        <!-- page-header -->
        <div class="page-header">
            <div class="container">
                <h2><a href="/showcase">제품/서비스 런칭</a></h2>

                <div class="pull-right">
                    <a href="/showcase/edit" class="btn btn-primary btn-sm">
                        제품/서비스 등록하기 
                    </a>
                </div>
            </div>
        </div>
        <!-- /page-header -->

        <!-- page-content -->
        <div class="page-content"> 
            <div class="container">
              
                <!-- editor -->
                <div class="editor">
                    <div class="edit-header">
                        <h3><span class="icon-pencil"></span> 제품/서비스 등록하기</h3>
                    </div>
                    <div class="edit-body">
                        <form class="form-horizontal" role="form" onsubmit="return false;" name="form_bz">
                            <fieldset>
                                
                                <div class="form-group"> 
                                    <div class="col-xs-12 col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" name="check_conn" onchange="check_connect();" {? res.startup_id}checked="checked"{/}> D.CAMP 기업 프로필 및 제품/서비스 정도와 연동합니다. 
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <!-- /form-group -->
                                <div id="st_c" {? !res || !res.startup_id}style="display: none;"{/}>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">회사/팀 선택</div>
                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                            <select class="selectpicker" name="startup_id">
                                                {@ st}
                                                <option value="{.startup_id}" {? .startup_id == res.startup_id}selected="selected"{/}>{.sname}</option>
                                                {/}
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group" >
                                        <div class="col-xs-12 col-sm-3 col-md-3 control-label">제품/서비스 선택</div>
                                        <div class="col-xs-12 col-sm-9 col-md-9">
                                            <select class="selectpicker" name="s_id">
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </div>
                                <div class="form-group" id="st_nc" {? res.startup_id}style="display: none;"{/}>
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">회사/팀 정보</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                         <input type="text" class="form-control" name="startup_name" value="{res.startup_name}">
                                    </div>
                                </div>
                                <!-- /form-group --> 

                                <header>
                                    <h4>기본 정보</h4>
                                </header>

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">제품/서비스명</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <input type="text" class="form-control" name="name" value="{res.name}">
                                    </div>
                                </div>
                                <!-- /form-group -->
                                
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label" >시장 구분</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9 form-inline">
                                        <select class="selectpicker" name="market_1">
                                            {@ market}
                                            <option value="{.id}" {? res.cat1 == .id}selected="selected"{/}>{._value}</option>
                                            {/}
                                            <option value="0" {? !res.cat1}selected="selected"{/}>없음</option>
                                        </select>
                                        <select class="selectpicker" name="market_2">
                                            {@ market}
                                            <option value="{.id}" {? res.cat2 == .id}selected="selected"{/}>{._value}</option>
                                            {/}
                                            <option value="0" {? !res.cat2}selected="selected"{/}>없음</option>
                                        </select>
                                        <select class="selectpicker" name="market_3">
                                            {@ market}
                                            <option value="{.id}" {? res.cat3 == .id}selected="selected"{/}>{._value}</option>
                                            {/}
                                            <option value="0" {? !res.cat3}selected="selected"{/}>없음</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- /form-group -->

                                

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">런칭(예정) 날짜</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9 form-inline"> 
                                        <div class="input-group"> 
                                            <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" name="founded" value="{res.founded}">
                                        </div> 
                                    </div>
                                </div>
                                <!-- /form-group --> 

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">주요 업데이트 일정</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9"> 
                                        <ul class="list-unstyled list-key-update">
                                            {? res.dates}{@ res.dates}
                                            <li class="item">
                                                <button type="button" class="close" aria-label="Close" onclick="del_box(this); return false;"><span aria-hidden="true">&times;</span></button>
                                                <div class="input-group"> 
                                                    <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="update_{.key_ + 1}" value="{.date}">
                                                </div>
                                                <textarea placeholder="관련 내용을 입력하세요." class="form-control" rows="3" name="update_des_{.key_ + 1}">{.description}</textarea>
                                            </li>
                                            {/}{:}
                                            <li class="item">
                                                <button type="button" class="close" aria-label="Close" onclick="del_box(this); return false;"><span aria-hidden="true">&times;</span></button>
                                                <div class="input-group"> 
                                                    <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="update_1" value="">
                                                </div>
                                                <textarea placeholder="관련 내용을 입력하세요." class="form-control" rows="3" name="update_des_1"></textarea>
                                            </li>
                                            {/}
                                        </ul>
                                        <button class="btn btn-default btn-xs" onclick="add_input(input_date, this);  return false;">추가하기</button>
                                        <p class="help-block">입력된 해당날짜에 Showcase 리스트 상단에 노출됩니다.</p>
                                    </div>
                                </div>
                                <!-- /form-group -->
                             
                                <header>
                                    <h4>제품/서비스 설명</h4>
                                </header>
                                
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">대표 이미지</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <input type="hidden" name="pic_1" id="pic_1" value="">
                                        <iframe width="100%" scrolling="no" height="182px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic_1/0x182?old={=safe_js(res.img1)}" allowtransparency="true"></iframe>
                                        <p class="help-block">런칭 페이지에 노출될 이미지를 업로드 해주세요. </p>
                                    </div>
                                </div>
                                <!-- /form-group -->

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">제품/서비스 한줄 설명</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <input type="text" class="form-control" placeholder="제품/서비스를 한 줄로 명확하게 설명해 주세요. (30자 내외)" name="des_ele" value="{res.des_ele}">
                                    </div>
                                </div>
                                <!-- /form-group -->

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">제품/서비스 상세 설명</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <textarea rows="5" class="form-control" placeholder="제품/서비스에 통해 해결하고자 하는 문제, 장점등을 알기 쉽게 작성해 주세요.(200자 내외)" name="des_pro">{res.des_pro}
                                        </textarea>
                                    </div>
                                </div>
                                <!-- /form-group --> 

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">제품 링크</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">

                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-fw fa-home"></i></span>
                                            <input type="text" class="form-control" placeholder="Homepage URL" name="web_url" value="{res.web_url}">
                                        </div>
                                        
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-fw fa-apple"></i></span>
                                            <input type="text" class="form-control" placeholder="App Store URL" name="ios_url" value="{res.ios_url}">
                                        </div>

                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-fw fa-android"></i></span>
                                            <input type="text" class="form-control" placeholder="Googleplay URL" name="and_url" value="{res.and_url}">
                                        </div>

                                    </div>
                                </div>
                                <!-- /form-group -->

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">홍보 영상 링크</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-fw fa-youtube-play"></i></span>
                                            <input type="text" class="form-control" placeholder="Youtube 또는 Vimeo 링크를 입력해 주세요." name="movie" value="{? res.movie1}{? res.movie1_type == 1}https://www.youtube.com/watch?v={:}https://vimeo.com/{/}{res.movie1}{/}"> 
                                        </div>
                                    </div>
                                </div>
                                <!-- /form-group -->
                                

                                <header>
                                    <h4>관련 기사 링크</h4>
                                </header>

                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">기사 링크</div>
                                    <div class="col-xs-12 col-sm-9 col-md-9">

                                        <ul class="list-unstyled list-url-article">
                                            {? res.art}{@ res.art}
                                            <li class="item"> 
                                                <button type="button" class="close" aria-label="Close" onclick="del_box(this); return false;"><span aria-hidden="true">&times;</span></button>
                                                <div class="row art">
                                                    <div class="col-md-4 left">
                                                        <input type="text" name="article_t_{.key_ + 1}" class="form-control" placeholder="관련 기사 제목를 입력해 주세요." value="{.title}" name="">
                                                    </div>
                                                    <div class="col-md-8 right">
                                                        <input type="text" name="article_{.key_ + 1}" placeholder="관련 기사 링크를 입력해 주세요." class="form-control" value="{.article}" name="">
                                                    </div>
                                                </div> 
                                            </li>
                                            {/}{:}
                                            <li class="item"> 
                                                <button type="button" class="close" aria-label="Close" onclick="del_box(this); return false;"><span aria-hidden="true">&times;</span></button>
                                                <div class="row art">
                                                    <div class="col-md-4 left">
                                                        <input type="text" name="article_t_1" class="form-control" placeholder="관련 기사 제목를 입력해 주세요.">
                                                    </div>
                                                    <div class="col-md-8 right">
                                                        <input type="text" name="article_1" placeholder="관련 기사 링크를 입력해 주세요." class="form-control">
                                                    </div>
                                                </div> 
                                            </li>
                                            {/} 
                                        </ul>
                                        <button class="btn btn-default btn-xs" onclick="add_input(input_article, this); return false;">추가하기</button>
                                        <p class="help-block">최대 10건까지 입력가능합니다.</p>
                                    </div>
                                </div>
                                <!-- /form-group -->


                                <div class="form-group form-submit">
                                    <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9"> 
                                        <button class="btn btn-default" onclick="cancel_bz(); return false;">취소</button> 
                                        <button class="btn btn-primary" onclick="submit_bz(this, 0); return false;">저장 후 마침</button> 
                                    </div>
                                </div>
                                <input type="hidden" name="cnt_date" value={? res.dates}{=sizeof(res.dates)}{:}1{/} />
                                <input type="hidden" name="cnt_article" value={? res.art}{=sizeof(res.art)}{:}1{/} />
                                <input type="hidden" name="id" value="{res.id}" />
                            </fieldset>
                        </form>
                    </div>
                </div>
                <!-- /editor --> 
            </div>
        </div>
        <!-- / page-content -->
    </div>
    <!-- /rowContent -->

<script>

get_service_list($("select[name=startup_id] option:selected").val(), "select[name=s_id]");

$('select[name=startup_id]').change(function(){
    get_service_list($("select[name=startup_id] option:selected").val(), "select[name=s_id]");
});

$('select[name=s_id]').change(function(){
    _val = $("select[name=s_id] option:selected").val();
    if (_val !== "0") {
        window.location.href="/showcase/edit/"+_val;
    }
    else {
        window.location.href="/showcase/edit";
    }
});

</script>