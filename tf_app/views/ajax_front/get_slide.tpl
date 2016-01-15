                                    {? slide}
                                    <ol class="carousel-indicators">
                                        {@ slide}<li data-target="#carousel-introduce" data-slide-to="{.key_}" class="{? .key_ == 0}active{/}"></li>{/}
                                    </ol>
                                    <!-- /indicator -->
                                
                                    <div class="carousel-inner">
                                        {@ slide}
                                        <div class="item{? .key_ == 0} active{/}">{.value_}</div>
                                        <!-- /item -->
                                        {/}
                                    </div>
                                    <!-- /inner --> 
                                    {? sizeof(slide) > 1}
                                    <a class="left carousel-control" href="#carousel-introduce" data-slide="prev"> <span class="icon-chevron-left"></span> </a> 
                                    <a class="right carousel-control" href="#carousel-introduce" data-slide="next"> <span class="icon-chevron-right"></span> </a> 
                                    <!-- / control --> 
                                    {/}
                                    {/}