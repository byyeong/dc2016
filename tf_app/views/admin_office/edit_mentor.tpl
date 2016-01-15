<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    function wizwig() {
        if ($('.mceLayout').length > 0) {
            return false;
        }
        tinyMCE.init({
            relative_urls : false,
            remove_script_host : false,
            mode : "specific_textareas",
            editor_selector : "oh_description",
            theme : "advanced",
            plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,inlinepopups,insertdatetime,preview,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

            theme_advanced_buttons1 : "fontselect,fontsizeselect,|,tablecontrols,|,hr,removeformat,visualaid",
            theme_advanced_buttons2 : "bold,italic,underline,strikethrough,|,forecolor,backcolor,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,outdent,indent,blockquote,|,link,unlink,|,imagepop,iespell,media,|,code,fullscreen",
            theme_advanced_buttons3 : "",
            theme_advanced_buttons4 : "",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_statusbar_location : "bottom",
            theme_advanced_resizing : false,

            theme_advanced_fonts : "나눔고딕=나눔고딕,NanumGothic;,맑은 고딕='맑은 고딕','Malgun Gothic';굴림=굴림;굴림체=굴림체;궁서=궁서;궁서체=궁서체;돋움=돋움;돋움체=돋움체;바탕=바탕;바탕체=바탕체;Arial=Arial; Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",

    // Drop lists for link/image/media/template dialogs
            template_external_list_url : "lists/template_list.js",
            external_link_list_url : "lists/link_list.js",
            external_image_list_url : "lists/image_list.js",
            media_external_list_url : "lists/media_list.js",

            setup : function(ed) {
                ed.onLoadContent.add(function(ed, o) {
                    ed.focus();
                    tinyMCE.activeEditor.setContent("{=safe_js_editor(res.oh_description)}");
                });
                // Register image button
                ed.addButton('imagepop', {
                    title : 'imagepop',
                    image : '/tinymce/add_image.gif',
                    onclick : function() {
                    cmdImgUploadPop();
                }
                });
            }
        });
    }
        


    function cmdImgUploadPop(){
        var win = window.open( "/ajax/add_image/",
        "editor_win",
        "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=450,height=350,left=50,top=50"
        );
        win.focus();
    }

    // 파일업로드 완료후 opener.editorImgUploadComplete함수호출 되는 방식
    function editorImgUploadComplete(_path){
        var strImg = "<br><img src='" + _path + "' ><br><br>";
        var contents = tinyMCE.activeEditor.getDoc().body.innerHTML;
        //tinyMCE.activeEditor.setContent( contents + strImg );

        var inst = tinyMCE.activeEditor;
        inst.getWin().focus();
        var  args = {src: _path};
        inst.execCommand('mceInsertContent',false,'<img id="__mce_tmp" />',{skip_undo : 1});
        inst.dom.setAttribs('__mce_tmp', args);
        inst.dom.setAttrib('__mce_tmp', 'id', '');
        inst.undoManager.add();

    }
