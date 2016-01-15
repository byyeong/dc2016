<!-- content -->
<div id="userCheck" class="content" > 
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-sm-offset-3 col-md-6 col-md-offset-3"> 
        
            <!-- header -->
            <div class="header">
                <h1><a href="/"><img src="/img/logo.png" alt="D.CAMP"></a> <small>회원인증</small></h1>
            </div>
            <!-- /header --> 
                        
            <!-- panel -->
            <div class="panel panel-default">
                {? res}
                <div class="panel-body complete">  
                    <h3 class="text-center"><span class="icon icon-smile icon-large"></span> 회원인증 완료!!</h3>
                    <p>회원님은 성공적으로 회원가입이 완료되었습니다. </p><br>

                    <a href="/" class="btn btn-default btn-sm">홈으로</a>
                </div>
                <!-- /panel-body --> 
                {:}
                <div class="panel-body warning">
                    <h3 class="text-center"><span class="icon icon-warning-sign"></span> 회원인증 오류</h3>
                    <div class="alert alert-warning">
                        <strong>Oops!</strong> 회원님의 본인인증에 문제가 발생했습니다.  
                        <p>인증메일의 유효기간이 지났거나 잘못된 링크를 통해 접속하면 인증이 되지 않습니다. 다시 시도해 주세요</p>
                    </div>
                    <div lcass="text-center"><a href="/" class="btn btn-default  btn-sm">홈으로</a></div>
                </div>
                <!-- /panel-body --> 
                {/}
            </div>
            <!-- /panel --> 
            
        </div>
    </div>
</div>
<!-- /content-->