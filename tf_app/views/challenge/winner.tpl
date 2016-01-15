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
    location.href='/challenge/edit?cancel='+_id;
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
    var set_data ={
        "search":$('input[name=search]').val()
    };
    var get_url = '/ajax_v3/get_reception/'+_id+"/"+_page;
    $.post(get_url, set_data, function(_data){
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
    <!-- rowContent -->
    <div class="rowContent" id="competition"> 
        <div class="page-header">
            <div class="container">
                <h2><a href="/challenge">Challenge</a></h2>
                {? (s.per & settings->permission1) == settings->permission1}
                {? s.ids}
                <button  class="btn btn-primary pull-right" onclick=location.href='/challenge/edit'><span class="icon-pencil"></span> 경진대회 만들기</button>
                {:}
                <button  class="btn btn-primary pull-right" onclick="javascript:alert('로그인이 필요합니다.');"><span class="icon-pencil"></span> 경진대회 만들기</button>
                {/}
                {/}
            </div>
        </div>
        <!-- /page-header -->
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
                <div  class="row"> 
                    <!-- content -->
                    <div class="col-xs-12 col-sm-12 col-md-9 content editor">
                        
                        <div class="content-header">
                            <h3 class="content-heading"><a href="/member/edit_challenge_m">Challenge 관리</a> > 대회 운영 현황</h3> 
                        </div>
                        
                        
                        <div class="well applied-item">
                            <div class="media">
                                {? res.img}<a href="/challenge/views/{res.id}" class="pull-left media-object"><img class="img-responsive" src="{res.img}" ></a>{/}
                                <div class="media-body">
                                    <h4 class="media-heading"><a href="/challenge/views/{res.id}">{res.subject}</a></h4>
                                    <div class="item-status">
                                        <dl class="dl-horizontal ">
                                            <dt>주최/주관</dt>
                                            <dd><a href="/member/{res.ids}">{res.name}</a>{? res.organized}/{res.organized}{/} </dd>
                                            <dt>참가기간</dt>
                                            <dd>{=date_to_kr(res.date_s)} ~ {=date_to_kr(res.date_e)} 
                                                {? date('Y.m.dH:i') < res.sdate}<span class="label label-info">접수 준비</span>{/}
                                                {? date('Y.m.dH:i') > res.sdate && date('Y.m.dH:i') < res.edate}<span class="label label-primary">접수중</span>{/} 
                                                {? date('Y.m.dH:i') > res.edate}<span class="label label-warning">접수마감</span>{/} 
                                                {? date('Y.m.dH:i') > res.announce && res.winner}<span class="label label-default">수상자 발표</span>{/}
                                            </dd>
                                            <dt>발표일자</dt>
                                            <dd>{=date_to_kr(res.announce_d)}</dd>
                                            {? (res.user_id == s.id) || op}
                                            <dt>공개여부</dt>
                                            <dd>
                                                <select data-width="auto" class="selectpicker" name="open" onchange="change_status_cm(this, '{res.id}'); return false;">
                                                    <option value="1" {? res.open}selected="selected"{/}>공개</option>
                                                    <option value="0" {? !res.open}selected="selected"{/}>비공개</option>
                                                </select>
                                            </dd>
                                            {/}
                                        </dl>
                                    </div>
                                </div>
                                {? (res.user_id == s.id) || op}
                                <div class="list-controller pull-right">
                                    <a href="/challenge/edit/{res.id}" class="btn btn-primary btn-sm">세부정보 설정하기</a>
                                </div>
                                {/}
                            </div>
                            <!-- /media -->
                        </div>
                        <!-- /applied-item -->

                        <ol data-progtrckr-steps="7" class="stepProgress">
                            <li class="{? step > 0}step-done{:}step-todo{/}">정보입력</li>
                            <li class="{? step > 1}step-done{:}step-todo{/}">승인받기</li>
                            <li class="{? step > 2}step-done{:}step-todo{/}">세부정보 설정</li>
                            <li class="{? step > 3}step-done{:}step-todo{/}">접수중</li>
                            <li class="{? step > 4}step-done{:}step-todo{/}">접수마감</li>
                            <li class="{? step > 5}step-done{:}step-todo{/}">수상자 발표</li>
                        </ol>

                        {? date('Y.m.dH:i') < res.sdate}
                        <div class="alert alert-info text-center">
                            <span class="icon-warning-sign"></span> 대회 시작 전입니다.
                        </div>
                        {/}
                        <!--  applied-list  -->
                        <div class="applied-list panel panel-default tab-content"> 
                            <div class="panel-heading">
                                <!--<h3 class="panel-title"><span class="icon-fixed-width  icon-check "></span>참가자 현황</h3>-->
                                {? (res.user_id == s.id) || op}<a class="pull-right btn btn-default btn-xs" href="/challenge/examine_excel/{res.id}">심사 현황 다운로드</a>
                                {? res.id > 134}<a class="pull-right btn btn-default btn-xs" href="/challenge/applied_files/{res.id}">지원서 첨부파일</a>{/}
                                <a class="pull-right btn btn-default btn-xs" href="/challenge/applied_excel/{res.id}">지원서 내역 다운로드</a>{/}
                                <ul class="nav nav-tabs">
                                  <li><a href="/challenge/applied_list/{res.id}?tab=dashboard">경진대회 진행 현황</a></li>
                                  <li><a href="/challenge/applied_list/{res.id}">참가자 현황</a></li>
                                  {? (res.user_id == s.id) || op}
                                  <li><a href="/challenge/examiner/{res.id}">심사위원</a></li>
                                  <li><a href="/challenge/operator/{res.id}">운영진</a></li>
                                  <li class="active"><a href="/challenge/winner/{res.id}">수상자선정</a></li>
                                  {/}
                                </ul> 
                            </div>
                            <div class="panel-body tab-pane active">

                            <!-- edit-body --> 
                            <div class="edit-body" id="edit-appliedList"> 
                            </div>
                            <!-- /edit-body -->

                            <br/><br/>
                            <!-- edit-body --> 
                            <div class="edit-body" id="edit-winnerSelect"> 
                                <h4><i class="fa fa-cubes"></i> 수상자 목록</h4>

                                <div class="table-responsive">
                                </div>
                                {? date('Y.m.dH:i') > res.edate}
                                <div class="list-controller"> 
                                    선택한 수상자
                                    <button class="btn btn-default btn-sm" onclick="del_winner(); return false;">삭제</button>
                                </div>
                                
                                <!-- /list-controller -->

                                <br/><br/>
                                <div class="well">
                                    <form class="form-horizontal" role="form" name="f_winner" action="/challenge/winner/{res.id}" onsubmit="return false;" method="post">
                                        <fieldset>
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-3 col-md-3 control-label" >수상자 선정 내용</div>
                                                <div class="col-xs-12 col-sm-9 col-md-9">
                                                    <textarea  rows="20" class="form-control" name="cont" id="inputDesc"></textarea>
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            <div class="form-group">
                                                <div class="col-xs-12 col-sm-3 col-md-3 control-label" >공개여부</div>
                                                <div class="col-xs-12 col-sm-9 col-md-9">
                                                    <select class="selectpicker" data-width="auto" name="winner_open">
                                                        <option value="1" {? res.winner_open}selected="selected"{/}>공개</option>
                                                        <option value="0" {? !res.winner_open}selected="selected"{/}>비공개</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <!-- /form-group -->
                                            <input type="hidden" name="id" value="{res.id}" />
                                            <input type="hidden" name="winner" id="winner" value="" />
                                        </fieldset>
                                    </form> 
                                </div>

                                <div class="form-group form-submit">
                                    <div class="col-sm-offset-3 col-md-offset-3"> <a href="/challenge/edit/{res.id}"  class="btn btn-default">취소</a> <a href="#" onclick="go_submit(this); return false;" class="btn btn-primary">수상자 확정하기 (메일 발송)</a> </div>
                                </div>
                                {/}
                            </div>
                            <!-- /edit-body --> 
                        </div>
                        </div>
                        <!-- /applied-list  --> 
                        
                        
                    </div>
                    <!-- / content -->
                    
                    <div class="col-xs-12 col-sm-12 col-md-3 sidebar">
                    
                        {? m_list}
                        <div class="panel writed-competition">
                            <h3 class="panel-title">개최한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ m_list}
                                <li class="media"> {? .img}<a href="/challenge/views/{.id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.id}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}

                        {? e_list}
                        <div class="panel examined-competition">
                            <h3 class="panel-title">심사위원 위촉 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ e_list}
                                <li class="media"> {? .img}<a href="/challenge/views/{.competition_id}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.competition_id}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}

                        {? a_list}
                        <div class="panel applied-competition">
                            <h3 class="panel-title">참가한 경진대회</h3>
                            <ul class="media-list post-list">
                                {@ a_list}
                                <li class="media"> {? .img}<a href="/challenge/views/{.cid}" class="pull-left media-object"> <img class="img-responsive" src="{.img}"> </a>{/}
                                    <div class="media-body">
                                        <h4 class="media-heading"><a href="/challenge/views/{.cid}">{.subject}</a></h4>
                                        <div class="media-meta"> <span class="author"><a href="/member/{.ids}">{.name}</a></span> <span class="time"><span class="icon-time"></span>&nbsp; {=trans_date_ago(.date_created)}</span> </div>
                                    </div>
                                    <!-- /media-content --> 
                                </li>
                                {/}
                            </ul>
                        </div>
                        <!-- /panel -->
                        {/}
                    </div>
                    <!-- / sidebar --> 
                    
                </div>
                <!-- row --> 
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
        
    </div>
    <!-- /rowContent --> 
