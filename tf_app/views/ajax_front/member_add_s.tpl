                            {? !st}
                                    <p class="form-group-tag input_sk" id="add_skill_{v}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_{v}" placeholder="업무 관련 기술을 하나씩 입력해주세요." onkeydown="return ignoreEnter(event);">
                                    </p>
                            {:}
                                {? st == 'mk'}
                                    <p class="form-group-tag" id="add_market_{v}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_market" name="market_{v}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                {:}
                                    {? st == 'st'}
                                    <p class="form-group-tag" id="add_skill_{v}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_{v}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                    {:}
                                        {? st == 'fl'}
                                    <p class="form-group-tag" id="add_field_{v}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="field_{v}" placeholder="" onkeydown="return ignoreEnter(event);">
                                    </p>
                                        {:}
                                    <p class="form-group-tag" id="add_skill_{v}">
                                        <button type="button" class="close" aria-hidden="true" onclick="del_box(this); return false;">&times;</button>
                                        <input type="text" class="form-control suggest_job" name="skill_{v}" placeholder="핵심기술을 입력해주세요." onkeydown="return ignoreEnter(event);">
                                    </p>
                                        {/}
                                    {/}
                                {/}
                            {/}