<!-- content -->
<div id="login" class="content">
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-4 col-md-offset-4"> 
        
        <!-- header -->
        <div class="header">
            <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>로그인</small></h1>
        </div>
        <!-- /header --> 
        
        <!-- panel -->
        <div class="panel panel-default">
            <div class="panel-body login-ex">
                <button class="btn btn-primary" onClick="location.href='/fb?next=/login&returl_url={= remove_tags(returl_url)}'"><span class="icon-facebook"></span> <span class="break"></span> Facebook으로 로그인하기</button>
            </div>
            <div class="panel-body login-in">
                <form  role="form" name="login_form" action="/login" method="post">
                    <input type="hidden" value="{? returl_url}{= remove_tags(returl_url)}{:}{next}{/}" name="returl_url" />
                    <fieldset>
                        <div class="form-group">
                            <label for="">아이디</label>
                            <input type="text" class="form-control" name="ids" id="inputLoginId" value="{ids}" placeholder="">
                        </div>
                        <!-- /form-group -->
                        <div class="form-group">
                            <label for="">비밀번호</label>
                            <input type="password" class="form-control" name="password" id="inputLoginPw" placeholder="">
                        </div>
                        <!-- /form-group -->
                        <button class="btn btn-primary" onclick="check_login(); return false;">로그인</button>
                        <div style="margin-left: 15px;" class="checkbox-inline">
                            <label>
                              <input type="checkbox" name="auto_login" value="1"> 로그인 상태유지 
                            </label>
                        </div>
                        <p><a href="/find_id">아이디/비밀번호 찾기</a> <span>|</span> <a href="/regist">회원가입</a></p>
                    </fieldset>
                </form>
            </div>
            <!-- /panel-body --> 
        </div>
        <!-- /panel --> 
        
        
        </div>
    </div>
</div>
<!-- /content--> 

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}
    
function check_login() {

    if ($('input[name=ids]').val().length < 1) {
        alert("아이디를 입력해주세요.");
        return false;
    }
    if ($('input[name=password]').val().length < 1) {
        alert("비밀번호를 입력해주세요.");
        return false;
    }
    document.login_form.submit();
}
//]]>
</script>