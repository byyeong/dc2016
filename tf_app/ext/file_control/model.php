<?

    class EXT_Tf_image_sync_model extends Model
    {
        
        var $tablename = "tf_image_sync";
        
        function add($_url)
        {
            $c = new Query();
            $c->value("url", $_url);
            $c->value("date_created", "now()", true);
            $this->insert($c);
        }
        
        function add_error($_id)
        {
            $c = new Query();
            $c->where_eq('id', $_id);
            $c->value('error_cnt', 'error_cnt+1', true);
            $this->update($c);
        }
    }
    
    $log_tis = new EXT_Tf_image_sync_model($trail->_settings);
    load_ext_model("Tf_image_sync", $log_tis);
  
    
?>
