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
                tinyMCE.activeEditor.setContent("{=safe_js_editor(res.winner)}");
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
//<![CDATA[

function go_cancel(_id)
{
    location.href='/admin_challenge/edit?cancel='+_id;
}

function go_submit(_this)
{
    $(_this).attr("disabled", "disabled");
    document.getElementById("winner").value = tinyMCE.activeEditor.getContent();
    document.f_winner.submit();
}

get_reception('{res.id}', 1);
function get_reception(_id, _page)
{
    var get_url = '/ajax_v3/get_reception/'+_id+"/"+_page;
    $.get(get_url, function(_data){
        $('#edit-appliedList').html(_data);
    });
}

get_winner('{res.id}');
function get_winner(_id)
{
    var get_url = '/ajax_v3/get_winner/'+_id;
    $.get(get_url, function(_data){
        $('#edit-winnerSelect .table-responsive').html(_data);
    });
}

function add_winner()
{
    var siteset="";
    var c_length = $('input[name=id_rec]').length;

    for(var i=0; i < c_length; i++){
        if(document.rec_list.id_rec[i].checked) {
            siteset += document.rec_list.id_rec[i].value + ","
        }
    }
    var url = '/ajax_v3/add_winner/';
    var set_data ={
        "competition_id":'{res.id}',
        "users": siteset.substring(0, siteset.length-1),
    };
    //alert(siteset.substring(0, siteset.length-1));
    
    $.post(url, set_data, function(_data){
        $('input[name=id_rec]').each(function() {
            this.checked = false;                        
        });
        get_winner('{res.id}');
    });
}

function del_winner()
{
    var siteset="";
    var c_length = $('input[name=id_win]').length;

    for(var i=0; i < c_length; i++){
        if(document.win_list.id_win[i].checked) {
            siteset += document.win_list.id_win[i].value + ","
        }
    }
    var url = '/ajax_v3/del_winner/';
    var set_data ={
        "competition_id":'{res.id}',
        "users": siteset.substring(0, siteset.length-1),
    };
    //alert(siteset.substring(0, siteset.length-1));
    
    $.post(url, set_data, function(_data){
        $('input[name=id_win]').each(function() {
            this.checked = false;                        
        });
        get_winner('{res.id}');
    });
}
//]]>
</script>
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>경진대회 작성하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="목록보기" data-toggle="tooltip" href="/admin_challenge"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <div class="panel-heading">
                            <!--ol data-progtrckr-steps="7" class="stepProgress">
                                <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                                <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                                <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                                <li class="{? step > 3}step-done{:}step-todo{/}">접수준비</li>
                                <li class="{? step > 4}step-done{:}step-todo{/}">접수중</li>
                                <li class="{? step > 5}step-done{:}step-todo{/}">접수마감</li>
                                <li class="{? step > 6}step-done{:}step-todo{/}">수상자 발표</li>
                            </ol-->

                            <ul class="nav nav-tabs">
                                <li><a href="/admin_challenge/edit/{res.id}">{? res}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}신청 정보 입력</a></li>
                                {? res.status == 1}
                                <li><a href="/admin_challenge/edit_next/{res.id}">{? res.announce_d}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}대회 정보 입력</a></li>
                                <li><a href="/admin_challenge/apply_info/{res.id}">{? for}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}지원서 만들기</a></li>
                                <li><a href="/admin_challenge/score_info/{res.id}">{? sco}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}평가지 만들기</a></li>
                                <li><a href="/admin_challenge/operator/{res.id}">{? op}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}운영진 초대</a></li>
                                <li><a href="/admin_challenge/examiner/{res.id}">{? exn}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}심사위원 초대</a></li>
                                <li class="active"><a href="/admin_challenge/winner/{res.id}">{? res.winner}<span class="icon-ok-sign done"></span>{:}<span class="icon-ok todo"></span>{/}수상자 선정</a></li>
                                {/}
                            </ul>
                        </div>

                        <!-- edit-body --> 
                        <div class="panel-body" id="edit-appliedList"> 
                        </div>
                        <!-- /edit-body -->

                        <!-- edit-body --> 
                        <div class="panel-body" id="edit-winnerSelect"> 
                            <h4><i class="fa fa-cubes"></i> 수상자 목록</h4>

                            <div class="table-responsive">
                            </div>
                            <!-- /table -->
                            <div class="list-controller"> 
                                선택한 수상자
                                <button class="btn btn-default btn-sm" onclick="del_winner(); return false;">삭제</button>
                            </div>
                            <!-- /list-controller -->

                            <div class="well" style="margin-top: 15px;">
                                <form class="form-horizontal" role="form" name="f_winner" action="/admin_challenge/winner/{res.id}" onsubmit="return false;" method="post">
                                    <div class="panel-body" id="setting-apply">
                                        <fieldset>
                                            <input type="hidden" name="id" value="{res.id}" />
                                            <input type="hidden" name="winner" id="winner" value="" />
                                            <legend class="sr-only">수상자 선정 내용 입력</legend>
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">수상자 선정 내용</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <textarea  rows="20" class="form-control" name="cont" id="inputDesc"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-2 col-md-2 control-label">공개여부</div>
                                                <div class="col-xs-12 col-sm-10 col-md-10">
                                                    <select class="selectpicker" data-width="auto" name="winner_open">
                                                        <option value="1" {? res.winner_open}selected="selected"{/}>공개</option>
                                                        <option value="0" {? !res.winner_open}selected="selected"{/}>비공개</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <!--/panel-body -->
                                </form>
                            </div>

                            <div class="form-group form-submit">
                                <div class="col-sm-offset-3 col-md-offset-3"> <a href="/admin_challenge/edit/{res.id}"  class="btn btn-default">취소</a> <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">수상자 확정하기 (메일 발송)</a> </div>
                            </div>

                        </div>
                        <!-- /edit-body --> 
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
