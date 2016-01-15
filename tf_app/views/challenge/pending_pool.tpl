    <!-- rowContent -->
    <div class="rowContent" id="pending"> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"> 
                
                <!-- content -->
                <div class="content col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">
                    <h2 class="text-center">D.CAMP 심사위원단으로 {? u.name}{u.name}님을 {/} 초대합니다.</h2>
                    <div>
{? u.name}{u.name}님 {/}안녕하세요. 은행권청년창업재단 D.CAMP입니다.<br/><br/>
D.CAMP Challenge의 심사위원단으로 초대드립니다. <br/><br/>
심사위원단 참여를 수락해주시면 Challenge 플랫폼을 이용하여 진행되는 경진대회의 심사위원 후보로 자동 추천되어 쉽게 심사위원으로 참여하실 수 있습니다.<br/><br/>
개별 경진대회에서 심사위원으로 초빙할 경우, 별도의 메일로 다시 안내 드립니다.<br/>
D.CAMP 심사위원단으로 참여해주세요!<br/><br/>
                    </div>
                    <div class="panel panel-default"> 
                        <div class="panel-heading">
                            <h3 class="panel-title">경진대회의 심사가 가능하신가요?</h3>
                        </div>
                        <div class="panel-body">
                            <form role="form" name="p_form" onsubmit="return false;">
                                <fieldset>
                                    <div class="form-group ">  
                                        <label class="radio-inline">
                                            <input type="radio" name="status" id="accept-yes" value="1" onchange="check_reject(this); return false;"> 승인 
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="status" id="accept-no" value="2" onchange="check_reject(this); return false;"> 거절
                                        </label> 
                                    </div> 
                                    <div class="form-group" id="out_platform" style="display: none;">
                                        <label>거절하는 이유를 입력해주세요.</label>
                                        <textarea class="form-control" placeholder="" name="des"></textarea>
                                    </div> 

                                    <div class="well">
                                        경진대회 심사를 진행하시기 위해서는 초대 받으신 메일 주소로 D.CAMP 온라인 <a href="/signup?e={u.memail}">회원 가입</a>을 완료하셔야 합니다. <br>심사위원단 구성이 완료 된 후 최종적으로 심사 권한이 부여되며, 별도의 메일을 통해 안내드립니다.
                                    </div>

                                    <div class="form-group form-submit text-center"> 
                                        <button type="submit" class="btn btn-primary" onclick="submit_pending(); return false;">확인</button> 
                                    </div>
                                    <input type="hidden" name="id" value="{u.id}" />
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /content --> 
                
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent -->

<script type="text/javascript">
//<![CDATA[
    function check_reject(_this) {
        var _ch = $(':radio[name="status"]:checked').val();
        if (_ch === '2') {
            $('#out_platform').slideDown();
        } else {
            $('#out_platform').slideUp();
        }
    }
//]]>
</script>