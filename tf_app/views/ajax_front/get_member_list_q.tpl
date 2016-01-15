                    <br />
                    {? res}
                    <div class="list-result">
                        <ol class="list-unstyled">
                            {@res}
                            <li><a href="#" onclick="set_email('{.email}'); return false;">{.name} ( {.ids} ) : {.email}  <span class="label label-default pull-right">선택</span></a></li>
                            {/}
                        </ol>
                    </div>
                    {:}
                    <div class="alert alert-danger"><strong>Oops!</strong> 검색결과가 없습니다. 다시 입력해주세요.</div>
                    {/}
