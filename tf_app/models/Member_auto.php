<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Member_auto_model extends Model
{
    
    var $tablename = "member_auto";
    
    function add($id_user,$login_name){
        $akey = sha256(make_code().$login_name);
        $c = new Query();
        $c->value('user_id',$id_user);
        $c->value('akey',$akey);
        $this->insert($c);
        return $akey;
    }
    
    
    function get_by_id_user_akey($id_user,$akey){
        $c = new Query();
        $c->where_eq('user_id',$id_user);
        $c->where_eq("akey", $akey );
        return $this->fetch_one('*',$c);            
    }
    
    function delete_by_id_user($id_user){
        $c = new Query();
        $c->where_eq('user_id',$id_user);
        return $this->delete($c);            
    }
}

$current_controller->Member_auto = new Member_auto_model($settings);
?>
