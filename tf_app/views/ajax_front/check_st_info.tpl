                <div class="required">
                    <div class="info">
                        <span>{=round((12 - lack_cnt) / 12 * 100)}%</span>
                        {12- lack_cnt}/12의 정보가 입력되어 있습니다. 누락된 정보를 확인해 주세요.
                    </div>
                    <div class="company">
                        <h5>기업 기본 정보 </h5>
                        <ul>
                            <li {? res.lack_1}class="checked"{/}>회사명 </li>
                            <li {? res.lack_2}class="checked"{/}>한 줄 설명</li>
                            <li {? res.lack_3}class="checked"{/}>설립일 </li>
                            <li {? res.lack_4}class="checked"{/}>임직원수 </li>
                            <li {? res.lack_5}class="checked"{/}>사업분야 </li>
                            <li {? res.lack_6}class="checked"{/}>핵심기술 </li>
                            <li {? res.lack_7}class="checked"{/}>메일주소 </li> 
                            <li {? res.lack_8}class="checked"{/}>스타트업 소개</li>
                        </ul>
                    </div>
                    <div class="product">
                        <h5>제품, 서비스 정보</h5>
                        <ul>
                            <li {? res.lack_9}class="checked"{/}>제품 이름</li>
                            <li  {? res.lack_10}class="checked"{/}>Elevator pitch</li>
                            <li {? res.lack_11}class="checked"{/}>Problem</li>
                            <li {? res.lack_12}class="checked"{/}>Solution</li>
                        </ul>
                    </div>
                    <p class="desc">모든 정보가 입력되어야 이벤트에 참여하실 수 있습니다. 정보를 갱신해주세요!</p>
                </div>

                <div class="row-fluid" style="">
                    <div class="form-actions span12">
                        <button type="button" class="btn btn-primary" onclick="javascript:window.location.href='/startup/{res.id}'">정보 갱신하기</button>
                        <button type="button" class="btn cancel">취소하기</button>
                    </div>
                </div>
<script type="text/javascript">
//<![CDATA[
    $( ".cancel" ).click(function() {
        $(".modalBox .content").delay(300).removeClass("move", 400, "linear");
        $(".modalBox, .modalBoxBG").delay(0).removeClass("move", 300, "linear").delay(400).css("display","none");
    });
    //]]>
</script>    