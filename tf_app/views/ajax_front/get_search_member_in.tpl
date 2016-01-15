                    <!-- todo : 검색 리스트 -->
                    {? res}
                    <!-- list-result -->
                    <div class="list-result"> 
                            <ol class="list-unstyled">
                                {@ res}
                                <li><a href="#" onclick="send_rec('{v}','{.name}'); return false;">{.name} ({.ids})<span class="label label-default pull-right">선택</span></a></li>
                                {/}
                            </ol> 
                    </div>
                    <!-- /list-result -->
                    {:}
                    
                    
                    <!-- todo : 검색결과가 없을 때 --> 
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 다시 입력해주세요.</div>
                    {/}