	            <!-- contentswrap -->
	            <div class="col-md-10 contentswrap"> 
	                <!-- section -->
	                <section > 
	                    
	                    <!-- panel -->
	                    <div class="panel panel-default">
	                        <!-- panel-heading -->
	                        <div class="panel-heading">
	                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>회원 등급</h2>
	                            <div class="actions">
	                                <span class="break"></span>
	                                <a href="/admin_member/grade" class="btn-list"  data-toggle="tooltip" title="추가하기"><span class="glyphicon  glyphicon-plus"></span></a>
	                            </div>
	                        </div>
	                        <!-- /panel-heading -->  
	                        <table class="table table-striped table-hover">
	                                <thead>
	                                    <tr>
	                                        <th class="td-name">등급명</th>
	                                        <th class="td-desc">등급 설명</th>
	                                        <th class="td-setting">권한</th>
	                                        <th class="td-control">관리</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
                                            {@ res}
	                                    <tr>
                                                <td class="td-name">
	                                            {? .visible == 0}<span class="glyphicon  glyphicon-lock"></span> &nbsp;{/}
	                                            <a href="/admin_member/grade/{.id}">{.name}</a>
	                                        </td>
                                                <td class="td-desc">{.description}</td>
	                                        <td class="td-setting">
                                                    {? (.permission & settings->permission1) == settings->permission1}/ 모든권한 {/}
                                                    {? (.permission & settings->permission2) == settings->permission2}/ 공간공유 {/}
                                                    {? (.permission & settings->permission3) == settings->permission3}/ 이벤트 참여 {/}
                                                    {? (.permission & settings->permission4) == settings->permission4}/ 이벤트 생성 {/}
                                                    {? (.permission & settings->permission5) == settings->permission5}/ 기타관리 접근 {/}
                                                    {? (.permission & settings->permission6) == settings->permission6}/ 서비스 상세 현황 보기 {/}
                                                    {? (.permission & settings->permission7) == settings->permission7}/ 매월 공간공유 10시간 바로 사용{/}
                                                </td>
	                                        <td class="td-control">
	                                            {? .visible == 0}
                                                    <button class="btn btn-warning btn-xs" type="button" data-toggle="tooltip" data-original-title="비공개" onclick="edit_state('{.id}', '{.visible}'); return false;">
	                                                <span class="glyphicon  glyphicon-eye-close "></span>
	                                            </button>
                                                    {:}
                                                    <button id="visible_{.id}" class="btn btn-info btn-xs" type="button" data-toggle="tooltip" data-original-title="공개" onclick="edit_state('{.id}', '{.visible}'); return false;">
	                                                <span class="glyphicon  glyphicon-eye-open "></span>
	                                            </button>
                                                    {/}
                                                    {? .id > 2}
	                                            <button class="btn btn-danger btn-xs" type="button" data-toggle="tooltip" data-original-title="삭제" onclick="del_notice('{.id}', this); return false;">
	                                                <span class="glyphicon  glyphicon-trash  glyphicon-white"></span>
	                                            </button>
                                                    {/}
	                                        </td>
	                                    </tr>
                                            {/}
	                                </tbody>
	                            </table>
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
    
    function edit_state(_id, _st) {
        _st = Math.abs(_st - 1);
        $.get('/ajax/grade_edit_state/'+_st+'/'+_id,function(){
            if (_st === 1) {
                $('#visible_'+_id).removeClass("btn-warning");
                $('#visible_'+_id).addClass("btn-info");
                $('#visible_'+_id).attr('data-original-title', '공개')
            }
            else {
                $('#visible_'+_id).removeClass("btn-info");
                $('#visible_'+_id).addClass("btn-warning");
                $('#visible_'+_id).attr('data-original-title', '비공개')
            }
            $('#visible_'+_id).attr('onclick', 'edit_state('+_id+','+_st+'); return false;');
        });
    }
    
    function del_notice(_id, _this) {
        if (confirm("삭제할까요?") === true){    //확인
            $.get('/ajax/grade_del/'+_id,function(){
                $(_this).parent().parent().remove();
            });
        }else{   //취소
            return;
        }
    }

//]]>
</script>