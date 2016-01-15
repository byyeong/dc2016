<!-- rowContent -->
<div class="rowContent"  id="compProfile"> 
    <!-- page-header -->
    <div class="page-header">
        <div class="container">
            <h1>기업정보관리</h1>
        </div>
    </div>
    <!-- /page-header --> 
    
    <!-- page-content -->
    <div class="page-content"> 
        <!-- container -->
        <div class="container"> 
            <div class="content">
                <!--
                <ul class="nav nav-tabs">
                    <li  class="active"><a href="/startup/edit/{res.id}">기업정보 수정</a></li>
                    <li><a href="/recruit/add/" >채용정보</a></li>
                </ul>
                -->
                <!-- modifyProfile -->
                <div class="modifyProfile">
                    <h3>기업정보 수정 </h3>
                    <form class="form-horizontal" role="form" method="post" onsubmit="return false;" name="edit_st_form" action="/startup/edit/{res.id}">
                        <input type="hidden" name="id" value="{res.id}" />
                        <input type="hidden" name="state" value="{res.state}" />
                        <input type="hidden" name="cnt_sk" id="cnt_sk" value="{? sizeof(res_sk) > 0}{=sizeof(res_sk)}{:}1{/}" />
                        <input type="hidden" name="cnt_int" id="cnt_int" value="{? sizeof(res_in) > 0}{=sizeof(res_in)}{:}1{/}" />
                    <fieldset> 
                        
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">회사명</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">  
                                    <input type="text" class="form-control" placeholder="회사명" id="name" name="name" value="{res.name}"> 
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">한 줄 설명</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="text" class="form-control" placeholder="한 줄 설명"  name="bio" value="{=htmlspecialchars(res.bio)}">
                                </div>
                            </div>
                            <!-- /form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">소개</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <textarea row="3"  class="form-control" name="description">{res.description}</textarea>
                                </div>
                                <!-- /control-input --> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">로고</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="hidden" name="img" id="img" value="">
                                    <!--<iframe width="100%" scrolling="no" height="160px" frameborder="0" id="photo_uploader" style="overflow: hidden; border: 0pt none; clear: both;" {? res.logo}src="/ajax/photo_form_file/img/160x160?old={=safe_js(res.logo)}"{:}src="/ajax/photo_form_file/img/160x160?old={=safe_js('/img/default-img-company.png')}"{/} allowtransparency="true"></iframe>-->
                                    <img class="img-thumbnail" src="{res.logo}?date={=date('his')}" id="img_img" onclick="toggle_img();return false;">
                                    <div id="div_img_change" style="display: none;">
                                        <iframe  height="500" frameborder="0" width="100%" scrolling="no" id="frm" allowTransparency="true" src="/ajax_front/form_file?sub_dir={=substr(res.logo, 1)}&which=img" ></iframe>
                                    </div>
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label"> 설립일 </div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <!-- datepicker -->
                                    <div class="bfh-datepicker" data-format="y.m.d">
                                        <div class="input-group bfh-datepicker-toggle" data-toggle="bfh-datepicker"> <span class="input-group-addon"><span class="icon-calendar"></span></span>
                                            <input type="text" class="form-control datepicker" name="founded" value="{res.founded}" readonly>
                                        </div>
                                    </div>
                                    <!-- /datepicker --> 
                                </div>
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">임직원수</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <div class="input-group"> 
                                        <span class="input-group-addon"><span class="icon-group"></span></span>
                                        <input type="number" class="form-control" name="number" value="{res.number}">
                                        <span class="input-group-addon">명</span>
                                    </div>
                                    <!-- /input-group -->
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">{? res.stype == 1}사업분야{/}{? res.stype == 2}투자분야{/}</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    {? res_in}{@ res_in}
                                    <p class="form-group-tag" id="add_int_{.key_+1}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>                                        
                                        <input type="text" class="form-control suggest_job" id="suggest_job" name="inter_{.key_+1}" value="{._value}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}{:}
                                    <p class="form-group-tag" id="add_int_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>                                        
                                        <input type="text" class="form-control suggest_job" name="inter_1" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}
                                    <!-- /well --> 
                                    
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_int(this); return false;"><span class="icon-plus"></span> 추가 하기</button>
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">{? res.stype == 1}핵심기술{/}{? res.stype == 2}투자전략{/}</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    {? res_sk}{@ res_sk}
                                    <p class="form-group-tag" id="add_sk_{.key_+1}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_{.key_+1}" value="{._value}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {/}{:}
                                    <p class="form-group-tag" id="add_sk_1">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button> 
                                        <input type="text" class="form-control suggest_job" id="feeds_contents" name="skill_1" placeholder="" onkeydown="return ignoreEnter(event);">                                       
                                    </p>
                                    {/}
                                    <!-- /well --> 
                                    
                                    <button type="button" class="btn btn-default btn-sm" onclick="add_sk(this); return false;"><span class="icon-plus"></span> 추가 하기</button>
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
{? res.stype == 1}
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">웹사이트</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="url" class="form-control" value="{? res.website}{res.website}{:}http://{/}" name="website">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">블로그</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="url" class="form-control" value="{? res.blog}{res.blog}{:}http://{/}" name="blog">
                                </div> 
                            </div>
                            <!-- /form-group -->

                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">SNS</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <p class="input-group"> <span class="input-group-addon"><span class="icon-twitter"></span>  &nbsp;  Twitter</span>
                                        <input type="text" placeholder="mytwitterID" class="form-control" name="twitter" value="{res.twitter}">
                                         </p>
                                    <!-- /input-group -->
                                    <p class="input-group"> <span class="input-group-addon"><span class="icon-facebook"></span> &nbsp;  Facebook</span>
                                        <input type="text" placeholder="myfacebookID" class="form-control" name="facebook" value="{res.facebook}"> </p>
                                     <!-- /input-group -->
                                </div> 
                            </div>
                            <!-- /form-group -->
{/}
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">메일주소</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="email" class="form-control" placeholder="" name="email" value="{res.email}">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">주소</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="text" class="form-control" placeholder="" name="addr" value="{res.addr}">
                                </div> 
                            </div>
                            <!-- /form-group -->
                            
                            
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-3 col-md-3 control-label">연락처</div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <input type="tel" class="form-control" placeholder="" name="tel" value="{res.tel}">
                                </div> 
                            </div>
                            <!-- /form-group --> 
                           
                            <div class="action-wrap">
                                <div class="col-sm-offset-3 col-md-offset-3">
                                    <a href="#" class="btn btn-default" onclick="javascript:location.href='/startup/{res.id}'">취소</a>
                                    <a href="#" class="btn btn-primary" onclick="go_submit(this); return false;">확인</a>
                                </div>
                            </div>
                          
                    </fieldset>
                </form>
                </div>
                <!-- /modifyProfile -->
           </div>      
        </div>
        <!-- /container --> 
    </div>
    <!-- /page-content --> 
