           
            <!-- contentwrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    
                    <!-- panel #pane-main-listset -->
                    <div id="pane-main-listset" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon  glyphicon-cog"></span><span class="break"></span> 콘텐츠 노출 관리</h2> 
                        </div>
                        <!-- /panel-heading -->
                        <form class="form-horizontal" method="post" action="/admin_main">
                            <input type="hidden" name="save" value="1" />
                            <!-- panel-body -->
                            <div class="panel-body"> 
                                <fieldset>
                                    <legend>콘텐츠 번호 입력</legend>
                                    <div class="alert alert-info" style="margin-bottom:20px;">
                                        콘텐츠 번호는 생성한 콘텐츠 주소의 마지막 번호입니다.  아래의 예시에서 마지막 숫자 [<strong>16</strong>]을 입력하면 됩니다. 
                                        <p>뉴스, 이벤트 예) http://dcamp.kr/event/apply/ <strong>16</strong> </p>
                                        <p>스타트업 예) http://dcamp.kr/startup/ <strong>1</strong> </p>
                                        <p>피플 예) http://dcamp.kr/member/ <strong>dcamp</strong> </p>
                                    </div>
                                    {@ res}
                                    <div class="form-group"> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 control-label" >콘텐츠 {.key_ + 1}</div>                                        
                                        <div class="col-xs-12 col-sm-10 col-md-10"> 
                                                <div class="form-inline">
                                                    <select class="selectpicker" data-width="auto" name="type_{.key_ + 1}">
                                                        
                                                        <option value="1" {? .type == 1}selected="selected"{/}>이벤트</option>
                                                        <option value="7" {? .type == 7}selected="selected"{/}>경진대회</option>
                                                        <option value="2" {? .type == 2}selected="selected"{/}>Notice</option>
                                                        <option value="5" {? .type == 5}selected="selected"{/}>Contents</option>
                                                        <option value="8" {? .type == 8}selected="selected"{/}>Office Hours</option>
                                                        <option value="10" {? .type == 10}selected="selected"{/}>Benefit</option>
                                                        <!--option value="3" {? .type == 3}selected="selected"{/}>피플</option>
                                                        <option value="4" {? .type == 4}selected="selected"{/}>스타트업</option-->
                                                        
                                                    </select>
                                                     
                                                    <input type="text" class="form-control" name="cid_{.key_ + 1}" value="{.cid}" placeholder="콘텐츠의 아이디를 입력해주세요" >
                                                    
                                                </div> 
                                                <!-- /form-group-sub --> 
                                        </div>
                                    </div>
                                    <!-- /form-group -->
                                    {/}
                                    
                                </fieldset>
                            </div>
                            <!-- /panel-body --> 
                            
                            <!-- pane-footer -->
                            <div class="panel-footer">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-offset-2 col-sm-10 col-md-offset-2 col-md-10">
                                    <button type="button" class="btn btn-default" onclick="javascript:location.href='/admin_main'">취소</button>
                                    <button type="submit" class="btn btn-primary">확인</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /panel-footer -->
                        </form>
                    </div>
                    <!-- /panel #pane-main-listset --> 
                </section>
                <!-- /section --> 
            </div>
            <!-- /contentwrap --> 
            
            
<script type="text/javascript">
//<![CDATA[

{? msg}
    alert('{msg}');
{/}

//]]>
</script>