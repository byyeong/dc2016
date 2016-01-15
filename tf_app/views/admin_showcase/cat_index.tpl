<!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>시장정보 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="시장정보 추가" data-toggle="tooltip" href="/admin_showcase/cat_edit"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-category">시장 명</th> 
                                    <th width="60" class="td-status">관리</th> 
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr> 
                                    <td width="60" class="td-num">{=sizeof(res) - .key_}</td>
                                    <td class="td-category"><a href="/admin_showcase/cat_edit/{.id}">{._value}</a></td> 
                                    <td width="60" class="td-status">
                                        <button data-original-title="삭제" type="button" class="btn btn-danger btn-xs" data-toggle="tooltip" title="" onclick="del_bz_cat(this, '{.id}'); return false;";><span class="icon-trash  glyphicon-white"></span></button>
                                    </td> 
                                </tr>
                                {/}
                            </tbody>
                        </table>  
                    </div>
                    <!-- /panel --> 
                    
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

function del_bz_cat(_this, _id) {
    var r = confirm("해당 시장정보를 삭제하겠습니까?");
    
    if (r == true) {
        var get_url = "/ajax_v3/del_code/"+_id;
        
        $.get(get_url, function() {
            $(_this).parent().parent().remove();
        });
    }
        
}
//]]>
</script>