</div>
<!-- /rowContent -->

<script type="text/javascript">
//<![CDATA[

{? job}
$( ".suggest_job" ).autocomplete({source: {job}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}
    
{? skill}
$( ".suggest_skill" ).autocomplete({source: {skill}}, {
    matchContains: true,
    minChars: 0,
    width: 172,
    max: 10,
    multiple: false,
    scroll: true,
    scrollHeight: 300,
    formatItem: function(item){ 
        return item._value; 
    }
});
{/}

function go_submit(_this)
{

    if ($('#name').val() === '') {
        alert("회사명을 입력주세요.");
        return false;
    }
    $(_this).hide();
    document.edit_st_form.submit();
}

function del_box(_this)
{
    $(_this).parent().remove();
}

function add_sk(_this)
{   
    var v = $("#cnt_sk").val();
    var get_url = "/ajax_front/member_add_s/1";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_sk").val(parseInt(v)+1);
        {? job}
        $( ".suggest_job" ).autocomplete({source: {job}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

function add_int(_this)
{   
    var v = $("#cnt_int").val();
    var get_url = "/ajax_front/member_add_i/1";
    var set_data ={
        "data": parseInt(v)+1,
    };
    
    $.post(get_url, set_data,function(_data) {
        $(_this).before(_data);
        $("#cnt_int").val(parseInt(v)+1);
        {? job}
        $( ".suggest_job" ).autocomplete({source: {job}}, {
            matchContains: true,
            minChars: 0,
            width: 172,
            max: 10,
            multiple: false,
            scroll: true,
            scrollHeight: 300,
            formatItem: function(item){ 
                return item._value; 
            }
        });
        {/}
    });
}

//]]>
</script>