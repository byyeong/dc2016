{? c == 'startup'}
                    {@ res}
                    <div class="vcard card col-xs-12 col-sm-4 col-md-3"> 
                        <div class="inner"> 
                            <a href="/startup/{.id}">
                            <div class="vcardimg">
                                <div class="logo" style="background-image:url({.logo});">
                                    <img src="/img/trans.png">
                                </div>
                                <div class="bgimg" data-href="{.logo}" data-sharpness="80"></div>
                            </div>
                            <div class="caption"> 
                                <h3 class="ellipsis">{.name}</h3> 
                                <p class="mulitple">{=htmlspecialchars(.bio)}</p>
                            </div> 
                            </a>
                        </div>
                    </div>
                    <!-- /item -->
                    {/}
{/}

{? c == 'people'}
                                {@ res}
                                <div class="vcard card col-xs-12 col-sm-4 col-md-4"> 
                                    <div class="inner"> 
                                        <a href="/member/{.ids}">
                                        <div class="vcardimg">
                                            <div class="logo" style="background-image:url({.picture});">
                                                <img src="/img/trans.png">
                                            </div>
                                            <div class="bgimg" data-href="{.picture}" data-sharpness="80"></div>
                                        </div>
                                        <div class="caption"> 
                                            <h3 class="ellipsis">{.name}</h3> 
                                            <p class="mulitple">{=htmlspecialchars(.bio)}</p>
                                        </div> 
                                        </a>
                                    </div>
                                </div>
                                <!-- /item -->
                                {/}
{/}

{? c == 'suporter'}
                            {@ res}
                            <div class="vcard card col-xs-12 col-sm-4 col-md-4"> 
                                <div class="inner"> 
                                    <a href="/startup/{.id}">
                                    <div class="vcardimg">
                                        <div class="logo" style="background-image:url({.logo});">
                                            <img src="/img/trans.png">
                                        </div>
                                        <div class="bgimg" data-href="{.logo}" data-sharpness="80"></div>
                                    </div>
                                    <div class="caption"> 
                                        <h3 class="ellipsis">{.name}</h3> 
                                        <p class="mulitple">{=htmlspecialchars(.bio)}</p>
                                    </div> 
                                    </a>
                                </div>
                            </div>
                            <!-- /item -->
                            {/}
{/}