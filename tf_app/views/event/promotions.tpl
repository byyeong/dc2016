<link rel="stylesheet" href="/css/style_event.css">
<!-- event Box -->
<div class="eventBox">
    <div class="header">
        <h2 title="2014 새로운 봄, 나는 목표한다.">2014 새로운 봄, 나는 목표한다.</h2>
    </div>

    <div class="container">
        <ul class="step">
            <li>D.CAMP 회원가입</li>
            <li>스타트업 프로필 작성 </li>
            <li>2014 목표 작성 </li>
            <li>수상팀 발표 </li>
        </ul>

        <div class="desc">
            <p>스타트업 여러분이 꿈꾸는 2014년 목표를 저희에게 알려주세요.<br>여러분의 멋진 목표를 D.CAMP와 함께 하는 모든 스타트업과 나누고자 합니다.<br><br>
멋진 시작을 준비하시는 33팀의 스타트업을 선발해<br>
 500 Videos와 함께 <span>홍보 영상 제작을 지원</span>합니다!</p>
            <div class="videos500">
                <iframe src="//player.vimeo.com/video/85710008?title=0&amp;byline=0&amp;portrait=0&amp;color=c9ff23" width="400" height="400" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="http://vimeo.com/85710008">What is 500videos? (Korean)</a> from <a href="http://vimeo.com/500videos">500videos</a> on <a href="https://vimeo.com">Vimeo</a>.</p>
            </div>
            <p class="date">참여기간 : 2014 3월 6일 낮 12시 ~ 24일 낮 12시  /  당첨자 발표 : 2014년 3월 24일 </p>
            <p>* 많은 분들의 기간 연장 문의에 힘입어, 이벤트 접수 마감을 1주 연장합니다. 성원과 관심에 감사드립니다. </p>
        </div>

        <div class="guide"> 
            <div class="sub no01">
                <h5>지원내용</h5>
                <ul>
                    <li><span>최우수(3팀)</span> : <br />1분 홍보 애니메이션 지원 (성우 포함, 각각 150만 원 상당)</li>
                    <li><span>우수 (30팀)</span> : <br />One line pitch (10초) 홍보 애니메이션  지원 (성우 지원,  각각 3만 원 상당)</li>
                </ul>
            </div>

            <div class="sub no02">
                <h5>지원 자격</h5>
                <ul>
                    <li>D.CAMP 온라인 회원 중, 스타트업 프로필이 완전히 작성된 팀</li>
                    <li>스타트업 프로필을 충실히 적어주실 수록 당첨확률 Up Up!!</li>
                </ul>
            </div>

            <div class="sub no03">
                <h5>후원</h5>
                <p><img src="/img/event0304/500videos.gif"> <a href="http://www.500videos.com/" target="_black">500Videos</a>  - 무료로 자신만의 비디오광고를 만드는 가장 쉽고 빠른방법</p>
            </div>
        </div>

        {? date("Y-m-d H") < "2014-03-24 12"}	
        <div class="write">
           <a class="mo" href="#">참여하기</a>
        </div>
        {/}
        
        {? (s.per & settings->permission1) == settings->permission1}<a href="/event/promotions_res/2" style="float: right;">[참여결과]</a>{/}
    </div>
    <!-- wrapBox end -->

</div>
<!-- eventBox end -->

