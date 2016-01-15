<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        relative_urls : false,
        remove_script_host : false,
        mode : "specific_textareas",
        editor_selector : "con",
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
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.content)}");
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
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel #pane-event-edit -->
                    <div id="pane-event-edit" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> Benefits 정보입력</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div class="panel-heading">   
                            <!-- tab-content -->
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="/admin_program/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                                {? res.app}
                                <li><a href="/admin_program/apply_info/{res.id}">{? res.basic || res.forms || res.form_file}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                                {/}
                            </ul>
                        </div>
                        <br/>
                        <div class="tab-content">
                            <div class="tab-pane active" id="formInfo">
                                <form class="form-horizontal" name="edit_pro_f" action="/admin_program/edit/{res.id}" role="form" method="post" onsubmit="return false;" enctype="multipart/form-data" >
                                    <fieldset>
                                        
                                        <legend class="sr-only">프로그램 정보 입력</legend>
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">담당자</div>
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
                                                            {? u}
                                                            <tr>
                                                                <td class="td-id">{u.ids}</td>
                                                                <td class="td-name"><a href="/member/{u.ids}">{u.name}</a></td>
                                                                <td class="td-gender">{? u.gender == 1}남{:}여{/}</td>
                                                                <td class="td-birth">{u.birth}</td>
                                                                <td class="td-phone">{u.tel}</td>
                                                                <td class="td-company">{u.com.name}</td> 
                                                            </tr> 
                                                            {:}
                                                            <tr><td colspan="6">등록된 계정이 없습니다.</td></tr>
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
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">프로그램명</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <input type="text" name="title" value="{res.title}" class="form-control input-xlarge" required="required">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">지원기관</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <input type="text" name="agency" value="{res.agency}" class="form-control input-xlarge" required="required">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">성격</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="cat_id" class="selectpicker sort-options">
                                                    <optgroup label="진행상태별 보기">
                                                        {@ category}
                                                        <option value="{.id}" {? res.cat_id == .id}selected="selected"{/}>{.category}</option>
                                                        {/}
                                                    </optgroup>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">접수 기간</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="a_start" data-width="auto" class="selectpicker" onchange="check_date(this); return false;">
                                                    <option value="0" {? res && !res.a_start}selected="selected"{/}>상시</option>
                                                    <option value="1" {? !res || res.a_start}selected="selected"{/}>일정 선택</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group" {? res && !res.a_start}style="display: none;"{/} id="a_date"> 
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label"></div>
                                            <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y-m-d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="a_start_d" value="{=substr(res.a_start, 0, 10)}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.time_s}{res.time_s}{:}10:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" name="a_start_t" value="{=substr(res.a_start, 11)}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                <span class="sim">&sim;</span> 
                                                
                                                <!-- datepicker -->
                                                <div class="bfh-datepicker" data-format="y.m.d">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" name="a_end_d" value="{=substr(res.a_end, 0, 10)}" readonly>
                                                    </div>
                                                </div>
                                                <!-- /datepicker --> 
                                                
                                                <!-- timepicker -->
                                                <div class="bfh-timepicker" data-time="{? res.time_e}{res.time_e}{:}19:00{/}" >
                                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                        <input type="text" class="form-control timepicker" name="a_end_t" value="{=substr(res.a_end, 11)}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                                    </div>
                                                </div>
                                                <!-- /timepicker --> 
                                                
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">인원</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="cnt_c" data-width="auto" class="selectpicker" onchange="check_cnt(this); return false;">
                                                    <option value="0" {? res && res.cnt == 0}selected="selected"{/}>제한 없음</option>
                                                    <option value="1" {? !res || res.cnt > 0}selected="selected"{/}>숫자 입력</option>
                                                </select>
                                                <div class="input-wrap" id="inputCnt" style="display: {? !res || res.cnt > 0}block{:}none{/}; padding: 6px 0 0 0;">
                                                    <input type="number" name="cnt" value="{res.cnt}" class="form-control input-xlarge" onKeyup="onlyNumberCom(this);" placeholder="인원 수를 임력해주세요"> 
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >요약 내용</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <textarea  rows="5" class="form-control" name="summary">{res.summary}</textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->
                                        
                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >상세 내용</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <textarea  rows="20" class="form-control con" name="con" id="con"></textarea>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >대표 이미지</div>
                                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                                <input type="hidden" name="img" id="img" value="">
                                                <img class="img-thumbnail" src="{?res.img}{res.img}?{=date('his')}{:}/img/default-img-event.png{/}" id="img_img" onclick="toggle_img();return false;">
                                                <div id="div_img_change" style="display: none;">
                                                    <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=img&r_width=300&r_height=300" ></iframe>
                                                </div>
                                                <span class="help-block">대표이미지는 리스트에 출력됩니다. 가로세로 300x300 픽셀 사이즈로 업로드 해주세요.</span>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >담당자 전화번호</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <input type="text" name="tel" value="{res.tel}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label" >담당자 주소</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <input type="text" name="addr" value="{res.addr}" class="form-control input-xlarge">
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">첨부 파일</div>
                                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                                <label class="file-inline">
                                                    {? res.file}<a href="/program/get_pr_source?ev={res.id}">{res.filename}</a> <input type="checkbox" name="del_file" value="{res.file}"> 파일 삭제{/}
                                                    <input type="file" name="file"> *8MB까지 업로드 가능합니다.
                                                </label> 
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">지원서 등록</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="app" data-width="auto" class="selectpicker">
                                                    <option value="0" {? res.app == 0}selected="selected"{/}>이용안함</option>
                                                    <option value="1" {? res.app == 1}selected="selected"{/}>이용</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">공개 여부</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="open" data-width="auto" class="selectpicker">
                                                    <option value="0" {? res.open == 0}selected="selected"{/}>비공개</option>
                                                    <option value="1" {? res.open == 1}selected="selected"{/}>공개</option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-2 col-md-2 control-label">승인 여부</div>
                                            <div class="col-xs-12 col-sm-10 col-md-10">
                                                <select name="status" data-width="auto" class="selectpicker">
                                                    <option value="0" {? res.status == 0}selected="selected"{/}>승인대기</option>
                                                    <option value="1" {? res.status == 1}selected="selected"{/}>승인</option>
                                                    <option value="2" {? res.status == 2}selected="selected"{/}>반려</option>
                                                </select>
                                                <div class="form-group-sub">
                                                    <input type="text" placeholder="반려의 경우, 사유를 적어주세요" id="inputReject" value="{res.status_des}" name="status_des" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /form-group -->

                                        <div class="form-group form-submit">
                                            <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                                <a href="#" onclick="go_cancel(this); return false;" class="btn btn-default">취소</a> 
                                                <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">확인</a> 
                                                
                                            </div>
                                        </div>

                                        <input type="hidden" name="o_status" value="{res.status}" />
                                        <input type="hidden" name="id" value="{res.id}" />
                                        <input type="hidden" name="user_id" value="{? res.user_id}{res.user_id}{:}{s.id}{/}" />
                                        <input type="hidden" name="content" id="content" value="" />
                                    </fieldset>
                                </form>
                            </div> 
                        </div>
                        <!-- /tab-content -->
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

<div class="modal fade" id="md-connectId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">담당자 권한과 연결하고자 하는 회원 검색  </h4>
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