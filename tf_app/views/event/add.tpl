{? (s.per & settings->permission4) == settings->permission4 || (s.per & settings->permission1) == settings->permission1}
<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        relative_urls : false,
        remove_script_host : false,
        mode : "textareas",
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
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.contents)}");
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
{/}

<!-- rowContent -->
<div class="rowContent"  id="event"> 
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h2><a href="/event">Event</a></h2>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container">
        
            <!-- editor -->
            <div class="editor">
                <div class="edit-header"><h3><span class="icon-pencil"></span> 이벤트 작성하기</h3></div>
                <div class="edit-body">
                {? (s.per & settings->permission4) == settings->permission4 || (s.per & settings->permission1) == settings->permission1}
                <form class="form-horizontal" role="form" action="/event/add_process/{res.id}" method="post" name="add_event_f" onsubmit="return false;" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="{res.id}" />
                    <input type="hidden" name="state" value="0" />
                    <input type="hidden" name="user_name" value="{? res.mname}{res.mname}{:}{s.name}{/}" >
                    <input type="hidden" name="user_id" value="{? res.user_id}{res.user_id}{:}{s.id}{/}" >
                    <input type="hidden" name="contents" id="contents" value="" />
                    <fieldset>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">행사명</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                 <input type="text" class="form-control input-xlarge" name="title" value="{res.title}"  > 
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >성격</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <select name="type_id" data-width="auto" class="selectpicker" >
                                    {@ type}
                                    <option value="{.id}" {? res.type_id == .id}selected="selected"{/}>{.name}</option>
                                    {/}
                                </select>
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >이벤트 장소</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <select name="space" data-width="auto" class="selectpicker" onchange="check_space(this); return false;">
                                    <option value="1" {? res.space_id != 0}selected="selected"{/}>D.CAMP 시설</option>
                                    <option value="0" {? res && res.space_id == 0}selected="selected"{/}>외부시설</option>
                                </select>
                                
                                <span id="space_id">
                                    <select name="space_id" data-width="auto" class="selectpicker" >
                                        {@ space}
                                        <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{.name} {.opt}F</option>
                                        {/}
                                     </select>
                                </span>

                                <div class="well" id="space_b" {? res && res.space_id == 0}style="display: none;"{:}{/}> 
                                    <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#md-mySpace">내 공간공유 연계하기</button>
                                    <p class="help-block">
                                        D.CAMP시설을 이용할 경우 공간공유신청을 먼저 해주세요. 공간공유신청이 없을 경우, 반려될 수 있습니다. &nbsp;
                                        <a href="/space"><i class="fa fa-caret-right"></i> 공간공유 신청하기</a>
                                    </p>
                                </div>

                                <div class="input-wrap" id="inputPlace" {? res && res.space_id == 0}{:}style="display: none;"{/}>
                                    <input type="text" class="form-control" name="space_etc" value="{res.space_etc}" id="inputPlace" placeholder="장소이름을 적어주세요" >
                                </div>
                                
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">행사 일정</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9"> 
                                
                                <!-- datepicker -->
                                <div class="bfh-datepicker" data-format="y.m.d">
                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                        <input type="text" class="form-control datepicker" name="date" value="{res.date}" readonly>
                                    </div>
                                </div>
                                <!-- /datepicker --> 
                                
                                <!-- timepicker -->
                                <div class="bfh-timepicker" data-time="{? res.start}{res.start}{:}10:00{/}" >
                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                        <input type="text" class="form-control timepicker" placeholder="시작시간" name="start" value="{res.start}" maxlength="5" onKeyup="onlyNumber(this);">
                                    </div>
                                </div>
                                <!-- /timepicker --> 
                                
                                <span class="sim">&sim;</span> 
                                
                                <!-- datepicker -->
                                <div class="bfh-datepicker" data-format="y.m.d">
                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                        <input type="text" class="form-control datepicker" name="date_e" value="{res.date_e}" readonly>
                                    </div>
                                </div>
                                <!-- /datepicker --> 
                                
                                <!-- timepicker -->
                                <div class="bfh-timepicker" data-time="{? res.end}{res.end}{:}19:00{/}" >
                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                        <input type="text" class="form-control timepicker" placeholder="종료시간" name="end" value="{res.end}" maxlength="5" onKeyup="onlyNumber(this);">
                                    </div>
                                </div>
                                <!-- /timepicker --> 
                                
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">행사 등록일 (접수기간)</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9"> 
                                
                                <!-- datepicker -->
                                <div class="bfh-datepicker" data-format="y.m.d">
                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                        <input type="text" class="form-control datepicker" name="apply_start" value="{=substr(res.apply_start,0, 10)}" readonly>
                                    </div>
                                </div>
                                <!-- /datepicker --> 
                                
                                <!-- timepicker -->
                                <div class="bfh-timepicker" data-time="{? res.apply_start}{=substr(res.apply_start,11, 5)}{:}10:00{/}" >
                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                        <input type="text" class="form-control timepicker" name="apply_s_time" value="{=substr(res.apply_start, 11, 5)}" placeholder="시작시간" maxlength="5" onKeyup="onlyNumber(this);">
                                    </div>
                                </div>
                                <!-- /timepicker --> 
                                <span class="sim">&sim;</span> 
                                
                                <!-- datepicker -->
                                <div class="bfh-datepicker" data-format="y.m.d">
                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                        <input type="text" class="form-control datepicker" name="apply_end" value="{=substr(res.apply_end, 0, 10)}" readonly>
                                    </div>
                                </div>
                                <!-- /datepicker --> 
                                
                                <!-- timepicker -->
                                <div class="bfh-timepicker" data-time="{? res.apply_end}{=substr(res.apply_end,11, 5)}{:}19:00{/}" >
                                    <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                        <input type="text" class="form-control timepicker" name="apply_e_time" value="{=substr(res.apply_end, 11, 5)}" placeholder="종료시간" maxlength="5" onKeyup="onlyNumberCom(this);">
                                    </div>
                                </div>
                                <!-- /timepicker --> 
                                
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >인원</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9"> 
                            
                                <div class="input-group-wrap">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="inputPersons" name="cnt" value="{res.cnt}">
                                        <span class="input-group-addon">명</span> </div>
                                </div>
                                
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >요약내용</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <input type="text" class="form-control" id="inputSummary" name="summary" value="{res.summary}">
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >상세내용</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <textarea  rows="20" class="form-control" id="inputDesc" name="contents" >{res.contents}</textarea>
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label" >대표 이미지</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <input type="hidden" name="pic" id="pic" value="">
                                <img class="img-thumbnail" src="{?res.picture}{res.picture}?{=date('his')}{:}/img/default-img-event.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                <div id="div_img_change" style="display: none;">
                                    <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                </div>
                                <span class="help-block">대표이미지는 리스트에 출력됩니다. 가로세로 300x300 픽셀 사이즈로 업로드 해주세요.</span>
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">유/무료</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9"> 
                                <select name="price_type" data-width="auto" class="selectpicker" onchange="check_price(this); return false;">
                                    <option value="0" {? res.price == 0}selected="selected"{/}>무료</option>
                                    <option value="1" {? res.price != 0}selected="selected"{/}>유료</option>
                                </select> 
                                    
                                <div class="input-group-wrap" {? res.price == 0}style="display: none;"{/} id="price_box">
                                    <label class="sr-only" for="inputMoney">금액입력</label>
                                    <div class="input-group"> <span class="input-group-addon">&#8361;</span>
                                        <input type="text" class="form-control" id="inputMoney" placeholder="참가비용" name="price" value="{res.price}">
                                        <span class="input-group-addon">원</span> 
                                    </div>
                                </div> 
                                    
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">결제방식</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <!--
                                <label class="checkbox-inline">
                                    <input type="checkbox" id="inlineCheckbox1" value="1" name="payment1" {? (res.payment & settings->payment1) == settings->payment1}checked="checked"{/}>
                                    전체 </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" id="inlineCheckbox2" value="2" name="payment2" {? (res.payment & settings->payment2) == settings->payment2}checked="checked"{/}>
                                    무통장입금 </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" id="inlineCheckbox3" value="4" name="payment3" {? (res.payment & settings->payment3) == settings->payment3}checked="checked"{/}>
                                    카드결제 </label>//-->
                                <label class="checkbox-inline">
                                    <input type="checkbox" id="inlineCheckbox3" value="8" name="payment4" checked>
                                    현장접수  (*이후 다른 결제 방법도 지원 예정)</label> 
                            </div>
                        </div>
                        <!-- /form-group -->
                        
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참여자 등록 방법</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                            
                                <select name="enroll" data-width="auto" class="selectpicker" onchange="check_enroll(this); return false;">
                                    <option value="1" {? res.enroll == 1}selected="selected"{/}>온라인 등록</option>
                                    <option value="2" {? res.enroll == 2}selected="selected"{/}>현장 등록</option>
                                    <option value="3" {? res.enroll == 3}selected="selected"{/}>외부참여 등록</option>
                                </select>
                                        
                                <div class="input-wrap" id="enroll_box" {? res.enroll != 3}style="display: none;"{/}>
                                    <label class="sr-only" for="inputUrl">외부신청URL</label>
                                    <input type="text" class="form-control input-inline" id="inputUrl" placeholder="URL을 입력해 주세요" name="enroll_url" value="{res.enroll_url}">
                                </div>
                            </div>
                        </div>
                        <!-- /form-group -->

                        <!--
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">접수그룹명</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <input type="text" class="form-control" >
                            </div>
                        </div>
                        //-->
                        
                        <!--
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">참여 선정 방법</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <label class="radio-inline">
                                    <input type="radio" name="enroll_type" value="1" {? res.enroll_type == 1 || !res}checked="checked"{/}>
                                    선착순</label>
                                
                                <label class="radio-inline">
                                    <input type="radio" name="enroll_type" value="0" {? res.enroll_type == 0}checked="checked"{/}>
                                    관리자 선정</label>
                            </div>
                        </div>
                        //-->
                        <!-- /form-group -->
                        <!--
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">공개 설정</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                            
                                <div class="row form-control-static">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">모임 목록 노출 </div>
                                    <div class="col-md-6">
                                        <label class="radio-inline">
                                            <input type="radio" name="visible_list" value="1" {? res.visible_list == 1 || !res}checked="checked"{/}>
                                            보임</label>
                                        <label class="radio-inline">
                                            <input type="radio" name="visible_list" value="0" {? res.visible_list == 0}checked="checked"{/}>
                                            숨김</label>
                                    </div>
                                </div>
                                
                                <div class="row form-control-static">
                                    <div class="col-xs-12 col-sm-3 col-md-3 control-label">모임 공개 여부</div>
                                    <div class="col-md-6">
                                        <label class="radio-inline">
                                            <input type="radio" name="open" value="1" {? res.open == 1 || !res}checked="checked"{/}>
                                            공개</label>
                                        <label class="radio-inline">
                                            <input type="radio" name="open" value="0" {? res.open == 0}checked="checked"{/}>
                                            비공개</label>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        //-->
                        <!-- /form-group -->
                        
                        <div class="form-group form-group-end">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">연락처 및 알림</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <p> <span class="control-label  sr-only">주최자 전화번호</span>
                                    <input type="tel" class="form-control" placeholder="주최자 전화번호" name="info_tel" value="{res.info_tel}">
                                </p>
                                <p> <span class="control-label  sr-only">이메일 주소</span>
                                    <input type="email" class="form-control" placeholder="이메일 주소" name="info_email" value="{res.info_email}">
                                </p>
                                <!--
                                <p> <span class="control-label sr-only">모임 개설 알림</span>
                                    <input type="text" class="form-control" placeholder="모임 개설 알림">
                                    </span> </p>//-->
                            </div>
                        </div>
                        <!-- /form-group -->

                        <div class="form-group">
                            <div class="col-xs-12 col-sm-3 col-md-3 control-label">자료 파일</div>
                            <div class="col-xs-12 col-sm-9 col-sm-9">
                                <label class="file-inline">
                                    {? res.file}<a href="/event/get_ev_source?ev={res.id}&file={res.filename}">{res.filename}</a> <input type="checkbox" name="del_file" value="{res.file}">파일 삭제{/}
                                    <input type="file" name="file"> *8MB까지 업로드 가능합니다.
                                </label> 
                            </div>
                        </div>
                        <!-- /form-group -->

                        {? !res || res.date > date('Y.m.d')}
                        <div class="form-group form-submit">
                            <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9"> 
                                {? res.id}
                                <p class="text-danger"> 재신청 시, 다시 승인을 받아야 합니다. </p>
                                <a href="#" onclick="javascript:location.href='/?c=event'" class="btn btn-default">취소</a> 
                                <a href="#" onclick="go(); return false;" class="btn btn-primary">재확인</a>  
                                <span class="pull-right"><a class="btn btn-warning" href="#" onclick="del_confirm('del_event({res.id})'); return false;">삭제</a> </span>
                                {:}
                                <a href="#" onclick="javascript:document.location.href='/'" class="btn btn-default">취소</a> 
                                <a href="#" onclick="go(); return false;" class="btn btn-primary">확인</a> 
                                {/}
                            </div>
                        </div>
                        {/}    
                        <input type="hidden" name="enroll_type" value="1" />
                        <input type="hidden" name="visible_list" value="1" />
                        <input type="hidden" name="open" value="1" />
                        <input type="hidden" name="p_space" value="{res.p_space}" />
                    </fieldset>
                </form>
                {:}
                {? s}
                <div class="alert alert-warning text-center">
                    <p>이벤트 신청은 멤버십 회원에게만 제공됩니다.  <br>멤버십에 먼저 가입해주세요.</p><br>
                    <a href="/membership" class="btn btn-default btn-sm">멤버십 가입하기</a>
                </div>
                {:}
                <div class="alert alert-warning text-center">
                    <p>이벤트 신청은 디캠프 멤버십 회원에게 제공됩니다. <br>이미 가입하셨다면 로그인 후 진행해주세요.</p><br>
                    <a href="/login" class="btn btn-default  btn-sm">로그인하기</a>
                </div>
                {/}
                {/}
                </div>
            </div>
            <!-- /editor -->
             
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 