<div class="modalBox">
    <div class="content">
        <div class="innerBox">

            {? !s.id}
            <!-- 로그인 안함 -->
            <div class="nologin">
                <p>이벤트에 참여하려면 회원가입이 필요합니다.</p>
                <p>로그인/회원 가입후 기업 기본 정보와 제품, 서비스 정보를 입력한뒤<br> 이벤트에 참여해주세요!</p>
            </div>
            <div class="row-fluid" style="">
                <div class="form-actions span12">
                    <button type="submit" class="btn btn-primary" onclick="javascript:window.location.href='/login'">로그인/회원가입</button>
                    <button type="button" class="btn cancel">취소하기</button>
                </div>
            </div>
            <!-- 로그인 안함 끝 -->
            {:}
            {? res}
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="name">회사명</label>
                    <div class="controls">
                         <select class="selectpicker" data-width="auto" name="startup" >
                            {@ res}
                            <option value="{.startup_id}" rel="{=htmlspecialchars(.bio)}">{.sname}</option>
                            {/}
                        </select>
                    </div>
                </div>    
            </div>


            <div id="satisfied" {? lack}style="display: none;"{/}> 
                <form class="form-horizontal" name="pro_f"> 
                    <div class="control-group">
                        <label class="control-label" for="name">회사 설명</label>
                        <div class="controls">
                             <textarea rows="3" name="bio" style="width: 80%;" placeholder="스타트업 한줄 설명" >{=htmlspecialchars(res[0].bio)}</textarea>
                        </div>
                    </div>     
                    <div class="control-group">
                        <label class="control-label" for="name">목표</label>
                        <div class="controls">
                            <textarea rows="3" name="target" style="width: 80%;" placeholder="2014년, 우리 스타트업의 목표는! (100자) " maxlength="100"></textarea>
                        </div>
                    </div>
                    <input type="hidden" name="startup_id" value="{res[0].startup_id}" />
                </form>
                <div class="row-fluid" style="">
                    <div class="form-actions span12">
                        <button type="submit" class="btn btn-primary">저장하기</button>
                        <button type="button" class="btn cancel">취소하기</button>
                    </div>
                    <div class="alert" style="display: none"></div>
                </div>
            </div>
            

            <!-- 필수항목 필요 -->
            <div id="required" {? !lack}style="display: none;"{/}>
                <div class="required">
                    <div class="info">
                        <span>{=round((12- lack_cnt )/ 12 * 100)}%</span>
                        {12- lack_cnt}/12의 정보가 입력되어 있습니다. 누락된 정보를 확인해 주세요.
                    </div>
                    <div class="company">
                        <h5>기업 기본 정보 </h5>
                        <ul>
                            <li {? res[0].lack_1}class="checked"{/}>회사명 </li>
                            <li {? res[0].lack_2}class="checked"{/}>한 줄 설명</li>
                            <li {? res[0].lack_3}class="checked"{/}>설립일 </li>
                            <li {? res[0].lack_4}class="checked"{/}>임직원수 </li>
                            <li {? res[0].lack_5}class="checked"{/}>사업분야 </li>
                            <li {? res[0].lack_6}class="checked"{/}>핵심기술 </li>
                            <li {? res[0].lack_7}class="checked"{/}>메일주소 </li> 
                            <li {? res[0].lack_8}class="checked"{/}>스타트업 소개</li>
                        </ul>
                    </div>
                    <div class="product">
                        <h5>제품, 서비스 정보</h5>
                        <ul>
                            <li {? res[0].lack_9}class="checked"{/}>제품 이름</li>
                            <li  {? res[0].lack_10}class="checked"{/}>Elevator pitch</li>
                            <li {? res[0].lack_11}class="checked"{/}>Problem</li>
                            <li {? res[0].lack_12}class="checked"{/}>Solution</li>
                        </ul>
                    </div>
                    <p class="desc">모든 정보가 입력되어야 이벤트에 참여하실 수 있습니다. 정보를 갱신해주세요!</p>
                </div>

                <div class="row-fluid" style="">
                    <div class="form-actions span12">
                        <button type="button" class="btn btn-primary" onclick="javascript:window.location.href='/startup/{res[0].startup_id}'">정보 갱신하기</button>
                        <button type="button" class="btn cancel">취소하기</button>
                    </div>
                </div>
            </div>
            <!-- 필수항목 필요 끝 -->
            {:}
            <div class="nologin">
                <p>참여할 수 있는 스타트업이 등록되어 있지 않습니다.</p>
                <p>스타트업을 등록하고 이벤트에 참여해주세요!</p>
            </div>
            <div class="row-fluid" style="">
                <div class="form-actions span12">
                    <button type="submit" class="btn btn-primary" onclick="javascript:window.location.href='/member/{s.ids}'">스타트업 연계/등록</button>
                    <button type="button" class="btn cancel">취소하기</button>
                </div>
            </div>
            {/}
            {/}
        </div>
    </div>
    <a class="img cancel"><img src="/img/event0304/btn_close.png"></a>
</div>

<div class="modalBoxBG"></div>

<script type="text/javascript">
//<![CDATA[
    $( ".write a" ).click(function() {
        $(".modalBox, .modalBoxBG").delay(0).css("display","block").addClass("move", 300, "linear");
        $(".modalBox .content").delay(100).addClass("move", 400, "linear");
    });
    $( ".cancel" ).click(function() {
        $(".modalBox .content").delay(300).removeClass("move", 400, "linear");
        $(".modalBox, .modalBoxBG").delay(0).removeClass("move", 300, "linear").delay(400).css("display","none");
    });

    $( "select[name=startup]" ).change(function() {
        var str = "";
        $( "select option:selected" ).each(function() {
          str += $( this ).attr("rel");
        });
        $( "textarea[name=bio]" ).val(str);
        $( "input[name=startup_id]" ).val($( this ).val());

        $("#required").slideUp();
        $("#satisfied").slideUp();

        var _id =  $( this ).val();
        $.get('/ajax_front/check_st_info/'+_id, function(_data){
            if (_data) {
                $("#required").html(_data);
                $("#required").slideDown();
            }
            else {
                $("#satisfied").slideDown();
            }
        })
    });

    $("#satisfied .btn-primary").click(function() {
        $(".alert").hide();
        if ($('textarea[name=bio]').val().length < 1) {
            $(".alert").text('회사 설명이 입력되지 않았습니다.');
            $(".alert").show();
            return false;
        }
        
        if ($('textarea[name=target]').val().length < 1) {
            $(".alert").text('목표가 입력되지 않았습니다.');
            $(".alert").show();
            return false;
        }

        $(this).hide();
        var frm = $('form[name=pro_f]');
        var get_url = '/ajax_front/promotion_apply';
        var set_data = frm.serialize();

        $.ajax({
            type : 'POST',
            url : get_url,
            data : set_data,
            dataType : 'json',
            success : function(_data) {
                $(".btn-primary").show();
                $('textarea[name=target]').val("");
                $(".modalBox .content").delay(300).removeClass("move", 400, "linear");
                $(".modalBox, .modalBoxBG").delay(0).removeClass("move", 300, "linear").delay(400).css("display","none");
                
                if (_data.error) {
                    alert(_data.error);
                }
                else {
                    alert("참여하였습니다.");
                }
            }
        });
    })
//]]>
</script>    
<!-- eventBox end -->