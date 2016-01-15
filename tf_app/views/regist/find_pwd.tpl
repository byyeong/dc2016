<!-- content -->
<div id="userAccount" class="content" > 
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">   
                
            <!-- header -->
            <div class="header">
                <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>회원정보</small></h1>
            </div>
            <!-- /header -->     
            
            <!-- panel -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <ul class="nav nav-tabs">
                        <li><a href="/find_id">아이디 찾기</a></li>
                        <li  class="active"><a href="/find_pwd">비밀번호 찾기</a></li>
                    </ul>
                </div>
                
                <div class="panel-body"> 
                        
                        <!-- #finduser-pw -->
                        <div class="tab-pane" id="finduser-pw">
                            <h2>비밀번호 찾기</h2>
                            <p>아래의 정보를 채워 주세요. 회원님의 비밀번호를 초기화합니다.</p>
                            <form  role="form" name="find_pwd_form" method="post">
                                <fieldset>
                                    <div class="form-group">
                                        <label for="inputUserId">아이디</label>
                                        <input type="text" class="form-control" name="ids" id="inputUserId" placeholder="">
                                    </div>
                                    <!-- /form-group -->
                                    <div class="form-group">
                                        <label for="inputUserEmail">메일주소</label>
                                        <input type="email" class="form-control" name="email" id="inputUserEmail" placeholder="">
                                        <span class="help-block">가입시 입력한 메일 주소를 입력해주세요. </span> </div>
                                    <!-- /form-group -->
                                    
                                    <button class="btn btn-primary find-pwd" href="#md-finduser-pw" >비밀번호 초기화</button>
                                </fieldset>
                            </form>
                        </div>
                        <!-- /#finduser-pw --> 
                         
                </div>
                <!-- /panel-body --> 
            </div>
            <!-- /panel --> 
             
             
        </div>
    </div> 
</div>
<!-- /content-->

 

<!-- #md-finduser-pw -->
<div class="modal fade" id="md-finduser-pw" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  
</div>
<!-- /#md-finduser-pw -->

<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

$('.find-pwd').click(function(e){
    e.preventDefault();
    $('#md-finduser-pw').html('');

    var get_url = '/ajax_front/find_pwd/';
    var frm = $('form[name=find_pwd_form]');
    var set_data = frm.serialize();;

    $.ajax({
        type : 'POST',
        url : get_url,
        data : set_data,
        dataType : 'html',
        success : function(_data) {
            $('#md-finduser-pw').html(_data);
            $('#md-finduser-pw').modal('show');
        }
    });
});
//]]>
</script>