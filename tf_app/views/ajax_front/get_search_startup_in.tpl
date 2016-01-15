                    <!-- todo : 검색 리스트 -->
                    {? res}
                    <!-- list-result -->
                    <div class="list-result"> 
                            <ol class="list-unstyled">
                                {@ res}
                                <li><a href="/regist/startup_connected/{.id}/{user_id}">{.name} <span class="label label-default pull-right">선택</span></a></li>
                                {/}
                            </ol> 
                    </div>
                    <!-- /list-result -->
                    {:}
                    
                    
                    <!-- todo : 검색결과가 없을 때 --> 
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 다시 입력해주세요.</div>
                    {/}
                    
                    <!-- add-input -->
                    <div class="well well-sm add-input">
                        <h4>기업이 확인되지 않을 경우 새로 등록해 주세요.</h4>
                            <input type="text" class="form-control" placeholder=" 등록할 기업이름을 입력해주세요." {?!res}value="{key}"{/}>
                    </div>
                    <!-- /add-input -->