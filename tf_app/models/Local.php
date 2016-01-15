<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Local_model extends Model
{
    
    var $tablename = "local";

    function list_()
    {
        $c = new Query();
        $c->order="id ASC";
        return $this->fetch("*", $c);        
    }

}

$current_controller->Local = new Local_model($settings);
?>