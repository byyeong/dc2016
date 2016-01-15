<div class="ui-state-default  rounded entry-itemOption pro_form_e" style="display: none;"> 
    {? ress}
    <div class="set-wrap pull-right">                                                            
        <button type="button" class="btn btn-default btn-xs delete" onclick="delete_form_sort(this); return false;"><span class="icon-trash"></span></button> 
    </div>
    {/}
    <form onsubmit="return false;" name="m_form_add">
        <fieldset>  
            <div class="form-group">
                <div class="col-xs-12 col-sm-2 col-md-2 control-label">질문 제목</div>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <textarea type="text" class="form-control" name="title" required="required" placeholder="">{=str_replace("<br>", "", ress.title)}</textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-12 col-sm-2 col-md-2 control-label">도움말 텍스트</div>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <textarea type="text" class="form-control" name="sub" >{=str_replace("<br>", "", ress.sub)}</textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-12 col-sm-2 col-md-2 control-label">질문 유형</div>
                <div class="col-xs-12 col-sm-10 col-md-10">
                    <select class="selectpicker" data-width="auto" name="type" onchange="make_form(this); return false;">
                        <option value="text" {? ress.type == 'text'}selected="selected"{/}>텍스트</option>
                        <option value="textarea" {? ress.type == 'textarea'}selected="selected"{/}>단락 텍스트</option>
                        <option value="query" {? ress.type == 'query'}selected="selected"{/}>객관식 질문</option>
                    </select>
                </div>
            </div>

            <div class="form-group m_form" id="f_text" {? ress && ress.type != 'text'}style="display: none;"{/}>
                <div class="col-xs-12 col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2">
                    <input type="text"  class="form-control"  disabled="disabled" placeholder="답변">
                 </div>
            </div>
            
            <div class="form-group m_form" id="f_textarea" {? ress.type != 'textarea'}style="display: none;"{/}>
                <div class="col-xs-12 col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2">   
                    <textarea class="form-control"  disabled="disabled" placeholder="답변"></textarea>
               </div>
            </div>
            
            <div class="form-group m_form" id="f_query" {? ress.type != 'query'}style="display: none;"{/}>
                <div class="col-xs-12 col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2">
                    <input type="hidden" id="query_cnt" name="query_cnt" value="{? ress.opts}{=sizeof(ress.opts)}{:}2{/}" />
                    <ul class="list-unstyled entry-option-list">
                        {? ress.opts}{@ ress.opts}{?.value_}
                        <li><button type="button" class="close" aria-hidden="true" onclick="javascript:$(this).parent().remove();">&times;</button>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" name="options" disabled >
                                  </span> 
                                <input tyle="text" name="option_con_{.key_ + 1}" value="{.value_}" class="form-control" placeholder="옵션"> 
                            </div>
                        </li>
                        {/}{/}{:}
                        <li><button type="button" class="close" aria-hidden="true" onclick="javascript:$(this).parent().remove();">&times;</button>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" name="options" disabled >
                                  </span> 
                                    <input tyle="text" name="option_con_1" class="form-control" placeholder="옵션"> 
                            </div>
                        </li>
                        <li><button type="button" class="close" aria-hidden="true" onclick="javascript:$(this).parent().remove();">&times;</button>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" name="options" disabled >
                                  </span> 
                                    <input tyle="text" name="option_con_2" class="form-control" placeholder="옵션"> 
                            </div>
                        </li>
                        {/}
                    </ul> 
                    <button class="btn btn-default btn-sm" onclick="add_query(this); return false;">옵션 추가하기</button>
                </div>
            </div>
            
            <div class="form-group"> 
                <div class="col-xs-12 col-sm-10 col-sm-offset-2 col-md-10 col-md-offset-2">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="required" value="1" {? ress.required}checked="checked"{/}>
                            필수입력</label>
                    </div>
                </div>
            </div>
            
            <div class="action-wrap">
                <div class="col-sm-offset-2 col-md-offset-2">  
                    <button  class="btn btn-info btn-sm" onclick="add_pro_form(this, {? ress}1{:}0{/}, '{ress.program_id}'); return false;">저장</button> 
                </div>
            </div>
            <input type="hidden" name="program_id" value="{ress.program_id}" />
            <input type="hidden" name="id" value="{ress.id}" />
        </fieldset>
    </form>
</div>