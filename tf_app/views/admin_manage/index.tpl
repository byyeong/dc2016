            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="icon-align-justify"></span><span class="break"></span>FAQ 목록</h2>
                            <div class="actions"> <span class="break"></span> <a title="FAQ 추가" data-toggle="tooltip" href="/admin_manage/edit_faq"><span class="icon-plus"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th width="60" class="td-num">번호</th>
                                    <th class="td-category">분류</th>
                                    <th class="td-subject">제목</th>
                                    <th width="80" class="td-status">노출여부</th>
                                    <th width="100" class="td-manage">관리 </th>
                                    <th width="80" class="td-order">순서 </th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        <!-- /panel-footer --> 
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

get_faq();
function get_faq() {
    var post_url = "/ajax_v2/get_faq";
    $.ajax({
        type : 'GET',
        url : post_url,
        success : function(_data) {
            $("tbody").html(_data);
        }
    });
}

function re_order(_id, _ord, _type) {
    var post_url = "/ajax_v2/reorder_faq/"+_id+"/"+_ord+"/"+_type;
    $.ajax({
        type : 'GET',
        url : post_url,
        success : function() {
            get_faq();
        }
    });
}

//]]>
</script>