<!-- Modal -->
<div class="modal fade" id="md-mySpace" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">내 공간공유 연계하기</h4>
            </div>
            <div class="modal-body">
                <p>공간공유를 신청한 목록입니다. 아래의 목록에서 선택해주세요.</p>
                <select class="form-control" name="pre_space">
                    {? sp}
                    {@ sp}
                    <option value="{.id}">{.purpose} / {.date} {.start} ~ {.end} / {.name} {.opt}</option>
                    {/}
                    {:}
                    <option>등록된 공간공유 신청이 없습니다.</option>
                    {/}
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="go_space(); return false;">저장</button>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
//<![CDATA[

function go_space()
{
    _id = $('select[name=pre_space] option:selected').val();
    // console.log(_id);
    // return false;
    window.location.href="/event/add?sp="+_id;
}

function del_event(_id)
{
    location.href='/event/del_event/'+_id;
}
    
function check_space(_this)
{
    var check = $(_this).val();
    if (check === "0") {
        $('#inputPlace').show();
        $('#space_id').hide();
        $('#space_b').hide();
    }
    else {
        $('#space_id').show();
        $('#space_b').show();
        $('#inputPlace').hide();
    }
}

function check_price(_this)
{
    var check = $(_this).val();
    if (check === "1") {
        $('#price_box').show();
    }
    else {
        $('#price_box').hide();
        $('#inputMoney').val(0);
    }
}

