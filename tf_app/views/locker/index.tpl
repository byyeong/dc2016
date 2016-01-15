<!-- rowContent -->
    <div class="rowContent"  id="locker"> 
        <div class="page-header">
            <div class="container">
                <h2>Locker</h2>
            </div>
        </div>
        <!-- /page-header -->
         
        <!-- page-content -->
        <div class="page-content"> 
            <!-- container -->
            <div class="container">
            
                <div class="editor">
                    <div class="edit-header">
                        <h3><span class="icon-pencil"></span>월간 사물함 신청하기</h3>
                    </div>         
                        
                    {? res.state == 0} 
                    <div class="edit-body">
                        <form role="form" action="/locker/{date_}" method="post">
                            <input type="hidden" name="user_id" value="{res.user_id}" />
                            <input type="hidden" name="email" value="{email}" />
                            <fieldset>
                            <div class="well">
                                <dl class="dl-horizontal">
                                    <dt>사물함 번호</dt>
                                    <dd><strong class="text-danger">{res.locker_id}번</strong></dd>   
                               </dl>
                                <dl class="dl-horizontal">                                 
                                    <dt>사물함 사용기간</dt>
                                    <dd>{= substr(date_, 0, 4)}년 {= substr(date_, 5, 2)}월 1일 ~ {= substr(date_, 0, 4)}년 {= substr(date_, 5, 2)}월 {= date("t", mktime(0, 0, 0, substr(date_, 5, 2), 1, substr(date_, 0, 4)))}일</dd>
                                </dl> 
                            </div>
                            <div class="form-actions text-center">
                                <button class="btn btn-primary">신청하기</button>
                            </div>
                            </fieldset>
                        </form>
                        </div>
                    </div>
                    <!-- / -->
                         
                    {:}
                    <div class="edit-body">
                        <div class="alert alert-danger  text-center">
                                {res.name}님의 사물함 신청이 완료되었습니다. <br>사물함 번호와 사용기간을 확인하시기 바랍니다.
                        </div>
                        <div class="well">
                            <dl class="dl-horizontal">
                                 <dt>사물함 번호</dt>
                                 <dd><strong class="text-danger">{res.locker_id}번</strong></dd>
                             </dl>
                             <dl class="dl-horizontal">
                                <dt>사물함 사용기간</dt>
                                <dd>{= substr(date_, 0, 4)}년 {= substr(date_, 5, 2)}월 1일 ~ {= substr(date_, 0, 4)}년 {= substr(date_, 5, 2)}월 {= date("t", mktime(0, 0, 0, substr(date_, 5, 2), 1, substr(date_, 0, 4)))}일</dd>
                            </dl>                
                        </div>   
                    </div> 
                    <!-- / --> 
                    {/} 
                    
                </div>
                <!-- /editor -->
                
                
            </div>
            <!-- /container --> 
        </div>
        <!-- /page-content --> 
    </div>
    <!-- /rowContent --> 