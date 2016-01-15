                    <!-- vcardSlides -->
                    <div id="vcardSlides">
                        <div class="slides-container">
                            <!-- slide-wrap -->
                            {@ users}
                            {? .key_ % 8 == 0}<div class="slide-wrap">
                                <div class="row">{/}
                                    {? .msg}
                                    <div class="item vcard vcard2 col-lg-3" id="vcard_{.id}">
                                        <div class="inner">
                                            <div class="vcard-heading">
                                                <div class="vimg">
                                                    <div style="background-image:url({.picture});">
                                                        <img src="/images/img_trans.png">
                                                    </div>
                                                </div>
                                                <h2 class="ellipsis">{.name}</h2>
                                                <strong class="tag ellipsis">{.com.name}</strong>
                                                <small class="tag ellipsis">{.com.role}</small>
                                            </div>
                                            <div class="vcard-body">
                                                <p class="quintuple">{.msg}</p>
                                            </div>
                                        </div>
                                    </div>
                                    {:}
                                    <div class="item vcard col-lg-3" id="vcard_{.id}">
                                        <div class="inner">
                                            <div class="vcard-heading">
                                                <div class="vimg">
                                                    <div style="background-image:url({.picture});">
                                                        <img src="/images/img_trans.png">
                                                    </div>
                                                </div>
                                                <h2 class="ellipsis">{.name}</h2>
                                                <strong class="tag ellipsis">{.com.name}</strong>
                                                <small class="tag ellipsis">{.com.role}</small>
                                            </div>
                                        </div>
                                    </div>
                                    {/}
                                    <!-- /vcard -->
                                {? (.key_ % 8 == 7) || (sizeof(users) == .key_ +1)}</div>
                            </div>{/}
                            {/}
                            <!-- /slide-wrap -->
                        </div>
                        <!-- /slide-container --> 
                    </div>
                    <!-- /vcardSlides -->