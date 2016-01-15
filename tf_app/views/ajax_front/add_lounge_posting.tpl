                                <li class="media">
                                    <a class="media-left" href="/member/{res.ids}">
                                        <img src="{res.picture}" alt="{res.name}" class="img-responsive avatar">
                                    </a>
                                    <div class="media-body">
                                        <h4 class="media-heading">
                                            <a href="/member/{res.ids}">{res.name}</a> <small><a href="/member/{res.ids}">{=substr(res.date_created, 0, -3)}</a></small>
                                        </h4>
                                        <p>{res.contents}</p>

                                        <div class="text-right">
                                            <button type="button" class="btn btn-default active">
                                                <span class="fui-heart"></span> 좋아요 12
                                            </button>
                                            <button type="button" class="btn btn-default" data-toggle="collapse" data-target="#re-media" aria-expanded="true" aria-controls="re-media">
                                                <span class="fui-chat"></span> 댓글  12 <span class="caret"></span>
                                            </button> 
                                        </div>
                                        
                                        <ul id="re-media" class="media-list collapse">
                                            <li class="media">
                                                <a href="#" class="media-left">
                                                    <img src="images/img-default.png" alt="사용자 이름" class="img-responsive avatar">
                                                </a>
                                                <div class="media-body">
                                                    <h4 class="media-heading">Nested media heading <small><a href="#">2014.12.30 15:40</a></small></h4>
                                                    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.</p>
                                                </div>
                                            </li>

                                            <li class="media">
                                                <a href="#" class="media-left">
                                                    <img src="images/img-default.png" alt="사용자 이름" class="img-responsive avatar">
                                                </a>
                                                <div class="media-body">
                                                    <h4 class="media-heading">Nested media heading <small><a href="#">2014.12.30 15:40</a></small></h4>
                                                    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin commodo. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.</p>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </li>