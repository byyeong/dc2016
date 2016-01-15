<?php

/*

    TF External Apps
    Name: tf_timer8
    Author: Binseop Ko
    Description: 수행 시간 계산 / V 0.8 용
    
    Version: 2010-06-20
    VersionMin: 0.8.0
    VersionMax: -
    

*/
    
    
    // 타이머 시작시점을 기록합니다.
    $trail->_settings->tf_timer_start = explode(" ", microtime());
    
    // 렌더링 후 작업을 등록합니다.
    $trail->add_event_list("after_render", "timer", tf_timer_end);
    
    
    function tf_timer_end($trail)
    {// 렌더링 후 작업
        // 현재 시점을 얻고 시작 시점과 비교하여 계산합니다.
        $tf_timer_stop = explode(" ", microtime());
        $rset = (double) $tf_timer_stop[0] - (double) $trail->_settings->tf_timer_start[0];
        $rset = (double) $tf_timer_stop[1] - (double) $trail->_settings->tf_timer_start[1] + $rset;
        
        // 출력합니다.
        print ("<!-- loaded in $rset -->");
        
    }
    
?>