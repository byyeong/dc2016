                    <!-- todo : 검색 리스트 -->
                    {? res}
                    <!-- list-result -->
                    <div class="list-result"> 
                            <ol class="list-unstyled">
                                {@ res}
                                {? form}
                                <li><a href="#" onclick="{?!is_diable_select}send_com('{.name}', '{form}'); {/}return false;">{.name} {?!is_diable_select}<span class="label label-default pull-right">선택</span>{/}</a></li>
                                {:}
                                <li><a href="#" onclick="{?!is_diable_select}send_com('{.name}');{/} return false;">{.name} {?!is_diable_select}<span class="label label-default pull-right">선택</span>{/}</a></li>
                                {/}
                                {/}
                            </ol> 
                    </div>
                    <!-- /list-result -->
                    {:}
                    
                    <br />
                    <!-- todo : 검색결과가 없을 때 --> 
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 새로 입력할까요?</div>
                    {/}
                    
                    <!--
                    <div class="well well-sm add-input">
                        <h4>기업이 확인되지 않을 경우 새로 등록해 주세요.</h4>
                            <input type="text" class="form-control" id="new_startup" placeholder=" 등록할 기업이름을 입력해주세요." {?!res}value="{key}"{/}>
                    </div>
                    //-->