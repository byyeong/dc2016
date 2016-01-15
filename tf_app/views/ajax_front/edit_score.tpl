                                            <div class="ui-state-default entry-item" id="sc_f_{res.sid}"> 
                                                <div class="set-wrap pull-right">                                                            
                                                    <button type="button" class="btn btn-default btn-xs edit" onclick="get_score_field('{res.sid}'); return false;"><span class="icon-edit"></span></button> 
                                                    <button type="button" class="btn btn-default btn-xs delete" onclick="del_score_field('{res.sid}'); return false;"><span class="icon-trash"></span></button> 
                                                </div> 
                                                <div class="form-group">
                                                        <label class="col-xs-12 col-sm-2 col-md-2 control-label">{res.name} </label>  
                                                        <div class="col-xs-12 col-sm-4 col-md-4"><input type="text" class="form-control sc_l_one" value="{res.score}" placeholder="점수" disabled="disabled"> / {res.total}</div> 
                                                </div> 
                                            </div>