{? res.type == "text"}
<li class="ui-state-default entry-item form-group" data-form-id="{ res.id }">
    <input type="hidden" value="text" class="type" />
    <!--i class="icon-move pull-left"></i-->
    <div class="set-wrap pull-right">
        <button class="btn btn-default btn-xs edit" type="button" ><i class="icon-move"></i></button>
        <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{res.id}'); return false;"><span class="icon-edit"></span></button> 
        <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{res.id}'); return false;"><span class="icon-trash"></span></button> 
    </div>
    <div class="form-group">
        <label class="control-label"><span class="t-title">{=add_brs(res.title)}</span> {?res.required}<span class="text-danger">*</span>{/}</label>
        {?res.sub}<p class="help-block">{=add_brs(res.sub)}</p>{/}
        <input type="text" class="form-control" disabled>
    </div>
</li>
{/}

{? res.type == "textarea"}
<li class="ui-state-default entry-item form-group" data-form-id="{ res.id }">
    <input type="hidden" value="textarea" class="type" />
    <!--i class="icon-move pull-left"></i-->
    <div class="set-wrap pull-right">
        <button class="btn btn-default btn-xs edit" type="button" ><i class="icon-move"></i></button>
        <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{res.id}'); return false;"><span class="icon-edit"></span></button> 
        <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{res.id}'); return false;"><span class="icon-trash"></span></button> 
    </div>
    <div class="form-group">
        <label class="control-label"><span class="t-title">{=add_brs(res.title)}</span> {?res.required}<span class="text-danger">*</span>{/}</label>
        {?res.sub}<p class="help-block">{=add_brs(res.sub)}</p>{/}
        <textarea rows="5" class="form-control" disabled></textarea>
    </div>
</li>
{/}

{? res.type == "query"}
<li class="ui-state-default entry-item form-group" data-form-id="{ res.id }">
    <input type="hidden" value="query" class="type" />
    <input type="hidden" value="{@ res.opts}{.value_},{/}" class="opt" />
    <!--i class="icon-move pull-left"></i-->
    <div class="set-wrap pull-right">
        <button class="btn btn-default btn-xs edit" type="button" ><i class="icon-move"></i></button>
        <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_field_e(this, '{res.id}'); return false;"><span class="icon-edit"></span></button> 
        <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_sort(this, '{res.id}'); return false;"><span class="icon-trash"></span></button> 
    </div>
    <div class="form-group">
        <label class="control-label"><span class="t-title">{=add_brs(res.title)}</span> {?res.required}<span class="text-danger">*</span>{/}</label>
        {?res.sub}<p class="help-block">{=add_brs(res.sub)}</p>{/}
        <ul class="list-unstyled">
            {@ res.opts}
            <li class="radio">
                <label>
                    <input type="radio" name="opt{=date('is')}" disabled>{.value_}
                </label>
            </li>
            {/}
        </ul>                                       
    </div>
</li>
{/}

{? res.type == "file"}
<div class="ui-state-default entry-item m_file form-group"> 
    <input type="hidden" value="file" class="type" />
    <input type="hidden" name="id" value="{res.id}" class="type" />
    <div class="set-wrap pull-right">                                                            
        <button class="btn btn-default btn-xs edit" type="button" onclick="get_form_file_e(this, '{res.id}'); return false;"><span class="icon-edit"></span></button> 
        <button class="btn btn-default btn-xs delete" type="button" onclick="delete_form_file(this, '{res.id}'); return false;"><span class="icon-trash"></span></button> 
    </div>
    <div class="form-group">
        <label class="control-label"><span class="t-title">{=add_brs(res.title)}</span> {?res.req}<span class="text-danger">*</span>{/}</label>
        <p class="help-block">{?res.sub}{=add_brs(res.sub)}{/}</p>
        <div class="file"><input type="file" name="file"></div>
    </div>
</div>
{/}
