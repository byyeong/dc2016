                                            <div class="ui-state-default  rounded entry-itemOption" style="display: none">  
                                                <div class="set-wrap pull-right">                                                            
                                                    <button type="button" class="btn btn-default btn-xs delete" onclick="del_score_field_r('{ress.id}'); return false;"><span class="icon-trash"></span></button> 
                                                </div> 
                                                <fieldset>   
                                                    <input type="hidden" name="s_id" value="{ress.id}" />
                                                    <div class="form-group">
                                                        <div class="col-xs-12 col-sm-4 col-md-2 control-label">항목 제목</div>
                                                        <div class="col-xs-12 col-sm-8 col-md-10"> 
                                                            <input type="text" class="form-control" name="s_name" value="{ress.name}" placeholder="">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group -->
                                                    <div class="form-group">
                                                        <div class="col-xs-12 col-sm-4 col-md-2 control-label">항목 점수</div>
                                                        <div class="col-xs-12 col-sm-6 col-md-4"> 
                                                            <input type="text" class="form-control" name="s_score" value="{ress.score}" placeholder="" onkeyup="onlyNumberCom(this);" style="ime-mode:disabled">
                                                        </div>
                                                    </div>
                                                    <!-- /form-group -->
                                                    <div class="action-wrap">
                                                        <div class="col-sm-offset-2 col-md-offset-2">  
                                                            <button href="#" onclick="add_score_field(this); return false;" class="btn btn-info btn-sm">확인</button> 
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>