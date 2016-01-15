
            <script>
                $('.dropdown-toggle').dropdown();
            </script>
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap">
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>공간 담당자 등록</h2>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" action="/admin_space/rep" method="post">
                            <input type="hidden" id="f_name" name="option" value="">
                            <input type="hidden" id="f_id" name="id" value="{res.id}">
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <legend>공간 정보 입력</legend>
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">공간공유 담당자 </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                             
                                             <div class="well">
                                                <header>
                                                    <h4>연결된 계정 정보</h4>
                                                </header>
                                                <table class="table table-striped table-hover repT1">
                                                    <thead>
                                                        <tr>
                                                            <th class="td-id">아이디</th>
                                                            <th class="td-name">이름</th>
                                                            <th class="td-gender">성별</th>
                                                            <th class="td-birth">생년월일</th>
                                                            <th class="td-phone">휴대폰번호</th>
                                                            <th class="td-company">소속</th> 
                                                        </tr>
                                                    </thead>
                                                    <tbody class="t1">
                                                        {? rep1}
                                                        <tr>
                                                            <td class="td-id">{rep1.ids}</td>
                                                            <td class="td-name"><a href="/member/{rep1.ids}">{rep1.name}</a></td>
                                                            <td class="td-gender">{? rep1.gender == 1}남{:}여{/}</td>
                                                            <td class="td-birth">{rep1.birth}</td>
                                                            <td class="td-phone">{rep1.tel}</td>
                                                            <td class="td-company">{rep1.com.name}</td> 
                                                        </tr> 
                                                        {:}
                                                        <tr><td>등록된 계정이 없습니다.</td></tr>
                                                        {/}
                                                    </tbody>
                                                </table>
                                             </div>

                                             <button class="btn btn-default btn-sm" type="button" data-toggle="modal" data-target="#md-connectId" onclick="set_req(1); return false;">
                                                 <span class="glyphicon glyphicon-search"></span> 계정찾기
                                             </button>
                                        </div>
                                    </div>
                                    <!-- /form-group --><div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">디자인라운지 담당자 </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                             
                                             <div class="well">
                                                <header>
                                                    <h4>연결된 계정 정보</h4>
                                                </header>
                                                <table class="table table-striped table-hover repT2">
                                                    <thead>
                                                        <tr>
                                                            <th class="td-id">아이디</th>
                                                            <th class="td-name">이름</th>
                                                            <th class="td-gender">성별</th>
                                                            <th class="td-birth">생년월일</th>
                                                            <th class="td-phone">휴대폰번호</th>
                                                            <th class="td-company">소속</th> 
                                                        </tr>
                                                    </thead>
                                                    <tbody class="t2">
                                                        {? rep2}
                                                        <tr>
                                                            <td class="td-id">{rep2.ids}</td>
                                                            <td class="td-name"><a href="/member/{mento.ids}">{rep2.name}</a></td>
                                                            <td class="td-gender">{? rep2.gender == 1}남{:}여{/}</td>
                                                            <td class="td-birth">{rep2.birth}</td>
                                                            <td class="td-phone">{rep2.tel}</td>
                                                            <td class="td-company">{rep2.com.name}</td> 
                                                        </tr> 
                                                        {:}
                                                        <tr><td>등록된 계정이 없습니다.</td></tr>
                                                        {/}
                                                    </tbody>
                                                </table>
                                             </div>

                                             <button class="btn btn-default btn-sm" type="button" data-toggle="modal" data-target="#md-connectId"onclick="set_req(2); return false;">
                                                 <span class="glyphicon glyphicon-search"></span> 계정찾기
                                             </button>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    <input type="hidden" name="r1" value="{rep1.id}" />
                                    <input type="hidden" name="r2" value="{rep1.id}" />
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            <!-- panel-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary">등록</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel --> 
             
             
                    
                </section>
                <!-- /section -->
             </div>
            <!-- /contentwrap --> 

<div class="modal fade" id="md-connectId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">회원 검색</h4>
            </div>
            <div class="modal-body">
            <!-- modal content -->
                <div class="panel panel-default"> 
                     <div class="panel-body highlight">
                        <form class="col-md-8 col-lg-offset-2" role="search" method="post" onsubmit="return false;" name="f_search">
                            <div class="input-group">
                                <input type="text" placeholder="이름, 핸드폰 번호, 생년월일을 입력한 후 검색하세요." class="form-control" name="q">
                                <span class="input-group-btn">
                                <button type="submit" class="btn btn-default" onclick="serch_member_r();">검색</button>
                                </span> 
                            </div>
                            <input type="hidden" name="rep" value="" />
                        </form>
                    </div>
                    <!-- /panel-body -->
                    <table class="table table-striped table-hover"></table>
                </div>
                <!-- /panel -->  
            <!-- /modal content -->
            </div> 
        </div>
    </div>
</div>
<script type="text/javascript">
//<![CDATA[
    function set_req(_id) {
        $('input[name=rep]').val(_id);
    }

    function serch_member_r() {
        if ($('input[name=q]').length < 1) {
            alert('검색어를 입력해주세요.');
            return false;
        }
        $('form[name=f_search] .btn-primary').hide();
        var frm = $('form[name=f_search]');
        var set_data = frm.serialize();
        var post_url = "/ajax_v2/search_member/";
        $.ajax({
            type : 'POST',
            url : post_url,
            data : set_data,
            success : function(_data) {
                $('.modal .table-striped').html(_data);
            }
        });
    }

    function this_select_r(_this, _id, _rep) {
        $('input[name=q]').val('');
        $('#md-connectId .table-striped').html('');
        $('input[name=r'+_rep+']').val(_id);
        box = $(_this).parent().parent();
        box.find('.td-checkin').remove();
        console.log(box);
        $('.t'+_rep).html(box);
        $('.modal').modal('hide');
    }

//]]>
</script>