</script>
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel --> 
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2>
                                <span class="icon-user"></span><span class="break"></span>
                                멘토 정보 
                            </h2>
                            <div class="actions"> 
                                <span class="break"></span> 
                                <a title="멘토 목록 " data-toggle="tooltip" href="/admin_office/mentor">
                                    <span class="icon-align-justify"></span>
                                </a> 
                            </div>
                        </div>
                        <!-- /panel-heading -->

                        <div class="panel-body">

                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" {? !open}class="active"{/}>
                                    <a href="#mento-info" aria-controls="mento-info" role="tab" data-toggle="tab">멘토정보</a>
                                </li>
                                <li role="presentation" {? ! res}style="display: none;"{/} id="oh1" {? open}class="active"{/}>
                                    <a href="#oh-info" aria-controls="oh-info" role="tab" data-toggle="tab"  onclick="wizwig();">OH 기본정보 </a>
                                </li>
                                <li role="presentation" {? ! res}style="display: none;"{/} id="oh2">
                                    <a href="#oh-apply" aria-controls="oh-apply" role="tab" data-toggle="tab">OH 기본 신청 정보 </a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane {? !open}active{/}" id="mento-info">
                                    <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="f_mento">
                                        <fieldset>
                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">멘토이름 </label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">                                            
                                                    <input type="text" placeholder="이름을 입력해 주세요" class="form-control" name="name" value="{res.name}" required="required" >
                                                </div>
                                            </div>
                                            <!-- /form-group -->  

                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">소속 </label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" placeholder="소속을 입력해 주세요" class="form-control" name="department" value="{res.department}">
                                                </div>
                                            </div>
                                            <!-- /form-group --> 

                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">직책 </label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <input type="text" placeholder="직책을 입력해 주세요" class="form-control" name="position" value="{res.position}">
                                                </div>
                                            </div>
                                            <!-- /form-group --> 

                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">프로필 이미지 </label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <div>
                                                        <input type="hidden" name="picture" id="pic" value="{? ! res.picture}/img/default-img-member.png{/}">
                                                        <img class="img-thumbnail" src="{?res.picture}{res.picture}?{=date('his')}{:}/img/common/240x240.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                                        <div id="div_img_change" style="display: none;">
                                                            <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=240&r_height=240" ></iframe>
                                                        </div>
                                                    </div>
                                                    <!-- /btn-group -->
                                                </div>
                                            </div>
                                            <!-- /form-group --> 

                                            <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">상담주제 선택 </div>
                                            <div class="col-xs-12 col-sm-10 col-md-10"> 

                                                <div class="form-inline"> 
                                                    {? label}
                                                    <select class="form-control" name="label">
                                                        {@ label}
                                                        <option value="{.id}" {? .id == res.label}selected="selected"{/}>{.label}</option>
                                                        {/}
                                                    </select>
                                                    {/} 
                                                    <button class="btn btn-default btn-sm" data-toggle="collapse" href="#addCat" aria-expanded="false" aria-controls="addCat">주제 추가하기</button>
                                                </div>
                                                
                                                <div class="collapse" id="addCat">
                                                    <div class="well"> 
                                                        <input type="text" placeholder="주제명을 입력하세요." class="form-control" name="label_t"> 
                                                    </div>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">멘토 소개</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea rows="5" class="form-control" placeholder="상세내용을 입력해 주세요 " name="description">{res.description}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">약력 </div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <ul class="list-unstyled">
                                                        {? bios}
                                                        {@ bios}
                                                        <li>
                                                            <button class="close" type="button" onclick="remove_p(this);"><span>×</span></button>
                                                            <input type="text" placeholder="약력을 입력해 주세요" class="form-control" name="bios{.key_+1}" value="{.bios}">
                                                        </li>
                                                        {/}
                                                        {:}
                                                        <li>
                                                            <button class="close" type="button" onclick="remove_p(this);"><span>×</span></button>
                                                            <input type="text" placeholder="약력을 입력해 주세요" class="form-control" name="bios1">
                                                        </li>
                                                        {/}
                                                    </ul>
                                                    <button class="btn btn-default btn-xs" onclick="add_input(this, a_bios); return false;">+추가입력</button>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">관련기사</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <ul class="list-unstyled">
                                                        {? article}
                                                        {@ article}
                                                        <li class="row">
                                                            <button class="close" type="button" onclick="remove_p(this);"><span>×</span></button>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 left">
                                                                <input type="text" placeholder="기사 제목을 입력해 주세요" class="form-control" name="an{.key_+1}" value="{.title}">
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 right">
                                                                <input type="url" placeholder="링크주소  입력해 주세요" class="form-control" name="al{.key_+1}" value="{.url}">
                                                            </div>
                                                        </li>
                                                        {/}
                                                        {:}
                                                        <li class="row">
                                                            <button class="close" type="button" onclick="remove_p(this);"><span>×</span></button>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 left">
                                                                <input type="text" placeholder="기사 제목을 입력해 주세요" class="form-control" name="an1">
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 right">
                                                                <input type="url" placeholder="링크주소  입력해 주세요" class="form-control" name="al1">
                                                            </div>
                                                        </li>
                                                        {/}
                                                    </ul>
                                                    <button class="btn btn-default btn-xs" onclick="add_input(this, a_article); return false;">+추가입력</button>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">D.CAMP계정연결 </div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                     
                                                     <div class="well">
                                                        <header>
                                                            <h4>연결된 계정 정보</h4>
                                                        </header>
                                                        <table class="table table-striped table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th class="td-id">아이디</th>
                                                                    <th class="td-name">이름</th>
                                                                    <th class="td-gender">성별</th>
                                                                    <th class="td-birth">생년월일</th>
                                                                    <th class="td-phone">휴대폰번호</th>
                                                                    <th class="td-company">소속</th> 
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                {? mento}
                                                                <tr>
                                                                    <td class="td-id">{mento.ids}</td>
                                                                    <td class="td-name"><a href="/member/{mento.ids}">{mento.name}</a></td>
                                                                    <td class="td-gender">{? mento.gender == 1}남{:}여{/}</td>
                                                                    <td class="td-birth">{mento.birth}</td>
                                                                    <td class="td-phone">{mento.tel}</td>
                                                                    <td class="td-company">{mento.com.name}</td> 
                                                                </tr> 
                                                                {:}
                                                                <tr><td>등록된 계정이 없습니다.</td></tr>
                                                                {/}
                                                            </tbody>
                                                        </table>
                                                     </div>

                                                     <button class="btn btn-default btn-sm" type="button" data-toggle="modal" data-target="#md-connectId">
                                                         <span class="glyphicon glyphicon-search"></span> 계정찾기
                                                     </button>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">공개 설정</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <label class="radio-inline">
                                                        <input type="radio" name="hide" value="1" {? res.hide}checked{/}> 공개
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="hide" value="0" {? !res.hide}checked{/}> 비공개
                                                    </label>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group form-submit"> 
                                                <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button class="btn btn-default" type="button">취소</button>
                                                    <button class="btn btn-primary" type="submit" onclick="submit_mento({? res.id}{res.id}{:}0{/});">저장</button>
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                        <input type="hidden" name="b_cnt" value="{? bios}{=sizeof(bios)}{:}1{/}" />
                                        <input type="hidden" name="a_cnt" value="{? article}{=sizeof(article)}{:}1{/}" />
                                        <input type="hidden" name="user_id" value="{res.user_id}" />
                                        <input type="hidden" name="id" value="{res.id}" />
                                        </fieldset>
                                    </form>
                                </div>
                                <!-- /tab-pane -->

                                <div role="tabpanel" class="tab-pane {? open}active{/}" id="oh-info">
                                    <form class="form-horizontal" role="form" name="f_mento_oh" onsubmit="return false;">
                                        <fieldset>
                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">Office Hours 제목 </label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">                                            
                                                    <input type="text" placeholder="Office Hours 제목을 입력해 주세요" class="form-control" name="subject" value="{res.subject}">
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            
                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">주최/주관 기관 </label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">                                            
                                                    <input type="text" placeholder="기관명을 입력해 주세요" class="form-control" name="hosted" value="{res.hosted}">
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            
                                            <div class="form-group"> 
                                                <label class="col-xs-12 col-sm-2 col-md-2 control-label">상세내용</label>
                                                <div class="col-xs-12 col-sm-10 col-md-10">                                            
                                                    <textarea rows="30" class="form-control oh_description" id="oh_description">{res.oh_description}</textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group -->

                                            <div class="form-group form-submit"> 
                                                <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button class="btn btn-default" type="button">취소</button>
                                                    <button class="btn btn-primary" type="submit" onclick="submit_mento_oh();">저장</button>
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            <input type="hidden" id="contents" name="oh_description"/>
                                            <input type="hidden" name="id" value="{res.id}" />
                                        </fieldset>
                                    </form>
                                </div>
                                <!-- /tab-pane -->

                                <div role="tabpanel" class="tab-pane" id="oh-apply">
                                    <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="f_mento_form_add">
                                        <fieldset>
                                            <legend class="sr-only">OH신청 정보</legend>

                                            <h3>기본질문 <small>아래의 항목은 신청시 기본으로 받는 정보입니다.</small></h3>
                                            <div class="well">
                                                <ul>
                                                    <li>참가자 이름</li>
                                                    <li>휴대폰 번호</li>
                                                    <li>이메일 주소</li>
                                                    <li>참가 회사/팀명</li>
                                                    <li>D.CAMP 기업프로필 주소</li>
                                                    <li>제품/서비스명</li>
                                                    <li>제품/서비스 한 줄 소개 (준비하고 계시는 제품/서비스를 한 문장 (50자 이내)으로 소개해주세요.)</li>
                                                    <li>간단한 자기소개</li>
                                                    <li>팀소개</li>
                                                    <li>이야기 나누구 싶은 상담 주제</li>
                                                    <li>첨부파일</li>
                                                    <li>이전 Office Hours신청이력</li>
                                                </ul>
                                            </div>


                                            <h3>추가질문  <small>멘토가 특별히 요청하는 추가 질문을 추가해주세요.</small></h3>

                                            {? form}
                                            {@ form}
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-3 col-md-3 control-label" >추가질문 제목 </div>
                                                <div class="col-xs-12 col-sm-9 col-md-9">
                                                    <button class="close" type="button" onclick="remove_pp(this);"><span>×</span></button>
                                                    <input type="text" class="form-control" name="q{.key_+1}" value="{.subject}">
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            {/}
                                            {:}
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-3 col-md-3 control-label" >추가질문 제목 </div>
                                                <div class="col-xs-12 col-sm-9 col-md-9">
                                                    <button class="close" type="button" onclick="remove_pp(this);"><span>×</span></button>
                                                    <input type="text" class="form-control" name="q1">
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            {/}
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9">
                                                    <button type="button" class="btn btn-default btn-xs" onclick="add_input(this, a_q);">질문 추가하기 </button>
                                                </div>
                                            </div>

                                            <div class="form-group form-submit"> 
                                                <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                    <button class="btn btn-default" type="button">취소</button>
                                                    <button class="btn btn-primary" type="submit" onclick="submit_mento_form({? res.id}{res.id}{:}0{/}); return false;">저장</button>
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            <input type="hidden" name="q_cnt" value="{? form}{=sizeof(form)}{:}1{/}" />
                                            <input type="hidden" name="id" value="{res.id}" />
                                        </fieldset>
                                    </form>
                                </div> 
                                <!-- /tab-pane -->
                            </div>
                            <!-- /tab-content -->
                            
                        </div>
                        <!-- /panel-body -->
                    </div>
                    <!-- /panel --> 

                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 

<div class="modal fade" id="md-connectId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">멘토 권한과 연결하고자 하는 회원 검색  </h4>
            </div>
            <div class="modal-body">
            <!-- modal content -->
                <div class="panel panel-default"> 
                     <div class="panel-body highlight">
                        <form class="col-md-8 col-lg-offset-2" role="search" method="post" onsubmit="return false;" name="f_search">
                            <div class="input-group">
                                <input type="text" placeholder="이름, 핸드폰 번호, 생년월일을 입력한 후 검색하세요." class="form-control" name="q">
                                <span class="input-group-btn">
                                <button type="submit" class="btn btn-default" onclick="serch_member();">검색</button>
                                </span> 
                            </div>
                        </form>
                    </div>
                    <!-- /panel-body -->
                    <table class="table table-striped table-hover"></table>
                </div>
                <!-- /panel -->  
            <!-- /modal content -->
            </div> 
        </div>
    </div>
</div>