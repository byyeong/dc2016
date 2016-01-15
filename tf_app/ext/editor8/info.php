<?php

    // 렌더링 후 작업을 등록합니다.
    //$settings->before_render_calls[] = tf_editor_end;
    $trail->add_event_list("before_render", "editor", tf_editor_end);

    include_once("../tf_app/ext/editor8/controller.php");
    $trail->add_ext_route("tf_editor/editor_add_image", "*component*/Editor8/editor_add_image");
    $trail->add_ext_route("tf_editor/editor_add_image_process", "*component*/Editor8/editor_add_image_process");
    $trail->add_ext_route("tf_editor/editor_add_link", "*component*/Editor8/editor_add_link");
    $trail->add_ext_route("tf_editor/editor_add_movie", "*component*/Editor8/editor_add_movie");
    $trail->add_ext_route("tf_editor/editor_add_movie_process", "*component*/Editor8/editor_add_movie_process");
    
    function tf_editor_end($trail)
    {// 렌더링 후 작업
        $trail->_current_controller->include_tpl("editor", "ext/editor8/views/editor.tpl");
        
    }
    
    
 
    
?>