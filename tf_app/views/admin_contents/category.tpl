<!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>카테고리 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="카테고리 추가" data-toggle="tooltip" href="/admin_contents/category_info"><span class="glyphicon  glyphicon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr> 
                                    <th class="td-category">카테고리</th>
                                    <th class="td-subject">설명</th>
                                    <th class="td-status">노출여부</th>
                                    <th class="td-name">작성자</th> 
                                    <th class="td-num">관리</th>   
                                    <th class="td-num">순서</th>
                                </tr>
                            </thead>
                            <tbody>
                                {@ res}
                                <tr> 
                                    <td class="td-category"><a href="/admin_contents/category_info/{.id}">{.name}</a></td>
                                    <td class="td-subject">{.des}</td>
                                    <td class="td-status">
                                        {? !.hidden}
                                        <span class="label label-success">보임</span>
                                        {:}
                                        <span class="label label-warning">숨김</span>
                                        {/}
                                    </td>
                                    <td class="td-name">{@ .users}{? ..key_ == 0}<a href="/admin_member/add/{..id}">{..name}</a>{:},
                                        <a href="/admin_member/add/{..id}">{..name}</a>{/}{/}</td> 
                                    <td class="td-num">
                                        <a href="/admin_contents/category_edit/{.id}" class="btn btn-default btn-xs">작성자관리</a>
                                        <button title="" data-toggle="tooltip" class="btn btn-danger btn-xs" type="button" data-original-title="삭제" onclick="del_category(this, '{.id}');"><span class="glyphicon  glyphicon-trash  glyphicon-white"></span></button>
                                    </td>
                                    <td class="td-num">
                                        <button class="btn btn-default btn-xs" onclick="set_con_cat(this, {.ord}, 1);" title="위로" data-toggle="tooltip" {? .key_ == 0}disabled="disabled"{/}><span class="icon-caret-up icon-fixed-width"></span></button> 
                                        <button class="btn btn-default btn-xs" onclick="set_con_cat(this, {.ord}, 2);" title="아래로" data-toggle="tooltip"  {? .key_ == sizeof(res)-1}disabled="disabled"{/}><span class="icon-caret-down icon-fixed-width"></span></button>
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

function set_con_cat(_this, _ord, _type) {
    $(_this).hide();
    var get_url = "/ajax/set_con_cat/"+_ord+"/"+_type;
    
    $.get(get_url, function() {
        window.location.reload(true);
    });
}

function del_category(_this, _id) {
    var r = confirm("카테고리를 삭제하겠습니까?");
    
    if (r == true) {
        var get_url = "/ajax/del_category/"+_id;
        
        $.get(get_url, function() {
            $(_this).parent().parent().remove();
        });
    }
        
}
//]]>
</script>