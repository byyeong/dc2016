
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
<script type="text/javascript">
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
    
        document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
        document.add_event_f.submit();
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
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> 이벤트 정보입력</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" action="/admin_event/add_process/{res.id}" method="post" name="add_event_f" onsubmit="return false;" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="state" value="{res.state}" />
                            <input type="hidden" name="contents" id="contents" value="" />
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>이벤트 정보입력</legend>
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >개설자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" name="user_name" value="{? res.mname}{res.mname}{:}{s.name}{/}" >
                                            <input type="hidden" class="form-control" name="user_id" value="{? res.user_id}{res.user_id}{:}{s.id}{/}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >카테고리</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" name="category" value="{res.category}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >대표 이미지</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="hidden" name="pic" id="pic" value="">
                                            <!--<iframe width="100%" scrolling="no" height="300px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/pic/300x300?old={=safe_js(res.picture)}" allowtransparency="true"></iframe>//-->
                                            <img class="img-thumbnail" src="{?res.picture}{res.picture}?{=date('his')}{:}/img/common/300x300.png{/}" id="pic_img" onclick="toggle_img();return false;">
                                            <div id="div_img_change" style="display: none;">
                                                <iframe  height="600" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?which=pic&r_width=300&r_height=300" ></iframe>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">    
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >이벤트 장소</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <!-- form-group-sub -->
                                            <div class="form-inline form-group-sub">
                                                <select name="space" data-width="auto" class="selectpicker" onchange="check_space(this); return false;">
                                                    <option value="1" {? res.space_id != 0}selected="selected"{/}>D.CAMP 시설</option>
                                                    <option value="0" {? res && res.space_id == 0}selected="selected"{/}>외부시설</option>
                                                </select> 
                                                
                                                &nbsp;&nbsp;
                                                
                                                <!-- TODO : '내부장소'일때 노출 -->
                                                <span id="space_id" {? !res || res.space_id != 0}{:}style="display: none;"{/}>
                                                    <select name="space_id" data-width="auto" class="selectpicker" >
                                                       {@ space}
                                                       <option value="{.id}" {? res.space_id == .id}selected="selected"{/}>{.name} {.opt}F</option>
                                                       {/}
                                                    </select> 
                                                </span>
                                                <!-- /TODO --> 
                                                
                                                <!-- TODO : '외부장소'일때 노출 -->
                                                <span id="inputPlace" {? res && res.space_id == 0}{:}style="display: none;"{/}>
                                                    <label class="sr-only" for="inputPlace">장소이름</label>
                                                    <input type="text" class="form-control"  placeholder="장소이름을 적어주세요" name="space_etc" value="{res.space_etc}" >
                                                </span>
                                                <!-- /TODO -->                                            
                                            
                                            </div>
                                            <!-- /form-group-sub -->
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >성격</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">  
                                                <select name="type_id" data-width="auto" class="selectpicker" >
                                                    {@ type}
                                                    <option value="{.id}" {? res.type_id == .id}selected="selected"{/}>{.name}</option>
                                                    {/}
                                                </select>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >행사명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control"  class="input-xlarge" name="title" value="{res.title}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                            
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >행사 일정</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                             
                                             
                                             <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
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
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
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
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >행사 접수기간</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                             
                                             <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="apply_start" value="{=substr(res.apply_start,0, 10)}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 
    
                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.apply_start}{=substr(res.apply_start,11, 5)}{:}10:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                    <input type="text" class="form-control timepicker" placeholder="시작시간" name="apply_s_time" value="{=substr(res.apply_start,11, 5)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                </div>
                                            </div>
                                            <!-- /timepicker -->

                                            <span class="sim">&sim;</span>  
                                            
                                            <!-- datepicker -->
                                            <div class="bfh-datepicker" data-format="y.m.d">
                                                <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                    <input type="text" class="form-control datepicker" name="apply_end" value="{=substr(res.apply_end, 0, 10)}" readonly>
                                                </div>
                                            </div>
                                            <!-- /datepicker --> 

                                            <!-- timepicker -->
                                            <div class="bfh-timepicker" data-time="{? res.apply_end}{=substr(res.apply_end,11, 5)}{:}19:00{/}" >
                                                <div class="input-group bfh-timepicker-toggle" data-toggle="bfh-timepicker"> <span class="input-group-addon"><span class="icon-time"></span></span>
                                                    <input type="text" class="form-control timepicker" placeholder="종료시간" name="apply_e_time" value="{=substr(res.apply_end,11, 5)}" maxlength="5" onKeyup="onlyNumber(this);">
                                                </div>
                                            </div>
                                            <!-- /timepicker -->
 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >인원</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">  
                                            <!-- lenght-number -->
                                            <div class="input-group length-number">
                                                <input type="number" class="form-control" id="inputPersons" name="cnt" value="{res.cnt}" >
                                                <span class="input-group-addon">명</span> 
                                            </div>
                                            <!-- /lenght-number --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >요약내용</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <input type="text" class="form-control" id="inputSummary" name="summary" value="{res.summary}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >상세내용</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <textarea  rows="30" class="form-control" id="inputDesc" name="contents" >{res.contents}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >유/무료</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                        
                                            <!-- form-sub-line -->
                                            <div class="form-inline form-sub-line"> 
                                                    <select name="price_type" data-width="auto" class="selectpicker" onchange="check_price(this); return false;">
                                                        <option value="0" {? res.price == 0}selected="selected"{/}>무료</option>
                                                        <option value="1" {? res.price != 0}selected="selected"{/}>유료</option>
                                                    </select> 
                                                
                                                <!-- lenght-number --> 
                                                <!-- TODO : '유료'일때 노출 -->
                                                <div class="form-group" {? res.price == 0}style="display: none;"{/} id="price_box">
                                                    <label class="sr-only" for="inputMoney">금액입력</label>
                                                    <div class="input-group length-money"> <span class="input-group-addon">&#8361;</span>
                                                        <input type="text" class="form-control" id="inputMoney" name="price" value="{res.price}">
                                                    </div>
                                                </div>
                                                <!-- /lenght-number -->                                                 
                                            </div>
                                            <!-- /form-sub-line -->
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >결제방식</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <!--
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox1" value="1" name="payment1" {? (res.payment & settings->payment1) == settings->payment1}checked="checked"{/}>
                                                전체 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox2" value="2" name="payment2" {? (res.payment & settings->payment2) == settings->payment2}checked="checked"{/}>
                                                무통장입금 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox3" value="4" name="payment3" {? (res.payment & settings->payment3) == settings->payment3}checked="checked"{/}>
                                                카드결제 </label>
                                            //-->
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox3" value="8" name="payment4" checked>
                                                현장접수 </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >참여자 등록 방법</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                        
                                            <!-- form-sub-line -->
                                            <div class="form-inline form-sub-line">
                                            
                                                <select name="enroll" data-width="auto" class="selectpicker" onchange="check_enroll(this); return false;">
                                                    <option value="1" {? res.enroll == 1}selected="selected"{/}>온라인 등록</option>
                                                    <option value="2" {? res.enroll == 2}selected="selected"{/}>현장 등록</option>
                                                    <option value="3" {? res.enroll == 3}selected="selected"{/}>외부참여 등록</option>
                                                </select>
                                            
                                                <!-- TODO : '외부참여등록'일때 노출 -->
                                                <div class="form-group" id="enroll_box" {? res.enroll != 3}style="display: none;"{/}>
                                                    <label class="sr-only" for="inputUrl">외부신청URL</label>
                                                    <input type="text" class="form-control" id="inputUrl" placeholder="URL을 입력해 주세요" name="enroll_url" value="{res.enroll_url}" >
                                                </div>
                                                <!-- /TODO --> 
                                                
                                            </div>
                                            <!-- /form-sub-line -->
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <!--
                                    <div class="form-group"> <span class="col-lg-3 control-label">접수그룹명</span>
                                        <div class="col-lg-5">
                                            <input type="text" class="form-control" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >참여 선정 방법</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <label class="radio-inline">
                                                <input type="radio" name="enroll_type" value="1" {? res.enroll_type == 1}checked="checked"{/}>
                                                선착순</label>
                                            <label class="radio-inline">
                                                <input type="radio" name="enroll_type" value="0" {? res.enroll_type == 0}checked="checked"{/}>
                                                관리자 선정</label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >북 프로모션</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <label class="checkbox-inline">
                                                <input type="checkbox" value="1" name="is_profile" {? res.is_profile == 1}checked="checked"{/}>
                                                프로필 정보 입력 독려 (체크 시, 이벤트 신청할 때 사용자 프로필 수정 페이지 열림) </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >공개 설정</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <div class="form-group-sub"> 
                                                <label class="form-control-static">모임 목록 노출</label>                                                
                                                <label class="radio-inline"><input type="radio" name="visible_list" value="1" {? res.visible_list == 1}checked="checked"{/}> 보임</label>
                                                <label class="radio-inline"><input type="radio" name="visible_list" value="0" {? res.visible_list == 0}checked="checked"{/}> 숨김</label>
                                               </div>
                                            <!-- /form-group-sub -->  
                                            <div class="form-group-sub">
                                                <label class="form-control-static">모임 공개 여부</label>
                                                <label class="radio-inline"><input type="radio" name="open" value="1" {? res.open == 1}checked="checked"{/}> 공개</label>
                                                <label class="radio-inline"><input type="radio" name="open" value="0" {? res.open == 0}checked="checked"{/}> 비공개</label> 
                                            </div>
                                            <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >연락처 및 알림</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">            
                                            <div class="input-group"> 
                                                <span class="input-group-addon"><span class="icon-fixed-width icon-phone"></span></span> 
                                                <input type="tel" class="form-control" name="info_tel" value="{res.info_tel}" placeholder="주최자 전화번호"> 
                                            </div>
                                            <!-- /input-group-->
                                            
                                            <div class="input-group"> 
                                                <span class="input-group-addon"><span class=" icon-fixed-width icon-envelope-alt"></span></span>
                                                <input type="email" class="form-control" name="info_email" value="{res.info_email}" placeholder="이메일 주소">                                                 
                                            </div>
                                            <!-- /input-group -->                                             
                                            <!--
                                            <div class="form-group-sub form-control-static">    
                                                <label>모임 개설 알림</label> 
                                                <input type="text" class="form-control" name="info_noti" value="{res.info_noti}"> 
                                            </div>
                                            <!-- /form-group-sub
                                             //-->
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >자료 파일</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <label class="file-inline">
                                                {? res.file}<a href="/event/get_ev_source?ev={res.id}&file={res.filename}">{res.filename}</a> <input type="checkbox" name="del_file" value="{res.file}">파일 삭제{/}
                                                <input type="file" name="file"> *8MB까지 업로드 가능합니다.
                                            </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            <!-- panel-footer-->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary" onclick="go(); return false;">등록</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer-->
                        </form>
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

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
function check_space(_this)
{
    var check = $(_this).val();
    if (check === "0") {
        $('#inputPlace').show();
        $('#space_id').hide();
    }
    else {
        $('#space_id').show();
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

//]]>
</script>