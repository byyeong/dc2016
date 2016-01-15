                                            <li class="media" id="com{res.bid}">
                                                <button onclick="del_comm('{res.bid}', '{res.parent}'); return false;" aria-hidden="true" class="close" type="button">×</button>
                                                <a href="/member/{res.ids}" class="media-left">
                                                    <img src="{res.picture}" alt="{res.name}" class="avatar img-circle">
                                                </a>
                                                <div class="media-body">
                                                    <h4 class="media-heading">
                                                        <a href="/member/{res.ids}">{res.name}</a> <small>{=substr(res.date_created, 0, -3)}</small>
                                                    </h4>
                                                    <p>{res.contents}</p>
                                                </div>
                                            </li>