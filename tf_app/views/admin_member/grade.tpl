            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section > 
                    
                    <!-- panel -->
                    <div class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span>회원 등급 설정</h2>
                            <div class="actions"> <span class="break"></span><a href="/admin_member/grade_list" class="btn-list"  data-toggle="tooltip" title="목록보기"><span class="glyphicon  glyphicon-align-justify"></span></a> </div>
                        </div>
                        <!-- /panel-heading -->
                        
                        <form class="form-horizontal" name="grade_form" action="/admin_member/grade/{res.id}" method="post" onsubmit="return false;">
                            <input type="hidden" name="id" value="{res.id}" />
                            <!-- panel-body -->
                            <div class="panel-body">
                                <fieldset>
                                    <div class="form-group error">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >회원등급명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <div class="input-group">
                                                <input type="hidden" id="check" value="{? res}0{:}1{/}" />
                                                <input type="text" class="form-control"  id="inputGradeName" placeholder="등급명을 입력하세요" name="name" value="{res.name}" {? res}readonly{/}>
                                                {? !res}
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default" type="button" data-toggle="tooltip" title="중복체크" onclick="check_grade(); return false;"><span class="glyphicon  glyphicon-ok"></span></button>
                                                </span> 
                                                {/}
                                            </div>
                                            <p class="text-danger" style="display: none;"><span class="glyphicon  glyphicon-remove"></span> 사용할 수 없는 이름입니다.</p>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >등급설명</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="text" class="form-control" id="inputGradeDesc" name="description" value="{res.description}" >
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >등급 이미지</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="hidden" name="image" id="image" value="">
                                            <iframe width="100%" scrolling="no" height="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/image/80x80?old={=safe_js(res.image)}" allowtransparency="true"></iframe>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group">
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >아이콘 업로드</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <input type="hidden" name="icon" id="icon" value="">
                                            <iframe width="100%" scrolling="no" height="80px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" src="/ajax/photo_form_file/icon/80x80?old={=safe_js(res.icon)}" allowtransparency="true"></iframe>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >권한설정</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission1" value="1" {? (res.permission & settings->permission1) == settings->permission1}checked="checked"{/}>
                                                모든권한 
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission2" value="2" {? (res.permission & settings->permission2) == settings->permission2}checked="checked"{/}>
                                                공간공유 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission3" value="4" {? (res.permission & settings->permission3) == settings->permission3}checked="checked"{/}>
                                                이벤트 참여 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission4" value="8" {? (res.permission & settings->permission4) == settings->permission4}checked="checked"{/}>
                                                이벤트 생성 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission5" value="16" {? (res.permission & settings->permission5) == settings->permission5}checked="checked"{/}>
                                                기타 관리 접근 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission6" value="32" {? (res.permission & settings->permission6) == settings->permission6}checked="checked"{/}>
                                                서비스 상세 현황 보기 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission7" value="64" {? (res.permission & settings->permission7) == settings->permission7}checked="checked"{/}>
                                                매월 10시간 공간공유 바로 사용 </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="permission8" value="128" {? (res.permission & settings->permission8) == settings->permission8}checked="checked"{/}>
                                                디자인 라운지 멤버십 </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >등급 노출 여부</div>
                                        <div class="col-xs-12 col-sm-10 col-md-10">
                                            <label class="radio-inline">
                                                <input type="radio" name="visible" value="1" {?res.visible == 1}checked{/}>
                                                보임 </label>
                                            <label class="radio-inline">
                                                <input type="radio" name="visible" value="0" {?res.visible == 0}checked{/}>
                                                숨김 </label>
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                </fieldset>
                            </div>
                            <!-- /panel-body -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default"> 취소 </button>
                                    <button type="submit" class="btn btn-primary" onclick="go(); return false;"> 등록 </button>
                                    </div>
                                </div>
                            </div>
                        </form>
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
    
function check_grade() {
    var name = $('#inputGradeName').val();
    var get_url = '/ajax/check_grade';
    var set_data ={
        "data": name,
    };
    
    if (name.length < 1) {
        alert("회원등급명을 입력해주세요.");
        return false;
    }
    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'json',
        success : function(_data) {

            if (_data.error === 0) {
                $('#check').val(0);
                $('.text-danger').hide();
                alert('사용 가능 합니다.');
            }
            else {
                $('#check').val(1);
                $('.text-danger').show();
            }
        }
    });
}

function go() {
    
    if ($('#check').val() === "1") {
        alert("회원등급명 중복체크를 해주세요.");
        return false;
    }
    document.grade_form.submit();
}

function change() {
    $('#check').val(1);
    $('.text-danger').show();
}
    
//]]>
</script>