function check_enroll(_this)
{
    var check = $(_this).val();
    if (check === "3") {
        $('#enroll_box').show();
    }
    else {
        $('#enroll_box').hide();
    }
}


function go()
{
    if (!$('input[name=title]').val()) {
        alert("행사명을 입력해주세요.");
        document.add_event_f.title.focus();
        return false;
    }

    if (!$('input[name=date]').val()) {
        alert("행사 시작일을 입력해주세요.");
        document.add_event_f.date.focus();
        return false;
    }

    if (!$('input[name=date_e]').val()) {
        alert("행사 종료일을 입력해주세요.");
        document.add_event_f.date_e.focus();
        return false;
    }

    if (!$('input[name=apply_start]').val()) {
        alert("행사 등록 시작일을 입력해주세요.");
        document.add_event_f.apply_start.focus();
        return false;
    }

    if (!$('input[name=apply_end]').val()) {
        alert("행사 등록 마감일을 입력해주세요.");
        document.add_event_f.apply_end.focus();
        return false;
    }

    if (!$('input[name=cnt]').val()) {
        alert("인원을 입력해주세요.");
        document.add_event_f.cnt.focus();
        return false;
    }

    var now = new Date(); 
    var todayAtMidn = new Date(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes());
    
    var _e_s_date = new Date($('input[name=date]').val().substr(0,4),($('input[name=date]').val().substr(5,2)-1),$('input[name=date]').val().substr(8,2), $('input[name=start]').val().substr(0,2), $('input[name=start]').val().substr(3,2));
    var _e_e_date = new Date($('input[name=date_e]').val().substr(0,4),($('input[name=date_e]').val().substr(5,2)-1),$('input[name=date_e]').val().substr(8,2), $('input[name=end]').val().substr(0,2), $('input[name=end]').val().substr(3,2));
    var _a_s_date = new Date($('input[name=apply_start]').val().substr(0,4),($('input[name=apply_start]').val().substr(5,2)-1),$('input[name=apply_start]').val().substr(8,2), $('input[name=apply_s_time]').val().substr(0,2), $('input[name=start]').val().substr(3,2));
    var _a_e_date = new Date($('input[name=apply_end]').val().substr(0,4),($('input[name=apply_end]').val().substr(5,2)-1),$('input[name=apply_end]').val().substr(8,2), $('input[name=apply_e_time]').val().substr(0,2), $('input[name=apply_e_time]').val().substr(3,2));
    
    if (_e_s_date.getTime() >= _e_e_date.getTime())
    {
        alert("행사 종료 시간이 시작 시간보다 빠릅니다.");
        document.add_event_f.date.focus();
        return false;
    }
    
    if (_a_s_date.getTime() >= _a_e_date.getTime())
    {
        alert("행사 등록 종료 시간이 시작 시간보다 빠릅니다.");
        document.add_event_f.apply_start.focus();
        return false;
    }
    
    if (todayAtMidn.getTime() > _e_s_date.getTime())
    {
        alert("행사 시작 시간이 현재 시간보다 빠릅니다.");
        document.add_event_f.date_e.focus();
        return false;
    }
    
    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    document.add_event_f.submit();
}

//]]>
</script>