<div class="ui-state-default  rounded entry-itemOption comp_form_f"> 
    {? ress}
    <div class="set-wrap pull-right">                                                            
        <button type="button" class="btn btn-default btn-xs delete" onclick="delete_form_sort(this); return false;"><span class="icon-trash"></span></button> 
    </div>
    {/}
    <form onsubmit="return false;" name="m_form_file_add">
        <fieldset>  
            <div class="form-group">
                <div class="col-xs-12 col-sm-2 col-md-2 control-label">질문 제목</div>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <input type="text" class="form-control" name="title" value="{ress.title}" required="required" placeholder="">
                </div>
            </div>
            <!-- /form-group -->
            
            <div class="form-group">
                <div class="col-xs-12 col-sm-2 col-md-2 control-label">도움말 텍스트</div>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <input type="text" class="form-control" name="sub" value="{ress.sub}" >
                </div>
            </div>
            <!-- /form-group -->
       
            
            <div class="form-group">
                <div class="col-xs-12 col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2">
                    <input type="file" disabled="disabled">
                </div>
            </div>
            <!-- /form-group -->   
            
            <div class="form-group"> 
                <div class="col-xs-12 col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="1" name="req" {? ress.req}checked="checked"{/}>
                            필수입력</label>
                    </div>
                </div>
            </div>
            <!-- /form-group -->
            
            <div class="action-wrap">
                <div class="col-sm-offset-2 col-md-offset-2">  
                    <button  class="btn btn-info btn-sm" onclick="add_comp_form_file(this, {? ress}1{:}0{/}); return false;">저장</button> 
                </div>
            </div>
            <input type="hidden" name="id" value="{ress.id}" />
            <input type="hidden" name="competition_id" value="{ress.competition_id}" />
            <input type="hidden" name="type" value="file" />
        </fieldset>
    </form>
</div>
<!-- /ui-state-default  -->
