                                            <br>
                                            <h3>제품/서비스 정보 <small>(등록하신 제품/서비스 정보는 기업 프로필 페이지의 제품/서비스 정보와 연동됩니다.)</small></h3>
                                            <br>
                                            <input type="hidden" class="form-control" name="profile_url" value="http://dcamp.kr/startup/{id}"> 

                                            <div class="form-group"> 
                                                <label class="control-label">
                                                    제품/서비스명
                                                </label><span class="text-danger"> *</span>
                                                {? res}
                                                <select class="form-control" name="s_subject">
                                                    {@ res}
                                                    <option value="{.name}" rel="{.id}" {? .name == ser.name}selected="selected"{/}>{.name} </option>
                                                    {/}
                                                </select>
                                                {:}
                                                <input type="text" class="form-control" name="s_subject" value="{app.s_subject}">
                                                {/} 
                                            </div>
                                            <!-- / form-group-->

                                            <div class="form-group"> 
                                                <label class="control-label">
                                                    제품/서비스 한줄 설명
                                                </label><span class="text-danger"> *</span>
                                                <input type="text" class="form-control" name="s_description" value="{ser.des_ele}" placeholder="제품/서비스를 한 줄로 설명해 주세요."> 
                                            </div>
                                            <!-- / form-group-->

<script>
{? ser}
get_service('{ser.id}');
{:}
get_service('{res_f.id}');
{/}
$('select[name=s_subject]').change(function(){
    get_service($("select[name=s_subject] option:selected").attr('rel'));
});
</script>