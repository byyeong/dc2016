
<script type="text/javascript" src="/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
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
                tinyMCE.activeEditor.setContent("{? res.contents}{=safe_js_editor(res.contents)}{:}{=safe_js_editor(con)}{/}");
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
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span> 채용정보 입력</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" name="frm_board" method="post" onsubmit="return false;">
                            <input type="hidden" name="id" value="{res.id}" />
                            <input type="hidden" name="state" value="{res.state}" />
                            <input type="hidden" name="cnt_j" id="cnt_j" value="{?e_jo}{=sizeof(e_jo)}{:}1{/}" />
                            <input type="hidden" name="contents" id="contents" value="" />
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>채용정보 입력</legend>
                                    {? res.user_id == '22222'}
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회사명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" name="company" value="{res.s_name}" onkeydown="return ignoreEnter(event);">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회사 URL</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" name="s_url" value="{res.s_url}" onkeydown="return ignoreEnter(event);">
                                            
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >노출</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            <label class="checkbox-inline"><input type="radio" name="en" value="2" onkeydown="return ignoreEnter(event);" {? res.en == 2}checked="checked"{/}> 영문만 노출</label>
                                            <label class="checkbox-inline"><input type="radio" name="en" value="1" onkeydown="return ignoreEnter(event);" {? res.en == 1}checked="checked"{/}> 동시 노출 (*이 경우, 한국어 페이지에도 노출됩니다.)</label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    {:}
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회사</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="company" value="{? res.name}{res.name}{/}" onkeydown="return ignoreEnter(event);">
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default" onclick="find_com(this); return false;"><span class="icon-search"></span></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >작성자</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" name="user_name" value="{? res.mname}{res.mname}{:}{s.name}{/}" readonly onkeydown="return ignoreEnter(event);">
                                            <input type="hidden" class="form-control" name="user_id" value="{? res.user_id}{res.user_id}{:}{s.id}{/}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    {/}

                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >채용 공고 기간</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            
                                            <!--form-group-date -->
                                            <div class="form-group-date">
                                                <div class="bfh-datepicker" data-format="{? res.start}{res.start}{:}y.m.d{/}">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" placeholder="시작일" name="start" value="{res.start}" readonly onkeydown="return ignoreEnter(event);">
                                                    </div>
                                                </div>
     
                                                <span class="sim">&sim;</span>                                                
    
                                                <div class="bfh-datepicker" data-format="{? res.end}{res.end}{:}y.m.d{/}">
                                                    <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                        <input type="text" class="form-control datepicker" placeholder="종료일" name="end" value="{res.end}" readonly onkeydown="return ignoreEnter(event);">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /form-group-date -->
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >채용제목</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" placeholder="제목을 입력하세요" name="title" value="{res.title}" onkeydown="return ignoreEnter(event);">
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >채용내용</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <textarea rows="20" class="form-control" name="contents">{res.contents}</textarea>
                                        </div>
                                    </div>
                                    <!-- /form-group -->

                                    <div class="form-group"> 
                                        <span class="col-xs-12 col-sm-2 col-md-2 control-label">업무분야</span>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            {@ inv}
                                            <label class="checkbox-inline"><input type="checkbox" name="inv" value="{.id}" {? strstr(e_inv, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);">{._value}</label>
                                            {/}
                                        </div>
                                    </div>
                                    <!-- /form-group-->
                                    
                                    <!--div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >채용분야</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            {? sizeof(e_jo)}{@ e_jo}
                                            <p class="form-group-tag">
                                                <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                <input type="text" class="form-control suggest_job" placeholder="" name="job_{.key_ + 1}" value="{._value}" onkeydown="return ignoreEnter(event);">
                                            </p>
                                            {/}{:}
                                            <p class="form-group-tag">
                                                <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                                <input type="text" class="form-control suggest_job" placeholder="" name="job_1" onkeydown="return ignoreEnter(event);">
                                            </p>
                                            {/}
                                            <button class="btn btn-default btn-sm" onclick="add_job(this); return false;"><span class="icon-plus"></span> 분야 추가</button>
                                        </div>
                                    </div-->
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >지역</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            {@ local}
                                            <label class="checkbox-inline"><input type="checkbox" name="local" value="{.id}" {? strstr(e_lo, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                            {/}
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >경력</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            {@ career}
                                            <label class="checkbox-inline"><input type="checkbox" name="career" value="{.id}" {? strstr(e_ca, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                            {/} 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <!--div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >개발분야</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            {@ field}
                                            <label class="checkbox-inline"><input type="checkbox" name="field" value="{.id}" {? strstr(e_fi, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                            {/}
                                        </div>
                                    </div-->
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >기간</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            {@ period}
                                            <label class="checkbox-inline"><input type="checkbox" name="period" value="{.id}" {? strstr(e_pe, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                            {/}
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <!--div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >언어</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                            {@ lang}
                                            <label class="checkbox-inline"><input type="checkbox" name="lang" value="{.id}" {? strstr(e_la, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                            {/}
                                        </div>
                                    </div-->
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >상태 처리</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <select name="state" data-width="auto" class="selectpicker" >
                                                <option value="0" {? res.state == 0}selected="selected"{/}>승인대기</option>
                                                <option value="1" {? res.state == 1}selected="selected"{/}>승인</option>
                                                <option value="9" {? res.state == 9}selected="selected"{/}>비공개</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- /form-group-->
                                    
                                    
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

<!-- modal #searchStartup -->
<div class="modal fade" id="md-searchStartup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>
<!-- /modal #searchStartup -->
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
{? job}
$( ".suggest_job" ).autocomplete({source: {job}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}
    
function find_com(){

    var key = $('input[name=company]').val();
    var get_url = '/ajax_front/get_search_startup2/';
    var set_data ={
        "data" 		: key,
        "v" 		: 1,
    };
    
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {

            $('#md-searchStartup').html(_data);
            $('#md-searchStartup').modal('show');
        }
    });
}

function recive_com(_val){
    $('input[name=company]').val(_val);
    $('#md-searchStartup').modal('hide');
}

function enter_startup(){
    $('#md-compEditor_com').val($('#new_startup').val());
    $('#md-compEditor').modal('show');
}

function add_job(_this)
{   
    var v = $("#cnt_j").val();
    var get_url = "/ajax_front/recruit_add_job";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_j").val(parseInt(v)+1);
        {? job}
        $( ".suggest_job" ).autocomplete({source: {job}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}


function go()
{
    var frm = $('form[name=frm_board]');
    
    var t_local="";
    var lo_length = $('input[name=local]').length;
    for(var i=0; i < lo_length; i++){
        if(document.frm_board.local[i].checked) {
            t_local +=document.frm_board.local[i].value + ","
        }
    }
    
    var t_career="";
    var ca_length = $('input[name=career]').length;
    for(var i=0; i < ca_length; i++){
        if(document.frm_board.career[i].checked) {
            t_career +=document.frm_board.career[i].value + ","
        }
    }
    
    var t_field="";
    var fi_length = $('input[name=field]').length;
    for(var i=0; i < fi_length; i++){
        if(document.frm_board.field[i].checked) {
            t_field +=document.frm_board.field[i].value + ","
        }
    }
    
    var t_period="";
    var pe_length = $('input[name=period]').length;
    for(var i=0; i < pe_length; i++){
        if(document.frm_board.period[i].checked) {
            t_period +=document.frm_board.period[i].value + ","
        }
    }
    
    var t_lang="";
    var la_length = $('input[name=lang]').length;
    for(var i=0; i < la_length; i++){
        if(document.frm_board.lang[i].checked) {
            t_lang +=document.frm_board.lang[i].value + ","
        }
    }

    var t_inv="";
    var in_length = $('input[name=inv]').length;
    for(var i=0; i < in_length; i++){
        if(document.frm_board.inv[i].checked) {
            t_inv +=document.frm_board.inv[i].value + ","
        }
    }
    
    var temp_lo = '<input type="hidden" name="t_local" value="'+t_local.substring(0, t_local.length-1)+'" />';
    var temp_ca = '<input type="hidden" name="t_career" value="'+t_career.substring(0, t_career.length-1)+'" />';
    var temp_fi = '<input type="hidden" name="t_field" value="'+t_field.substring(0, t_field.length-1)+'" />';
    var temp_pe = '<input type="hidden" name="t_period" value="'+t_period.substring(0, t_period.length-1)+'" />';
    var temp_la = '<input type="hidden" name="t_lang" value="'+t_lang.substring(0, t_lang.length-1)+'" />';
    var temp_in = '<input type="hidden" name="t_inv" value="'+t_inv.substring(0, t_inv.length-1)+'" />';
    
    frm.append(temp_lo);
    frm.append(temp_ca);
    frm.append(temp_fi);
    frm.append(temp_pe);
    frm.append(temp_la);
    frm.append(temp_in);

    document.getElementById("contents").value = tinyMCE.activeEditor.getContent();
    document.frm_board.submit();
}
//]]>
</script>