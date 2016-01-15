
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-edit"></span><span class="break"></span>심사위원 초대하기</h2>
                            <div class="actions"> <span class="break"></span> <a title="심사위원 목록보기" data-toggle="tooltip" href="/admin_competition/examiner_list"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" method="post" role="form" name="invitation_f" action="/admin_competition/examiner_add">
                            <div class="panel-body">
                                <fieldset>
                                    <legend>초대할 정보입력</legend>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">이메일 주소 </div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <p><button data-target="#md-searchMember" data-toggle="modal" class="btn btn-default" onclick="search_member(); return false;"><span class="icon-user"></span> 회원검색 후 초대하기</button></p>
                                            <div class="input-group"> <span class="input-group-addon"><span class="icon-envelope-alt"></span></span>
                                                <input type="text" placeholder="초대할 메일주소를 입력하세요" name="ex_email" class="form-control" required="required" onkeydown="return ignoreEnter(event);"> 
                                            </div>
                                            <span class="help-block">여러명일 경우에는 콤마(,)로 구분해주세요. </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label">초대 메시지</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <div class="form-group">
                                                <textarea class="form-control" rows="6" placeholder="심사위원으로 초대할 내용을 작성해주세요" name="ex_con">
안녕하세요. 은행권청년창업재단에서 운영하는 D.CAMP입니다.
D.CAMP 심사위원단에 회원님을 위촉하고 싶어 연락을 드렸습니다. D.CAMP에서는 다양한 경진대회와 이벤트르르 진행하고 있습니다. D.CAMP 심사위원단이 되시면, D.CAMP에서 직전 진행하는 경진대회와 D.CAMP 경진대회 플랫폼을 이용하여 진행되는 경진대회의 심사위원 후보로 자동 추천되어 쉽게 심사위원으로 참여하실 수 있습니다. 개별 경진대회에서 심사위원으로 위촉할 경우, 별도의 메일로 다시 안내 드립니다. 
D.CAMP 심사위원단으로 참여해주세요!
                                                </textarea>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <!--/panel-body -->
                            
                            <div class="panel-footer">
                                <div class="col-lg-offset-2">
                                    <button type="button" class="btn btn-default">취소</button>
                                    <button type="submit" class="btn btn-primary" onclick="invitation(this); return false;">확인</button>
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
<script type="text/javascript">
//<![CDATA[

function search_member()
{
    $('#md-searchMember').html('');
    var url = '/ajax_front/get_member_list/';
    $.get(url, function(_data){
        $('#md-searchMember').append(_data);
    });
}

function search_member_q()
{
    var url = '/ajax_front/get_member_list_q/';
    var set_data ={
        "q":$('input[name=q]').val(),
    };
    $.post(url, set_data, function(_data){
        $('#md-searchMember .search-result').html('');
        $('#md-searchMember .search-result').append(_data);
    });
}

function set_email(_email)
{
    $('#md-searchMember').modal('hide');
    var _e_email = $('input[name=ex_email]').val();
    if (_e_email !== '')
        $('input[name=ex_email]').val(_e_email +", "+ _email);
    else 
        $('input[name=ex_email]').val(_email);
}

function invitation (_this)
{
    if (!$('input[name=ex_email]').val()) {
        alert("이메일 주소를 입력해주세요.");
        document.invitation_f.ex_email.focus();
        return false;
    }
    $(_this).attr("disabled", "disabled");
    document.invitation_f.submit();
}

//]]>
</script>
<!-- modal #md-searchUser -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="md-searchMember" class="modal fade" style="display: none;">
    
</div>
<!-- /modal #md-searchUser -->