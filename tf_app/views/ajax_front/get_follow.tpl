    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">{? type == 1}Follower{:}Following{/} <span class="badge">{=sizeof(res)} </span></h4>
            </div>
            <div class="modal-body">
            <!-- Start modal content -->
               
                <ul class="list-inline list-users">
                    {? res}
                    {@ res}
                    <li><a href="/member/{.ids}"><img class="img-circle" title="{.name}" data-toggle="tooltip" data-src="holder.js/40x40" src="{? .picture}{.picture}{:}/img/default-img-member.png{/}"></a></li>
                    {/}
                    {:}
                    <li>-<li>
                    {/}
                </ul>

            <!-- Start modal content -->
            </div> 
        </div>
    </div>