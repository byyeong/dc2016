<?php

    /*
        TF CORE
        Name: model
        Author: Binseop Ko
        Description: 모델 베이스 클래스
        
        Version: 0.8.0
        Last modified: 2011-06-14
        
        Version history _____________
        Jun. 14, 2011 (0.8.0)
        Dec. 28, 2010 - 조인 관련 일부 버그 수정
        Jul. 15, 2010 (0.7.0)
        Jan. 13, 2010 (0.6)
        Apr.  7, 2009 (0.5)
        
        contact: binseop@gmail.com
    
    */

    class Model
    {
        var $last_query = null;
        var $use_master = false;
        //var $_db_master = 'DEFAULT';
        var $_db_read   = null;
        
        var $db;
        var $db_r;
        
        public static $connection_pools = array();
        
        function Model($settings)
        {
            if (!$this->_db_master) $this->_db_master = "DEFAULT";
            $this->settings = $settings;
            if (array_key_exists($this->_db_master, self::$connection_pools))
            {
                $this->db = self::$connection_pools[$this->_db_master];
            }
            else
            {
                $this->db = mysql_connect($this->settings->db[$this->_db_master]['SERVER'],$this->settings->db[$this->_db_master]['ID'], $this->settings->db[$this->_db_master]['PW'], true);
                mysql_select_db($this->settings->db[$this->_db_master]['DB'],$this->db);
                mysql_query('SET NAMES \'utf8\'');
                self::$connection_pools[$this->_db_master] = $this->db;
            }
            
            if (!$this->_db_read || $this->_db_read == $this->_db_master)
            {
                $this->db_r = $this->db;
            }
            else
            {
                if (array_key_exists($this->_db_read, self::$connection_pools))
                {
                    $this->db_r = self::$connection_pools[$this->_db_read];
                }
                else
                {
                    $this->db_r = mysql_connect($this->settings->db[$this->_db_read]['SERVER'],$this->settings->db[$this->_db_read]['ID'], $this->settings->db[$this->_db_read]['PW'], true);
                    mysql_select_db($this->settings->db[$this->_db_read]['DB'],$this->db_r);
                    mysql_query('SET NAMES \'utf8\'');
                    self::$connection_pools[$this->_db_read] = $this->db_r;
                }
            }
            
            
                    
        }
        
        function last_id()
        {
            return mysql_insert_id();
        }
        
        function execute($valSql)
        {
            $valSql = str_replace('$$MODEL_TABLE_NAME$$', $this->tablename, $valSql);
            if ($this->debug) echo ($valSql);
            $ret = mysql_query($valSql, $this->db);

            if (!$ret)
            {
                return mysql_error();
            }
            else return 0;
            
        }

        function debug()
        {
            $this->debug = 1;
        }

        function delete($id)
        {
            if (is_object($id)) return $this->delete_cond($id);
            
            $valSql = 'delete from ' . $this->tablename . ' where id=' . $id;
            if ($this->debug) echo ($valSql);
            return $this->execute($valSql);
        }
    	
    	public function delete_cond($c)
    	{// deprecated. will be removed from 1.0.0
    	    return $this->execute($c->get_delete_query());
    	}
        
        function get($id)
        {
            $valSql = 'select * from ' . $this->tablename . ' where id=' . $id;
            if ($this->debug) echo ($valSql);
            return $this->fetch_one($valSql);
        }
        
        function find($get, $where, $keyword, $pagesize = 0, $page = 0, $order="")
        {
            $where_arr = explode(',', $where);
            $c = new Query();
            
            if ($where != '')
            {
                $where = '';
                for ($i=0;$i<sizeof($where_arr);$i++)
                {
                    if ($where == '') $where = ' ('; else $where = $where.' or ';
                    $where = $where.$where_arr[$i].' like \'%' . $keyword . '%\' ';
                }
                $where = $where.')';
            }
            
            $c->where($where);
            if ($order)
                $c->order = $order;

            $this->last_query = $c;
            if ($pagesize > 0)
                $c->limit = (($page-1) * $pagesize).', ' . $pagesize . ' ';
            
                
            return $this->fetch($get, $c);
        }
        
        function fetch_all($order='')
        {
            $valSql = 'select * from ' . $this->tablename;
            if ($order) $valSql = $valSql . ' order by ' . $order;
            
            return $this->fetch ($valSql);
            
        }
        
        function fetch($target, $cond = null)
        {
            if ($cond)
            {
    	        $this->last_query = $cond;
                $from = $cond->from;
                if (!$from) $from = $this->tablename;
                $from_org = $from;

    	        // 0.7 에서 추가
    	        if ($cond->inner_join)
    	        {
    	            $cond2 = $cond->inner_join;
                    
                    $from = $from . " inner join " . $cond2->from;
                    if ($cond2->on)
                    {
                        $from = $from . " on " . $cond2->on;
                    }
                    
                    $valSql = 'select ' . $target . ' from ' . $from . ' ' . $cond->get_where_string_join($from_org, $cond2);
    	            
    	        }
    	        else
    	        {
    	        // 여기까지
                    $valSql = 'select ' . $target . ' from ' . $from . ' ' . $cond->get_where_string();
                } // 0.7 에서 추가
            }
            else $valSql = $target;
            
            if ($this->debug || ($cond && $cond->debug)) echo ($valSql); // 0.7 에서 수정
            
            if ($this->use_master)
                $rset = mysql_query($valSql, $this->db);
            else
                $rset = mysql_query($valSql, $this->db_r);
            $r = array();
            $cnt = 0;
            while ($record = mysql_fetch_assoc($rset))
            {
                $r[$cnt++] = $record;
            }
            
            return $r;
        }
        
        function desc_table($cond = null)
        {
            if ($cond)
            {
                $this->last_query = $cond;
                $table_name = $this->tablename;
                $valSql = 'desc ' . $table_name;
            }
            else $valSql = '-- Ventus : Not Mysql Connect --';
            
            if ($this->debug) echo ($valSql);
            
            if ($this->use_master)
                $rset = mysql_query($valSql, $this->db);
            else
                $rset = mysql_query($valSql, $this->db_r);
            $r = array();
            $cnt = 0;
            
            while ($record = mysql_fetch_assoc($rset))
            {
                $r[$cnt++] = $record;
            }
                        
            return $r;
        }
        
        function counts($cond = null)
        {
            if (!$cond)
            {
                $cond = $this->last_query;
            }
            $cond->limit = '';

            $from = $cond->from;
            if (!$from) $from = $this->tablename;

	        if ($cond->inner_join)
	        {
	            $cond2 = $cond->inner_join;
                
                $from = $from . " inner join " . $cond2->from;
                if ($cond2->on)
                {
                    $from = $from . " on " . $cond2->on;
                }
                
                $valSql = 'select count(*) cnt from ' . $from . ' ' . $cond->get_where_string($from_org) . " and " . $cond2->get_where_string($cond2->from);
	            
	        }
	        else
	        {
	        // 여기까지
                $valSql = 'select count(*) cnt from ' . $from . $cond->get_where_string_norel();
            } // 0.7 에서 추가
            
            
            if ($this->debug || ($cond && $cond->debug)) echo ($valSql);
            if ($this->use_master)
                $rset = mysql_query($valSql, $this->db);
            else
                $rset = mysql_query($valSql, $this->db_r);
            
            if ($record = mysql_fetch_assoc($rset))
            {
                return $record['cnt'];
            }
            
            return 0;
            
        }
        
        function fetch_one($target, $cond = null)
        {

            if ($cond)
            {
                $from = $cond->from;
                if (!$from) $from = $this->tablename;
                $valSql = 'select ' . $target . ' from ' . $from . $cond->get_where_string();
                $cond->limit = '1';
            }
            else
            {
                $valSql = $target;
            }
            
            if ($this->debug || ($cond && $cond->debug)) echo ($valSql);
            if ($this->use_master)
                $rset = mysql_query($valSql, $this->db);
            else
                $rset = mysql_query($valSql, $this->db_r);
            $cnt = 0;
            if ($record = mysql_fetch_assoc($rset))
            {
                return $record;
            }
            
            return null;
        }
        

    	public function update($c)
    	{
    	    return $this->execute($c->get_update_query());
    	}
    	
    	public function insert($c)
    	{
    	    return $this->execute($c->get_insert_query());
    	}
    	
    	
    	public function begin()
    	{
    	    $this->execute('begin');
    	}
    	
    	public function commit()
    	{
    	    $this->execute('commit');
    	}
    	
    	public function rollback()
    	{
    	    $this->execute('rollback');
    	}
    	
        	

    }


    
    class Query
    {
    	var $where = array();
    	var $where_rel = array();
    	var $order = '';
    	var $group = '';
    	var $limit = '';
    	var $values = array();
    	var $page_size = 0;
    	var $page = 0;

    	
    	// 0.7 에서 추가

    	var $debug = false;
    	var $inner_join = null;
    	var $on = null;

    	function debug()
    	{
    	    $this->debug = true;
    	}
    	
    	function inner_join ($q)
    	{
    	    $this->inner_join = $q;
    	}
    	
    	function on($cond)
    	{
    	    $this->on = $cond;
    	}
    	
    	// 여기까지
    	
    	function where($cond, $field = null, $value = null)
    	{
    	    if ($field)
    	    {
        	    $value = str_replace('\'', '\\\'', $value);
        	    $cond = $field . " " . $cond . " '" . $value . "'";
    	    }
    	    
    		$this->where[] = $cond;
    	}
    	
    	function where_eq($field, $value)
    	{
    	    $this->where("=", $field, $value);
    	}
    	
    	function where_rel($cond)
    	{
    		$this->where_rel[] = $cond;
    	}
    	
    	
    	function value($key, $value, $no_quote = 0)
    	{
    	    if ($no_quote == 0)
    	    {
    	        if (is_array($value))
    	        {
    	            for($i=0;$i<sizeof($value);$i++)
    	                $value[$i] = str_replace('\'', '\\\'', $value[$i]);
    	        }
    	        else
    	            $value = str_replace('\'', '\\\'', $value);
    	    }
    	        
    	    $this->values[] = array('key'=>$key, 'value'=>$value, 'no_quote'=>$no_quote);
    	}
    	
    	function values($keys)
    	{
    	    $keys_arr = explode(',', $keys);
    	    foreach ($keys_arr as $_key)
    	    {
    	        $_key = trim($_key);
  	            $this->value($_key, $_REQUEST[$_key]);
    	        
    	    }
    	}
    	
    	function get_where_string($scheme = "") // 0.7 에서 수정 (scheme)
    	{
    	    
    		if ($scheme) $scheme = $scheme . '.'; // 0.7 에서 추가

		    $res_o = implode(' and ' . $scheme, $this->where);
		    $res_rel = implode(' and ' . $scheme, $this->where_rel);
            
    	    // 0.7 에서 추가
            if (!$res_o) $res_o =  $scheme . $res_o;
            if (!$res_rel) $res_rel =  $scheme . $res_rel;
            // 끝

            $res = ' where 1 ';

            if ($res_o) $res = $res . ' and ' . $res_o . ' ';
            if ($res_rel) $res = $res . ' and ' . $res_rel . ' ';

            if ($this->group != '') $res = $res . ' group by ' . $this->group;
            if ($this->order != '') $res = $res . ' order by ' . $this->order;
    		if ($this->limit != '')
    		{
    		    $res = $res . ' limit ' . $this->limit;
    		}elseif ($this->page_size > 0)
    		{
    		    $res = $res . ' limit '.(($this->page-1) * $this->page_size) . ', ' . $this->page_size . ' ';
    		}
    		
    		
    		return $res;
    	}
    	
    	function get_where_string_join($scheme = "", $c2) // 0.7 에서 추가
    	{

    		if ($scheme) $scheme = $scheme . '.'; // 0.7 에서 추가

		    $res_o = implode(' and ' . $scheme, '.' . $this->where);
		    $res_rel = implode(' and ' . $c2->from, '.' . $c2->where);
            
    	    // 0.7 에서 추가
            if ($res_o) $res_o =  $scheme . $res_o;
            if ($res_rel) $res_rel =  $c2->from . $res_rel;
            // 끝

            $res = ' where 1 ';

            if ($res_o) $res = $res . ' and ' . $res_o . ' ';
            if ($res_rel) $res = $res . ' and ' . $res_rel . ' ';

            if ($this->group != '') $res = $res . ' group by ' . $this->group;
            if ($this->order != '') $res = $res . ' order by ' . $this->order;
    		if ($this->limit != '')
    		{
    		    $res = $res . ' limit ' . $this->limit;
    		}elseif ($this->page_size > 0)
    		{
    		    $res = $res . ' limit '.(($this->page-1) * $this->page_size) . ', ' . $this->page_size . ' ';
    		}
    		
    		
    		return $res;
    		    	    
    	}
    	
    	function get_order_string($scheme = "") // 0.7 에서 추가
    	{

            $res = "";
            if ($this->group != '') $res = $res . ' group by ' . $this->group;
            if ($this->order != '') $res = $res . ' order by ' . $this->order;
    		if ($this->limit != '')
    		return $res;
    		    	    
    	}
    	

    	function get_where_string_norel($scheme = "") // 0.7 에서 수정 (scheme)
    	{
    	    
    		if ($scheme) $scheme = $scheme . '.'; // 0.7 에서 추가

    		$res = implode(' and ' . $scheme, $this->where);
            
    	    // 0.7 에서 추가
            if (!$res) $res =  $scheme . $res;
            // 끝

            if ($res) $res = ' where ' . $res;
            if ($this->group != '') $res = $res.' group by '.$this->group;
            if ($this->order != '') $res = $res.' order by '.$this->order;
    		if ($this->limit != '') $res = $res.' limit '.$this->limit;
    		
    		return $res;
    	}


        
        function get_delete_query()
        {

            if ($this->from)
                $from = $this->from;
            else if (!$this->tablename)
        	    $from = '$$MODEL_TABLE_NAME$$';
        	else $from = $this->tablename;
        	    
        	return 'delete from '.$from.' '.$this->get_where_string() ;
        }
    	
        function get_update_query()
        {
        	$res = '';
        	foreach ($this->values as $value)
        	{
        	    if ($res != '') $res = $res.', ';
        	    if ($value['no_quote'])
            	    $res = $res.$value['key'].' = '.$value['value'];
        	    else
            	    $res = $res.$value['key'].' = \''.$value['value'].'\'';
        	}
        	
            if ($this->from)
                $from = $this->from;
            else if (!$this->tablename)
        	    $from = '$$MODEL_TABLE_NAME$$';
        	else $from = $this->tablename;
        	    
        	return 'update '.$from.' set ' . $res . ' '.$this->get_where_string() ;
        }
    	
    	
        function get_insert_query()
        {
            if ($this->from)
                $from = $this->from;
            else if (!$this->tablename)
        	    $from = '$$MODEL_TABLE_NAME$$';
        	else $from = $this->tablename;
        	
        	
        	if (is_array($this->values[0]['value']))
        	{
        	    $res1 = '';
        	    $res2 = array();
        	    $size = sizeof($this->values[0]['value']);

            	foreach ($this->values as $value)
            	{
            	    if ($res != '')
            	    {
            	        $res = $res.', ';
            	        for ($i=0;$i<$size;$i++)
            	            $res2[$i] = $res2.', ';
            	    }
            	    
            	    $res = $res.$value['key'];
            	    if ($value['no_quote'])
            	    {
            	        for ($i=0;$i<$size;$i++)
            	            $res2[$i] = $res2[$i].$value['value'][$i];
            	    }
            	    else
            	    {
            	        for ($i=0;$i<$size;$i++)
                	        $res2[$i] = $res2[$i].'\''.$value['value'][$i].'\'';
            	    }
            	}
            	
            	$ret = 'insert into '.$from . '(' . $res . ') values ';
            	$ret = $ret . '(' . implode('), (', $res2) . ')';

            	return $ret;
        	    
        	    
        	}
        	else
        	{
            	$res1 = '';
            	$res2 = '';
            	foreach ($this->values as $value)
            	{
            	    if ($res != '')
            	    {
            	        $res = $res.', ';
            	        $res2 = $res2.', ';
            	    }
            	    
            	    $res = $res.$value['key'];
            	    if ($value['no_quote'])
            	        $res2 = $res2.$value['value'];
            	    else
            	        $res2 = $res2.'\''.$value['value'].'\'';
            	}
            	
            	return 'insert into '.$from.' (' . $res . ') values (' . $res2 . ')';
            }
        }
    	
    }
    		    
?>
