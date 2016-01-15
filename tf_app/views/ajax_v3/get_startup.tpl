
                                            <input type="hidden" name="profile_url" value="http://dcamp.kr/startup/{id}">
                                            <input type="hidden" name="st_id" value="{id}">
                                            <input type="hidden" name="ser_id" value=""> 

                              
                                            <label class="control-label">
                                                제품/서비스명
                                            </label><span class="text-danger"> *</span>
                                            {? res}
                                            <select class="form-control" name="f_service" onchange="get_service_ch(); return false;">
                                                {@ res}
                                                <option value="{.name}" rel="{.id}" {? .name == ser.name}selected="selected"{/}>{.name} </option>
                                                {/}
                                            </select>
                                            {:}
                                            <input type="text" class="form-control" name="f_service">
                                            {/}