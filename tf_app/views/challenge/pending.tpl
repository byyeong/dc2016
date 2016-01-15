    <!-- rowContent -->
    <div class="rowContent" id="pending"> 
        
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container"> 
                
                <!-- content -->
                <div class="content col-xs-12 col-sm-8 col-sm-offset-2 col-md-8 col-md-offset-2">
                    <h2 class="text-center">{? u.name}{u.name}님이 {/}경진대회 심사위원으로 초대했습니다.</h2>
                    <dl class="dl-horizontal">
                        <dt>경진대회명</dt>
                        <dd>{res.subject}</dd>
                        <dt>주최/주관 기관 </dt>
                        <dd>{res.organized} </dd>
                        <dt>참가 접수기간</dt>
                        <dd>{res.date_s} ({=date_to_day_only(res.date_s)}) {res.time_s} ~ {res.date_e} ({=date_to_day_only(res.date_e)}) {res.time_e}</dd>
                    </dl>
                    {? is_expired }
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">심사위원 위촉 승인 불가</h3>
                            </div>
                            <div class="panel-body">
                                <form role="form">
                                    <div class="alert alert-danger">
                                        심사 가능여부 수락 기간이 만료되었습니다.
                                    </div>
                                    <div class="form-group form-submit text-center">
                                        <a href="/" class="btn btn-default">메인으로 가기</a>
                                    </div>
                                </form>
                            </div>
                        </div><!--/panel-->
                    { : }
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">해당 경진대회의 심사가 가능하신가요?</h3>
                            </div>
                            <div class="panel-body">
                                <form role="form" name="p_form" onsubmit="return false;">
                                    <fieldset>
                                        <div class="form-group ">
                                            <label class="radio-inline">
                                                <input type="radio" name="status" id="accept-yes" value="1" onchange="check_reject(this); return false;"> 가능
                                            </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="status" id="accept-no" value="2" onchange="check_reject(this); return false;"> 불가능
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
                        </div><!--/panel-->
                    { / }
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