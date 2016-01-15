
                                <form role="form" method="post" name="p_form" onsubmit="submit_p_form('{id}'); return false">
                                    {? id > 0}
                                    {? is_end}
                                    <legend><span class="fui-new"></span>&nbsp; 행사 어떠셨나요? 만족도와 후기를 남겨주세요. </legend>
                                    {:}
                                    <legend><span class="fui-new"></span>&nbsp; 행사에 대한 질문이나 의견을 남겨주세요. </legend>
                                    {/}
                                    {:}
                                    <legend><span class="fui-new"></span>&nbsp; D.CAMP 라운지에 글을 남겨주세요. </legend>
                                    {/}
                                    
                                    <div class="form-group">                                    
                                        <textarea rows="3" class="form-control" name="cont"></textarea>
                                    </div>
                                    <div class="pull-right"> 
                                        <label class="checkbox-inline" >
                                          <input type="checkbox" data-toggle="checkbox" name="fb" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
                                          Facebook
                                        </label>
                                        <label class="checkbox-inline">
                                          <input type="checkbox" data-toggle="checkbox" checked="checked" name="tw" value="1" {? ! fb}disabled="disabled"{:}checked="checked"{/}>
                                          Twitter
                                        </label>
                                        &nbsp;&nbsp;
                                        {? s.id}
                                        <button type="submit" class="btn btn-primary" id="submit_f">업데이트</button>
                                        {:}
                                        <div class="btn btn-primary" onclick="javascript:location.href='/login'">로그인 해주세요</div>
                                        {/}
                                        <input type="hidden" name="id" value="{id}" />
                                    </div>
                                    {? id > 0 && is_end }
                                    <script src="/js/jquery.barrating.js"></script>
                                    <script type="text/javascript">
                                        $(function () {
                                            $('#star-rating').barrating({ showSelectedRating:false });
                                            $('.rating-enable').trigger('click');
                                        });
                                    </script>
                                    <div class="input select rating-f">
                                        <select id="star-rating" name="star">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                        </select>
                                    </div>
                                    {/}
                                </form>