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
<!-- rowContent -->
<div class="rowContent"  id="recruit"> 
    <div class="page-header">
            <div class="container">
                <h2><a href="../recruit/">Recruit</a></h2>
                <button onclick="location.href='../recruit/add'" class="btn btn-primary pull-right"> <span class="icon-pencil"></span> 채용정보 작성하기</button>
            </div>
        </div>
    <!-- /page-header -->  
    
    <div class="page-content">  
        <div class="container">
            
            <!-- editor -->
            <div class="editor">
                <div class="edit-header"><h3><span class="icon-pencil"></span> 채용공고 작성하기</h3></div>
                <div class="edit-body">
                    
                    {? !no_permit}
                    <form class="form-horizontal" role="form" name="frm_board" {? ok}style="display: none;"{/} method="post" onsubmit="return false;">
                        <input type="hidden" name="id" value="{res.id}" />
                        <input type="hidden" name="state" value="{res.state}" />
                        <input type="hidden" name="user_id" value="{? res.user_id}{res.user_id}{:}{s.id}{/}" />
                        <input type="hidden" name="cnt_j" id="cnt_j" value="{?e_jo}{=sizeof(e_jo)}{:}1{/}" />
                        <input type="hidden" name="contents" id="contents" value="" />
                        <fieldset>
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">회사</div>
                                <div class="col-xs-12 col-sm-3 col-md-3">
                                    <select class="selectpicker" data-width="auto" name="startup_id">
                                        {@ my_st}
                                        <option value="{.startup_id}" {? res.startup_id == .startup_id}selected="selected"{/}>{.sname}</option>
                                        {/}
                                    </select>
                                </div>
                            </div>
                            <!-- /form-group -->
                                
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label"> 채용 공고 기간 </div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
    
                                    <!-- form-group-date -->
                                    <div class="form-group-date "> 
                                        <!-- datepicker -->
                                        <div class="bfh-datepicker" data-format="{? res.start}{res.start}{:}y.m.d{/}">
                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                <input type="text" class="form-control datepicker" placeholder="시작일" name="start" value="{res.start}" readonly onkeydown="return ignoreEnter(event);">
                                            </div>
                                        </div>
                                        <!-- /datepicker --> 
                                        <span class="date-sim">&sim;</span> 
                                        <!-- datepicker -->
                                        <div class="bfh-datepicker" data-format="{? res.end}{res.end}{:}y.m.d{/}">
                                            <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                                <input type="text" class="form-control datepicker" placeholder="종료일" name="end" value="{res.end}" readonly onkeydown="return ignoreEnter(event);">
                                            </div>
                                        </div>
                                        <!-- /datepicker --> 
                                    </div>
                                    <!-- /form-group-date -->                                     
                                </div>
                            </div>
                            <!-- /form-group -->
    
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">채용제목</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    <input type="text" class="form-control input-xlarge" placeholder="제목을 입력하세요" name="title" value="{res.title}" onkeydown="return ignoreEnter(event);">
                                </div>
                            </div>
                            <!-- /form-group -->
    
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">내용</div>
                                <div class="col-xs-12 col-sm-9 col-md-9"> 
                                    <textarea rows="20" class="form-control" name="contents">{res.contents}</textarea>
                                </div>
                            </div>
                            <!-- /form-group -->
    
                            <div class="form-group"> 
                                <span class="col-xs-12 col-sm-3 col-md-3 control-label">업무분야</span>
                                <div class="col-xs-12 col-sm-9 col-md-9">
                                    {@ inv}
                                    <label class="checkbox-inline"><input type="checkbox" name="inv" value="{.id}" {? strstr(e_inv, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);">{._value}</label>
                                    {/}
                                </div>
                            </div>
                            <!-- /form-group-->

                            <!--div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">채용분야</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">
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
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">지역</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">  
                                    {@ local}
                                    <label class="checkbox-inline"><input type="checkbox" name="local" value="{.id}" {? strstr(e_lo, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                    {/}
                                </div>
                            </div>
                            <!-- /form-group -->
    
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">경력</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">  
                                    {@ career}
                                    <label class="checkbox-inline"><input type="checkbox" name="career" value="{.id}" {? strstr(e_ca, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                    {/}
                                </div>
                            </div>
                            <!-- /form-group -->
    
                            <!--div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">개발분야</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">  
                                    {@ field}
                                    <label class="checkbox-inline"><input type="checkbox" name="field" value="{.id}" {? strstr(e_fi, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                    {/}
                                </div>
                            </div-->
                            <!-- /form-group -->
    
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">기간</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">  
                                    {@ period}
                                    <label class="checkbox-inline"><input type="checkbox" name="period" value="{.id}" {? strstr(e_pe, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                    {/}
                                </div>
                            </div>
                            <!-- /form-group -->
    
                            <!--div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">언어</div>
                                <div class="col-xs-12 col-sm-9 col-md-9">  
                                    {@ lang}
                                    <label class="checkbox-inline"><input type="checkbox" name="lang" value="{.id}" {? strstr(e_la, ._value)}checked="checked"{/} onkeydown="return ignoreEnter(event);"> {._value}</label>
                                    {/}
                                </div>
                            </div-->
                            <!-- /form-group -->                           
    
                            <div class="form-group form-submit">
                                <div class="col-xs-12 col-sm-offset-3 col-sm-9 col-md-offset-3 col-md-9"> 
                                    {? res}
                                    <a href="#" class="btn btn-warning pull-right" onclick="go_del(); return false;">삭제</a> 
                                    {:}
                                    <a href="#" class="btn btn-default" onclick="javascript:document.location.href='/?c=recruit'">취소</a> 
                                    {/}
                                    <a href="#" class="btn btn-primary" onclick="go();">확인</a> 
                                </div>
                            </div>
                        </fieldset>
                    </form> 
                                
                    <div id="applyE_res" {? !ok}style="display: none;"{/}>
                        <div class="col-xs-12 col-sm-12 col-md-offset-2 col-md-8 complete" > 
                            <h4 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  신청완료!!</h4>
                            <div class="well text-center">채용공고 신청이 완료되었습니다.</div>
                            <div class="text-center"><a href="/" class="btn btn-default">홈으로</a></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    {:}
                    <div id="applyE_res" >
                        <div class="col-xs-12 col-sm-12 col-md-offset-2 col-md-8 complete"> 
                            <h4 class="text-center"><span class="icon icon-smile icon-large"></span>&nbsp;  어이쿠!!</h4>
                            <div class="well text-center">등록할 수 있는 스타트업 정보가 없습니다.</div>
                            <div class="text-center"><a href="/" class="btn btn-default">홈으로</a></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    {/}
                </div>
            </div>
            <!-- /editor -->              
            
        </div> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent --> 

<script type="text/javascript">
//<![CDATA[
    
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

function go_del()
{
    del_confirm('del_recruit()');
}

function del_recruit()
{
    document.location.href='/recruit/add/?id={res.id}&del=true';
}

function go()
{

    if ($('input[name=start]').val().length < 1) {
        alert("채용 공고 시작일을 입력해주세요.");
        return false;
    }
    if ($('input[name=end]').val().length < 1) {
        alert("채용 공고 종료일을 입력해주세요.");
        return false;
    }
    if ($('input[name=title]').val().length < 1) {
        alert("채용제목을 입력해주세요.");
        return false;
    }

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