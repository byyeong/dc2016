
            <!-- contentswrap -->
            <div class="col-md-10 contentswrap"> 
                <!-- section -->
                <section> 
                    
                    <!-- panel -->
                    <div id="pane-entrance-locker" class="panel panel-default"> 
                        <!-- panel-heading -->
                        <div class="panel-heading">
                            <h2><span class="glyphicon glyphicon-cog"></span><span class="break"></span>사물함 번호관리</h2>
                            <div class="actions"> 
                                <span class="break"></span>
                                <a title="" data-toggle="tooltip" class="btn-list" href="/admin_entrance/locker" data-original-title="사물함 사용목록"><span class="glyphicon  glyphicon-align-justify"></span></a> 
                            </div>
                        </div>
                        <!-- /panel-heading --> 
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label">사물함 추가</div>
                                    <div class="col-xs-12 col-sm-10 col-md-10 ">
                                        <form method="post" action="/admin_entrance/locker_edit">
                                        <div class="input-group" style="width:160px;">
                                            <input type="text" class="form-control" name="locker" required="required" placeholder="사물함 번호">
                                            <div class="input-group-btn">
                                                <button class="btn btn-default">추가</button>
                                            </div>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                                <!-- /form-group -->
                                <div class="form-group">
                                    <div class="col-xs-12 col-sm-2 col-md-2 control-label">사물함 삭제</div>
                                    <div class="col-xs-12 col-sm-10 col-md-10 ">
                                        <form method="post" action="/admin_entrance/locker_edit">
                                            <select class="selectpicker" data-width="auto" name="del_locker">
                                                {@ locker}
                                                <option value="{.llocker}">{.llocker}</option>
                                                {/}
                                            </select>
                                            <button class="btn btn-default">삭제</button>
                                        </form>
                                    </div>
                                </div>
                                <!-- /form-group -->
                            </div>
                        </div>             
                    </div>
                    <!--/panel --> 
                    
                    
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