         
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section>                      
                    
                    <!-- panel -->
                    <div class="panel panel-default">
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-bullhorn"></span><span class="break"></span>공지사항 목록</h2>
                            <div class="actions">
                                <span class="break"></span>
                                <a href="/admin_notice/add"data-toggle="tooltip" title="글쓰기"><span class="glyphicon  glyphicon-edit"></span></a>
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        
                        <!-- panel-body -->
                        <div class="panel-body">
                            
                            
                            
                            <div class="select-actions">
                                선택한 목록
                                <button type="button" class="btn btn-default btn-sm" onclick="del_notice_ch(); return false;">선택삭제</button>
                                <button type="button" class="btn btn-default btn-sm" onclick="edit_state_all(1); return false;">공개</button>
                                <button type="button" class="btn btn-default btn-sm" onclick="edit_state_all(0); return false;">비공개</button>
                            </div>
                            
                            
                            
                            
                        </div>
                        <!-- /panel-body --> 
                        
                        <table class="table table-striped table-hover">
                            <form name="frm_editor" >
                                <thead>
                                    <tr>
                                        <th class="td-check" width="20"><input type="checkbox" name="all_check" ></th>
                                        <th class="td-subject" >제목</th>
                                        <th class="td-name" width="100">작성자</th>
                                        <th class="td-date" width="80">등록일자</th>
                                        <th class="td-status" width="80">관리</th>                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    {@ res}
                                    <tr>
                                        <td class="td-check"><input type="checkbox" name="id_con" value="{.id}" ></td>
                                        <td class="td-subject">
                                            [{? .type == 1}뉴스{/}{? .type == 2}스타트업 뉴스{/}{? .type == 3}공지사항{/}]
                                            <a href="/admin_notice/add/{.id}">{.title}</a> 
                                            <a class="btn btn-link btn-xs" data-toggle="tooltip" title="사이트에서 보기" target="_blank" href="/notice/views/{.type}/{.id}"><span class="glyphicon  glyphicon-share"></span></a>
                                        </td>
                                        <td class="td-name">{.writer}</td>
                                         <td class="td-date">{=str_replace("-", ".", substr(.date_created, 0, 10))}</td>
                                        <td class="td-status">
                                            {? .visible}
                                            <button type="button" id="visible_{.id}" class="btn btn-warning btn-xs" data-toggle="tooltip" title="공개" onclick="edit_state('{.id}', '{.visible}'); return false;"><span class="glyphicon  glyphicon-eye-open glyphicon-white"></span></button>
                                            {:}
                                            <button type="button" id="visible_{.id}" class="btn btn-default btn-xs" data-toggle="tooltip" title="비공개" onclick="edit_state('{.id}', '{.visible}'); return false;"><span class="glyphicon  glyphicon-eye-close "></span></button>
                                            {/}
                                            <button type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="삭제" onclick="del_notice('{.id}', this); return false;"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
                                         </td>                                       
                                    </tr>
                                    {:}
                                    <tr>
                                        <td class="td-check" colspan="5">등록된 공지사항이 없습니다.</td>                                       
                                    </tr>
                                    {/}

                                </tbody>
                            </form>
                        </table>
                            
                        <!-- panel-footer -->
                        <div class="panel-footer">
                            
                            <div class="paging">
                                <ul class="pagination">
                                    {?page == 1}
                                    <li class="disabled"><a href="#">&laquo;</a></li>
                                    {:}
                                    <li><a href="/admin_notice/{page - 1}">&laquo;</a></li>
                                    {/}

                                    {@paging.pages}
                                    {?.type == "dot"}
                                    <li class="disabled"><a href="#">...</a></li>
                                    {:}
                                    <li {?.type == "current"}class="active"{/}><a href="/admin_notice/{.page}">{.page}</a></li>
                                    {/}
                                    {/}

                                    {?page == paging.tot_page}
                                    <li class="disabled"><a href="#">&raquo;</a></li>
                                    {:}
                                    <li><a href="/admin_notice/{page + 1}" >&raquo;</a></li>
                                    {/}
                                </ul>
                            </div>
                            
                        </div>
                        <!-- /panel-footer -->
                    </div>
                    <!-- /panel --> 
                
                
                </section>
                <!-- /section --></div>
            <!-- /contentwrap -->             

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

    //전체체크 해제
    $('input[name=all_check]').click(function(){

        if(this.checked) {
            // Iterate each checkbox
            $(':checkbox').each(function() {
                this.checked = true;                        
            });
        }
        else {
            // Iterate each checkbox
            $(':checkbox').each(function() {
                this.checked = false;                        
            });
        }
    });

    function edit_state(_id, _st) {
        _st = Math.abs(_st - 1);
        $.get('/ajax/notice_edit_state/'+_st+'/'+_id,function(){
            if (_st === 1) {
                $('#visible_'+_id).removeClass("btn-default");
                $('#visible_'+_id).addClass("btn-warning");
                $('#visible_'+_id).attr('data-original-title', '공개')
            }
            else {
                $('#visible_'+_id).removeClass("btn-warning");
                $('#visible_'+_id).addClass("btn-default");
                $('#visible_'+_id).attr('data-original-title', '비공개')
            }
            $('#visible_'+_id).attr('onclick', 'edit_state('+_id+','+_st+'); return false;');
        });
    }
    
    function edit_state_all(_st)
    {
        var siteset="";
        var c_length = $('input[name=id_con]').length;

        for(var i=0; i < c_length; i++){
            if(document.frm_editor.id_con[i].checked) {
                siteset +=document.frm_editor.id_con[i].value + ","
            }
        }
        var set_data ={
            "data": siteset.substring(0, siteset.length-1),
        };

        $.post('/ajax/notice_edit_state/'+_st, set_data,function(){
            window.location.reload(true);
        });
    }
    
    function del_notice(_id, _this) {
        if (confirm("삭제할까요?") === true){    //확인
            $.get('/ajax/notice_del/'+_id,function(){
                $(_this).parent().parent().remove();
            });
        }else{   //취소
            return;
        }
    }
    
    function del_notice_ch() {
        if (confirm("삭제할까요?") === true){
            var siteset="";
            var c_length = $('input[name=id_con]').length;

            for(var i=0; i < c_length; i++){
                if(document.frm_editor.id_con[i].checked) {
                    siteset +=document.frm_editor.id_con[i].value + ","
                }
            }
            var set_data ={
                "data": siteset.substring(0, siteset.length-1),
            };
            $.post('/ajax/notice_del', set_data,function(){
                window.location.reload(true);
            });
        }else{   //취소
            return;
        }
    }

//]]>
</script>