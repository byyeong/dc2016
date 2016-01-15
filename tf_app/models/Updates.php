<?php

class Updates_model extends Model
{
    var $tablename = "updates";

    function get($_id, $_pro=true)
    {
        $c = new Query();
        $c->where_eq('id', $_id );

        $sql = 'id,id_user,type,file_photo,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $ret = $this->fetch_one($sql, $c);

        if($ret && $_pro){
            $ret['cv_date_created'] = date_to_ten($ret['date_created'],'-');
            $ret['cv_contents'] = trans_atsign_id( trans_url( $ret['contents'] ) );
            $ret['cv_type'] = get_update_type($ret['type'], false);

            if( $ret['file_photo'] ){
                $ret['file_photo_640'] = get_photo_thumb('640_640',$ret['file_photo']);
                $ret['file_photo_150'] = get_photo_thumb('150_150',$ret['file_photo']);
                $ret['file_photo_400'] = get_photo_thumb('400_800',$ret['file_photo']);
                $ret['file_photo_72'] = get_photo_thumb('72_72',$ret['file_photo']);

                if (!$ret['photo_width'] || $ret['photo_width'] == null || $ret['photo_width'] == 0) {

                    $img_temp = getimagesize_util(substr($ret['file_photo'], 1));
                    $ret['photo_width'] = $img_temp[0];
                    $ret['photo_height'] = $img_temp[1];

//                    $edit_up['id'] = $ret['id'];
//                    $edit_up['photo_width'] = $img_temp[0];
//                    $edit_up['photo_height'] = $img_temp[1];
//                    $this->edit($edit_up);
                }
            }

            if( $ret['key_movie'] ){
                $ret['play_url'] = get_video_url($ret['key_movie'], $ret['type_movie']);
                $ret['video_embed'] = get_video_embed_from($ret['key_movie'], $ret['type_movie']);
            }
        }
        $ret['hash_contents'] = trans_atsign_hash( trans_url( $ret['contents'] ) );

        return $ret;

    }

    //function get_by_pet_profile_page($_id_user, $_id_pet, $_type, $_page='1', $_page_size='10', $_src_keyword='', $_order = 'date_created desc', $_src_type='all'){
    function get_by_pet_profile_page($_id_user, $_id_pet, $_type, $_page='1', $_page_size='10', $_order = 'date_created desc'){

        $c = new Query();

        $c->where_eq("a.id_user" , $_id_user);
        if ($_type == 4)
            $c->where("a.type > " , $_type);
        else
        {
            $_type = $_type % 4;
            if ($_type == 2) $c->where("file_photo != ''");
            if ($_type == 3) $c->where("key_movie != ''");
            $c->where("a.type % 4 = " . $_type);
        }

        $c->where_eq("b.id_pet" , $_id_pet);
        $c->where("a.id=b.id_update");

        if ($_order) {
            $c->order = 'a.'.$_order;
        }

        $sql = 'a.id, a.id_user, a.type, a.file_photo, a.key_movie, a.type_movie, a.contents, a.cnt_comments, a.cnt_likes, a.date_created, a.thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(a.e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $sql = $sql.',b.*';

        $c->limit = (($_page - 1) * $_page_size) . ',' . $_page_size;

        $c->from = 'updates a, updates_pets b';

        return $this->fetch($sql, $c);
    }

    function get_by_next_item($_id_user, $_id_pet, $_type, $_last_id, $_order = 'date_created desc'){
        $c = new Query();

        $c->where_eq("a.id_user" , $_id_user);
        if ($_type == 4)
            $c->where("a.type > " , $_type);
        else
        {
            $_type = $_type % 4;
            $c->where("a.type % 4 = " . $_type);
        }
        $c->where_eq("b.id_pet" , $_id_pet);

        $c->where("<","a.id" , $_last_id);


        $c->where("a.id=b.id_update");

        if ($_order) {
            $c->order = 'a.'.$_order;
        }

        $sql = 'a.id, a.id_user, a.type, a.file_photo, a.key_movie, a.type_movie, a.contents, a.cnt_comments, a.cnt_likes, a.date_created, a.thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(a.e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $sql = $sql.',b.*';

        $c->from = 'updates a, updates_pets b';

        return $this->fetch_one($sql, $c);
    }

    function get_by_prev_item($_id_user, $_id_pet, $_type, $_last_id, $_order = 'date_created asc'){
        $c = new Query();

        $c->where_eq("a.id_user" , $_id_user);
        if ($_type == 4)
            $c->where("a.type > " , $_type);
        else
        {
            $_type = $_type % 4;
            $c->where("a.type % 4 = " . $_type);
        }
        $c->where_eq("b.id_pet" , $_id_pet);

        $c->where(">","a.id" , $_last_id);


        $c->where("a.id=b.id_update");

        if ($_order) {
            $c->order = 'a.'.$_order;
        }

        $sql = 'a.id, a.id_user, a.type, a.file_photo, a.key_movie, a.type_movie, a.contents, a.cnt_comments, a.cnt_likes, a.date_created, a.thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(a.e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $sql = $sql.',b.*';

        $c->from = 'updates a, updates_pets b';

        return $this->fetch_one($sql, $c);
    }

    function get_by_pet_profile($_id_user, $_id_pet, $_type, $_count=10, $_last_id=0){
        $c = new Query();

        $c->where_eq("a.id_user" , $_id_user);
        if ($_type == 4)
            $c->where("a.type > 3");
        else
        {
            $_type = $_type % 4;
            $c->where("a.type % 4 = " . $_type);
        }
        $c->where_eq("b.id_pet" , $_id_pet);
        $c->where("a.id=b.id_update");

        if ($_last_id) $c -> where('a.id < ' . $_last_id) ;

        $c->limit = $_count;
        $c->order = 'a.date_created desc';

        $c->from = 'updates a, updates_pets b';

        $sql = 'a.id, a.id_user, a.type, a.file_photo, a.key_movie, a.type_movie, a.contents, a.cnt_comments, a.cnt_likes, a.date_created, a.thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(a.e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $sql = $sql.',b.*';

        return $this->fetch($sql, $c);
    }

    function get_by_pet_profile_count($_id_user, $_id_pet, $_type){
        $c = new Query();

        $c->where_eq("a.id_user" , $_id_user);
        if ($_type == 4)
            $c->where("a.type > 3");
        else
        {
            $_type = $_type % 4;
            $c->where("a.type % 4 = " . $_type);
        }
        $c->where_eq("b.id_pet" , $_id_pet);
        $c->where("a.id=b.id_update");

        $c->from = 'updates a, updates_pets b';

        $sql = 'a.id, a.id_user, a.type, a.file_photo, a.key_movie, a.type_movie, a.contents, a.cnt_comments, a.cnt_likes, a.date_created, a.thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(a.e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $sql = $sql.',b.*';

//        return $this->fetch($sql, $c);
        return $this->counts($c);
    }

    function get_by_pet_profile_inapp($_id_user, $_id_pet, $_type, $_count=10, $_last_id=0){
        $c = new Query();

        $c->where_eq("a.id_user" , $_id_user);
        if ($_type == 4)
            $c->where("a.type > 3");
        else
        {
            $_type = $_type % 4;
            $c->where("a.type % 4 = " . $_type);
        }
        $c->where_eq("b.id_pet" , $_id_pet);
        $c->where("a.id=b.id_update");

        if ($_last_id) $c -> where('a.id < ' . $_last_id) ;

        $c->limit = $_count;
        $c->order = 'a.date_created desc';

        $c->from = 'updates a, updates_pets b';

        $sql = 'a.id, a.id_user, a.type, a.file_photo, a.key_movie, a.type_movie, a.contents, a.cnt_comments, a.cnt_likes, a.date_created, a.thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(a.e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        $sql = $sql.',b.*';

        $ret = $this->fetch($sql, $c);

        return $this->get_data($ret);
    }

    function get_list_by_location( $_id_location, $_get_count = 20, $_id_user=false ,$_more=false, $_date_created='', $_last_id='', $_order="date_created desc" ){

        $c = new Query();
        $c->where('e_id_location = HEX(AES_ENCRYPT(\''.$_id_location.'\',\''.$this->settings->AES_KEY.'\'))' );

        $c->order = $_order;

        if ($_get_count)
        {
            $c->limit = $_get_count;
        }

        if($_more){
            $where = '((date_created < \'' . $_date_created . '\') OR ';
            $where = $where.'(date_created = \''. $_date_created . '\' AND id < ' . $_last_id . '))';

            $c->where($where);
        }

        $sql = 'id,id_user,type,file_photo,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        if ($_id_user) {
            $sql = $sql . ', IF(updates.id_user=' . $_id_user . ', TRUE, FALSE) AS self';
        }

        $ret =  $this->fetch($sql, $c);

        return $this->get_data($ret);

    }

    function get_cnt_by_location( $_id_location){
        $c = new Query();
        $c->where('e_id_location = HEX(AES_ENCRYPT(\''.$_id_location.'\',\''.$this->settings->AES_KEY.'\'))' );
        return $this->counts($c);
    }

    function get_list_by_now( $_get_count = 20, $_id_user=false ,$_more=false, $_date_created='', $_last_id='', $_order="date_created desc" ){
//        $this->debug();
        $c = new Query();
        $c->order = $_order;

        if ($_get_count)
        {
            $c->limit = $_get_count;
        }

        if($_more){
            // byyeong 수정
            if (!$_date_created) {
                $where = $where.'id < ' . $_last_id . '';
            }else {
                $where = '((date_created < \'' . $_date_created . '\') OR ';
                $where = $where.'(date_created = \''. $_date_created . '\' AND id < ' . $_last_id . '))';
            }


            $c->where($where);
        }

        $sql = 'id,id_user,type,file_photo,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $sql = $sql.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';

        if ($_id_user) {
            $sql = $sql . ', IF(updates.id_user=' . $_id_user . ', TRUE, FALSE) AS self';
        }

        $ret =  $this->fetch($sql, $c);

        return $this->get_data($ret);

    }

    // byyeong 추가
    function adieu_month_list($_month, $_seq = '')
    {
        $c = new Query();
        $c->from="adieu a, updates u";
        $c->where("u.id = a.id_update");
        $c->where_eq("month", $_month);
        if ($_seq) {

            $c->where_eq("seq", $_seq);
        }
        $c->order="seq ASC";
        $_ret = $this->fetch("*", $c);

        if ($_seq) {
            return $_ret[0]["id"];
        }
        else
            return $this->get_data($_ret);
    }

    /* 인덱스 관련 문제로 Feeds 로 옮김

    function cache_get_another_archive_date_list( $_id_user = '' ){

        if( $_id_user ){

            $current_y_m = date("Y").'-'.date("m");

            $ret = $this->cache->get("archive_date_" .$_id_user.'_'.$current_y_m);

            if( !$ret ){

                $c = new Query();
                $c->order = 'date_created ASC';

                $c->where_eq('id_user', $_id_user);
                $where = "SUBSTRING(date_created, 1, 7) != CAST( DATE_FORMAT( NOW(),'%Y-%m' ) AS CHAR(7) )";
                $c->where($where);

                $c->group = 'SUBSTRING(date_created, 1, 7)';

                $sql = "SUBSTRING(date_created, 1, 4) AS 'y',
    						SUBSTRING(date_created, 6, 2) AS 'm',
    						SUBSTRING(date_created, 1, 7) AS 'y_m',
    						UCASE(SUBSTRING(MONTHNAME( date_created ), 1, 3)) AS 'char_m',
    						COUNT(id) AS cnt";

                $ret =  $this->fetch($sql, $c);

                //한달짜리 캐쉬 구움
                $this->cache->set("archive_date_" .$_id_user.'_'.$current_y_m, $ret, 2592000);
            }

        }else{
            $ret = false;
        }

        return $ret;
    }

    function get_archive_date_list( $_id_user = '' ){

        if( $_id_user ){

            $current_y_m = date("Y").'-'.date("m");

            $c = new Query();
            //$c->order = 'date_created ASC';

            $c->where_eq('id_user', $_id_user);
            $where = "SUBSTRING(date_created, 1, 7) = CAST( DATE_FORMAT( NOW(),'%Y-%m' ) AS CHAR(7) )";
            $c->where($where);

            $c->group = 'SUBSTRING(date_created, 1, 7)';

            $sql = "SUBSTRING(date_created, 1, 4) AS 'y',
                        SUBSTRING(date_created, 6, 2) AS 'm',
                        SUBSTRING(date_created, 1, 7) AS 'y_m',
                        UCASE(SUBSTRING(MONTHNAME( date_created ), 1, 3)) AS 'char_m',
                        COUNT(id) AS cnt";

            $ret =  $this->fetch_one($sql, $c);

        }else{
            $ret = false;
        }

        return $ret;
    }

    function get_archive_list( $_id_user='', $_date=''){

        if( $_id_user ){

            $current_y_m = date("Y").'-'.date("m");

            if( $_date ) $current_y_m = $_date;

            $c = new Query();
            $c->order = 'date_created ASC';

            $c->where_eq('id_user', $_id_user);
            $where = "SUBSTRING(date_created, 1, 7) = '".$current_y_m."'";
            $c->where($where);

           // $ret =  $this->fetch($sql, $c);
            $ret =  $this->fetch('*', $c);

            foreach($ret as $key=>$val){
                $ret[$key]['cv_date_created'] = date_to_ten($val['date_created'],'.');
                $ret[$key]['cv_contents'] = trans_atsign_id( trans_url( $val['contents'] ) );
                $ret[$key]['cv_type'] = $val['type'] % 4;

                if( $val['file_photo'] ){
                    $ret[$key]['file_photo_150'] = get_photo_thumb('150_150',$val['file_photo']);
                    $ret[$key]['file_photo_400'] = get_photo_thumb('400_800',$val['file_photo']);
                    $ret[$key]['file_photo_72'] = get_photo_thumb('72_72',$val['file_photo']);
                }

                if( $val['key_movie'] ){
                    $ret[$key]['play_url'] = get_video_url( $val['key_movie'], $val['type_movie'] );
                    $ret[$key]['video_embed'] = get_video_embed_from( $val['key_movie'], $val['type_movie'] );
                }
            }

        }else{
            $ret = false;
        }

        return $ret;
    }
    */

    function get_data($_ret){

        if($_ret){

            $len = sizeof($_ret);

            $users = load_model('Users');
            $pets = load_model('Pets');
            $locations = load_model('Locations');
            $updates_pets = load_model('Updates_pets');

            for( $i=0; $i < $len; $i++ ){

                $cached_data = $this->cache->get("cache_update_" . $_ret[$i]["id"]);

                if( !$cached_data ){

                    $con = $_ret[$i];

                    if( $con ){

                        $con['trans_date_created'] = trans_date($con["date_created"]);
                        $con['cv_contents'] = trans_atsign_id( trans_url( $con['contents'] ) );
                        $con['cv_type'] = get_update_type($con['type'], false);

                        if( $con['file_photo'] ){
                            $con['file_photo_640'] = get_photo_thumb('640_640',$con['file_photo']);
                            $con['file_photo_150'] = get_photo_thumb('150_150',$con['file_photo']);
                            $con['file_photo_72'] = get_photo_thumb('72_72',$con['file_photo']);
                            $con['file_photo_400'] = get_photo_thumb('400_800',$con['file_photo']);

                            if (!$con['photo_width'] || $con['photo_width'] == null || $con['photo_width'] == 0) {

                                $img_temp = getimagesize_util(substr($con['file_photo'], 1));
                                $con['photo_width'] = $img_temp[0];
                                $con['photo_height'] = $img_temp[1];

                                $edit_up['id'] = $con['id'];
                                $edit_up['photo_width'] = $img_temp[0];
                                $edit_up['photo_height'] = $img_temp[1];
                                $this->edit($edit_up);
                            }

                        }

                        if( $con['key_movie'] ){
                            $con['play_url'] = get_video_url($con['key_movie'], $con['type_movie']);
                            $con['video_embed'] = get_video_embed_from($con['key_movie'], $con['type_movie']);
                        }

                        if( $con['id_location'] ){
                            $con['locations'] = $locations->get_by_id($con['id_location']);
                        }
                        $this->cache->set("cache_update_" . $_ret[$i]['id'], $con , 604800);

                    }else{
                        $con = false;
                    }

                    $cached_data = $con;

                }
                else {
                    $cached_data['cnt_comments'] = $_ret[$i]['cnt_comments'];
                    $cached_data['cnt_likes'] = $_ret[$i]['cnt_likes'];

                    if ($cached_data['file_photo'] && (!$cached_data['photo_width'] || $cached_data['photo_width'] == null || $cached_data['photo_width'] == 0)) {

                        $img_temp = getimagesize_util(substr($cached_data['file_photo'], 1));
                        $cached_data['photo_width'] = $img_temp[0];
                        $cached_data['photo_height'] = $img_temp[1];

                        $edit_up['id'] = $cached_data['id'];
                        $edit_up['photo_width'] = $img_temp[0];
                        $edit_up['photo_height'] = $img_temp[1];
                        $this->edit($edit_up);
                    }

                }
                $con = $cached_data;

                if( $con ){
                    //에피소드 연관 펫
                    $with_ids = $updates_pets->get_by_update($con['id']);

                    if($with_ids){
                        $con['with_ids'] = $with_ids;

                    }

                    $con['user_info'] = $users->get_by_id_safe($con['id_user']);
                    $with = $con['with_ids'];

                    //피드 주소
                    $con['url'] = '/'.$con['user_info']['login_name'].'/feeds/'.$_ret[$i]['id'];
                    $con['cv_date_created'] = trans_date_ago( $con['date_created'] );

                    if($with){

                        $with_pets = array();
                        $len_with = sizeof($with);

                        for( $j=0; $j < $len_with; $j++ ){
                            $with_pets[$j] = $pets->get($with[$j]['id_pet']);
                        }

                        $con['with'] = $with_pets;
                    }

                    $_ret[$i]['con'] = $con;

                }

            }

        return $_ret;
        }
    }

    function add($_hash_val)
    {
        $c = new Query();

        $c->value('id_user', $_hash_val['id_user']);
        $c->value('type', $_hash_val['type']);

        if (array_key_exists('file_photo', $_hash_val)) {
            $c->value('file_photo', $_hash_val['file_photo']);
        }

        if (array_key_exists('key_movie', $_hash_val)) {
            $c->value('key_movie', $_hash_val['key_movie']);
        }

        if (array_key_exists('type_movie', $_hash_val)) {
            $c->value('type_movie', $_hash_val['type_movie']);
        }

        if (array_key_exists('contents', $_hash_val)) {
            $c->value('contents', htmlspecialchars( $_hash_val['contents'] ));
        }

        if (array_key_exists('cnt_comments', $_hash_val)) {
            $c->value('cnt_comments', $_hash_val['cnt_comments']);
        }

        if (array_key_exists('cnt_likes', $_hash_val)) {
            $c->value('cnt_likes', $_hash_val['cnt_likes']);
        }

        if (array_key_exists('thum_url_movie', $_hash_val)) {
            $c->value('thum_url_movie', $_hash_val['thum_url_movie']);
        }


        if (array_key_exists('id_location', $_hash_val)) {

            $aes_sql = 'HEX(AES_ENCRYPT(\''.$_hash_val['id_location'].'\',\''.$this->settings->AES_KEY.'\'))';
            $c->value('e_id_location', $aes_sql, 1 );

        }

        $c->value('date_created', 'now()', 1);

        return $this->insert($c);

    }

    function edit($_hash_val)
    {
        $c = new Query();

        if (array_key_exists('file_photo', $_hash_val)) {
            $c->value('file_photo', $_hash_val['file_photo']);
        }

        if (array_key_exists('photo_width', $_hash_val)) {
            $c->value('photo_width', $_hash_val['photo_width']);
        }

        if (array_key_exists('photo_height', $_hash_val)) {
            $c->value('photo_height', $_hash_val['photo_height']);
        }

        if (array_key_exists('key_movie', $_hash_val)) {
            $c->value('key_movie', $_hash_val['key_movie']);
        }

        if (array_key_exists('type_movie', $_hash_val)) {
            $c->value('type_movie', $_hash_val['type_movie']);
        }

        if (array_key_exists('contents', $_hash_val)) {
            $c->value('contents', htmlspecialchars( $_hash_val['contents'] ));
        }

        if (array_key_exists('cnt_comments', $_hash_val)) {
            $c->value('cnt_comments', $_hash_val['cnt_comments']);
        }

        if (array_key_exists('cnt_likes', $_hash_val)) {
            $c->value('cnt_likes', $_hash_val['cnt_likes']);
        }

        if (array_key_exists('thum_url_movie', $_hash_val)) {
            $c->value('thum_url_movie', $_hash_val['thum_url_movie']);
        }

        $ids = explode(',', $_hash_val['id']);
        $len = sizeof($ids);

        if ($len > 1) {
            $c->where('id in (' .$ids . ')');
        } else {
            $c->where_eq('id',$_hash_val['id']);
        }

        return $this->update($c);

    }

    function del( $_id_update ='' ){
        global $trail;

        $_ret_val = false;

        if( $_id_update) {

            $ret = $this->get($_id_update, false);

            if( $ret ){

                $globals = $trail->_current_controller->globals;

                $_id_user = $globals->get_user_info('id');
                $_nickname = $globals->get_user_info('nickname');

                if($_id_user == $ret['id_user']){

                    $this->begin();

                    //업데이트 삭제
                    $ck1 = $this->delete($_id_update);

                    $updates_comments = load_model('Updates_comments');
                    $updates_likes = load_model('Updates_likes');
                    $updates_pets = load_model('Updates_pets');
                    $updates_locations = load_model('Updates_locations');
                    $feeds = load_model('Feeds');
                    $featured_data = load_model('Featured_data');
                    $updates_tag = load_model('Updates_tag');

                    //업데이트 코멘트 삭제
                    $ck2 = $updates_comments->del_by_id_update($_id_update);

                    //업데이트 like 삭제
                    $ck3 = $updates_likes->del_by_id_update($_id_update);

                    //업데이트 와 펫 연결 삭제
                    $ck4 = $updates_pets->del_by_id_update($_id_update, $ret['type']);

                    //업데이트 와 location 연결 삭제
                    $ck5 = $updates_locations->del_by_id_update( $_id_update, $ret['id_location'] );

                    //업데이트 피드 삭제
                    $ck6 = $feeds->del_by_id_and_type($_id_update, 1, $_id_user);

                    //업데이트 예뻐요 피드 삭제
                    $ck7 = $feeds->del_by_id_and_type($_id_update, 4, $_id_user);

                    //인기 업데이트 삭제
                    $ck8 = $featured_data->del_by_id_type($_id_update, '1,4');

                    //업데이트 tag 삭제
                    $ck9 = $updates_tag->del_by_id_update($_id_update);

                    if( !$ck1 && !$ck2 && !$ck3 && !$ck4 && !$ck5 && !$ck6 && !$ck7 && !$ck8 && !$ck9 ){

                        $this->commit();

                        //캐쉬 삭제
                        $current_y_m = date("Y").'-'.date("m");
                        $this->cache->delete("cache_update_".$_id_update, "ALL");
                        $this->cache->delete("archive_date_" .$_id_user.'_'.$current_y_m, "ALL");

                        $img_temp_name = $ret['file_photo'];

                        //업데이트 파일 삭제
                        if($img_temp_name){

                            //원본 이미지 지우기
                            $file = get_photo_thumb2($img_temp_name);
                            $file_path = $this->settings->root_path.$file;
                            if(file_exists($file_path)){
                                unlink($file_path);
                                util_signal_image_delete_sync($file);
                            }

                            //150_150 파일 지우기
                            $file_150 = get_photo_thumb2($img_temp_name, '150_150');
                            $file_path_150 = $this->settings->root_path.$file_150;
                            if( file_exists($file_path_150) ){
                                unlink($file_path_150);
                                util_signal_image_delete_sync($file_150);
                            }

                            //400_800 파일 지우기
                            $file_400 = get_photo_thumb2($img_temp_name, '400_800');
                            $file_path_400 = $this->settings->root_path.$file_400;
                            if( file_exists($file_path_400) ){
                                unlink($file_path_400);
                                util_signal_image_delete_sync($file_400);
                            }

                            //72_72 파일 지우기
                            $file_72 = get_photo_thumb2($img_temp_name, '72_72');
                            $file_path_72 = $this->settings->root_path.$file_72;
                            if( file_exists($file_path_72) ){
                                unlink($file_path_72);
                                util_signal_image_delete_sync($file_72);
                            }

                            //640_640 파일 지우기
                            $file_640 = get_photo_thumb2($img_temp_name, '640_640');
                            $file_path_640 = $this->settings->root_path.$file_640;
                            if( file_exists($file_path_640) ){
                                unlink($file_path_640);
                                util_signal_image_delete_sync($file_640);
                            }

                        }

                    }else{
                        $this->rollback();

                        $_ret_val[0] = $ck1;
                        $_ret_val[1] = $ck2;
                        $_ret_val[2] = $ck3;
                        $_ret_val[3] = $ck4;
                        $_ret_val[4] = $ck5;
                        $_ret_val[5] = $ck6;
                        $_ret_val[6] = $ck7;
                        $_ret_val[7] = $ck8;

                    }

                }else{
                    $_ret_val = $_nickname.'님 의 이야기가 아닙니다.';
                }

            }else{
                $_ret_val = '이미 삭제 되었습니다.';
            }

        }else{
            $_ret_val = '키값이 잘못되었습니다.';
        }

        return $_ret_val;

    }

    function del_api( $_id_update , $_id_user){
//        global $trail;

        $_ret_val = false;

        if( $_id_update) {

            $ret = $this->get($_id_update, false);

            if( $ret ){

//                $globals = $trail->_current_controller->globals;
//
//                $_id_user = $globals->get_user_info('id');
//                $_nickname = $globals->get_user_info('nickname');

                if($_id_user == $ret['id_user']){

                    $this->begin();

                    //업데이트 삭제
                    $ck1 = $this->delete($_id_update);

                    $updates_comments = load_model('Updates_comments');
                    $updates_likes = load_model('Updates_likes');
                    $updates_pets = load_model('Updates_pets');
                    $updates_locations = load_model('Updates_locations');
                    $feeds = load_model('Feeds');
                    $featured_data = load_model('Featured_data');
                    $updates_tag = load_model('Updates_tag');

                    //업데이트 코멘트 삭제
                    $ck2 = $updates_comments->del_by_id_update($_id_update);

                    //업데이트 like 삭제
                    $ck3 = $updates_likes->del_by_id_update($_id_update);

                    //업데이트 와 펫 연결 삭제
                    $ck4 = $updates_pets->del_by_id_update($_id_update, $ret['type']);

                    //업데이트 와 location 연결 삭제
                    $ck5 = $updates_locations->del_by_id_update( $_id_update, $ret['id_location'] );

                    //업데이트 피드 삭제
                    $ck6 = $feeds->del_by_id_and_type($_id_update, 1, $_id_user);

                    //업데이트 예뻐요 피드 삭제
                    $ck7 = $feeds->del_by_id_and_type($_id_update, 4, $_id_user);

                    //인기 업데이트 삭제
                    $ck8 = $featured_data->del_by_id_type($_id_update, 1);

                    //업데이트 tag 삭제
                    $ck9 = $updates_tag->del_by_id_update($_id_update);

                    if( !$ck1 && !$ck2 && !$ck3 && !$ck4 && !$ck5 && !$ck6 && !$ck7 && !$ck8 && !$ck9 ){

                        $this->commit();

                        //캐쉬 삭제
                        $current_y_m = date("Y").'-'.date("m");
                        $this->cache->delete("cache_update_".$_id_update, "ALL");
                        $this->cache->delete("archive_date_" .$_id_user.'_'.$current_y_m, "ALL");

                        $img_temp_name = $ret['file_photo'];

                        //업데이트 파일 삭제
                        if($img_temp_name){

                            //원본 이미지 지우기
                            $file = get_photo_thumb2($img_temp_name);
                            $file_path = $this->settings->root_path.$file;
                            if(file_exists($file_path)){
                                unlink($file_path);
                                util_signal_image_delete_sync($file);
                            }

                            //150_150 파일 지우기
                            $file_150 = get_photo_thumb2($img_temp_name, '150_150');
                            $file_path_150 = $this->settings->root_path.$file_150;
                            if( file_exists($file_path_150) ){
                                unlink($file_path_150);
                                util_signal_image_delete_sync($file_150);
                            }

                            //400_800 파일 지우기
                            $file_400 = get_photo_thumb2($img_temp_name, '400_800');
                            $file_path_400 = $this->settings->root_path.$file_400;
                            if( file_exists($file_path_400) ){
                                unlink($file_path_400);
                                util_signal_image_delete_sync($file_400);
                            }

                            //72_72 파일 지우기
                            $file_72 = get_photo_thumb2($img_temp_name, '72_72');
                            $file_path_72 = $this->settings->root_path.$file_72;
                            if( file_exists($file_path_72) ){
                                unlink($file_path_72);
                                util_signal_image_delete_sync($file_72);
                            }

                            //640_640 파일 지우기
                            $file_640 = get_photo_thumb2($img_temp_name, '640_640');
                            $file_path_640 = $this->settings->root_path.$file_640;
                            if( file_exists($file_path_640) ){
                                unlink($file_path_640);
                                util_signal_image_delete_sync($file_640);
                            }

                        }

                    }else{
                        $this->rollback();

                        $_ret_val[0] = $ck1;
                        $_ret_val[1] = $ck2;
                        $_ret_val[2] = $ck3;
                        $_ret_val[3] = $ck4;
                        $_ret_val[4] = $ck5;
                        $_ret_val[5] = $ck6;
                        $_ret_val[6] = $ck7;
                        $_ret_val[7] = $ck8;
                        $_ret_val[8] = $ck9;

                    }

                }else{
                    $_ret_val = '사용자의 이야기가 아닙니다.';
                }

            }else{
                $_ret_val = '이미 삭제 되었습니다.';
            }

        }else{
            $_ret_val = '키값이 잘못되었습니다.';
        }

        return $_ret_val;

    }

    // 여기서부터 관리자 영역, 고빈섭이 작업합니다.
    function counts_by_date($_date, $_days = 1, $lang = null)
    {
        // 일별 가입자 카운트
        $current = date("Y-m-d");
        $ret = array();
        for ($i=$_days;$i>0;$i--)
        {
            $_date_st = dateplus($_date, -1 * $i + 1);
            $_date_ed = dateplus($_date, -1 * $i + 2);

            if ($_date_st > $current) break;
            $c = new Query();
            $c->where("date_created between '" . $_date_st . "' and '" . $_date_ed . "'");

            if ($lang) $c->where("id_user in (select id from users where lang = '" . $lang . "')");
            $ret[$_date_st] = $this->counts($c);
        }

        return $ret;

    }


    function counts_by_month($_yr, $lang = null, $lang = null)
    {
        // 일별 가입자 카운트

        $ret = array();
        $current = date("Y-m-d h:i:s");

        for ($i=1;$i<=12;$i++)
        {
            $_mt = $i;
            $_mt_next = $_mt+1;
            if ($_mt >= 12)
            {
                $_yr_next = $_yr + 1;
                $_mt_next = 1;
            }
            else
            {
                $_yr_next = $_yr;
            }

            $_date_st = $_yr . "-";
            if ($_mt < 10) $_date_st = $_date_st . "0";
            $_date_st = $_date_st . $_mt . "-01";
            $_date_st = $_date_st . " 00:00:00";

            if ($_date_st > $current) break;

            $_date_ed = $_yr_next . "-";
            if ($_mt_next < 10) $_date_ed = $_date_ed . "0";
            $_date_ed = $_date_ed . $_mt_next . "-01 00:00:00";

            $c = new Query();
            if ($lang) $c->where("id_user in (select id from users where lang = '" . $lang . "')");
            $c->where("date_created between '" . $_date_st . "' and '" . $_date_ed . "'");

            $_date_st = $_yr . "/";
            if ($_mt < 10) $_date_st = $_date_st . "0";
            $_date_st = $_date_st . $_mt;

            $ret[$_date_st] = $this->counts($c);
        }

        return $ret;

    }

    // 여기까지 관리자 영역

    // 여기는 유진우 작업(친구, 나 에피소드 가져오기)
    function get_friend_me_by_id_user($id_user ,$_last_id ,$page_size =10,$_more = false, $_order = 'date_created desc'){
        $c = new Query();
        $c->where('( id_user='.$id_user.' or id_user in (select id_target from friends where id_follower='.$id_user.') )');
//        $c->page = $page_no;
//        $c->page_size = $page_size;

        if ($page_size)
        {
            $c->limit = $page_size;
        }

        if($_more){
//            $where = '((date_created < \'' . $_date_created . '\') OR ';
//            $where = $where.'(date_created = \''. $_date_created . '\' AND id_foreign < ' . $_id_foreign . '))';
            $where = 'id < ' . $_last_id;

            $c->where($where);
        }

        if($_order) $c->order = $_order;
        $select = 'id,id_user,type,file_photo,photo_width,photo_height,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $select = $select.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';
        return $this->fetch($select,$c);
    }
    function get_friend_me_by_id_user_count($id_user){
        $c = new Query();
        $c->where('( id_user='.$id_user.' or id_user in (select id_target from friends where id_follower='.$id_user.') )');
        return $this->counts($c);
    }


    function get_me_by_id_user($id_user ,$_last_id ,$page_size =10,$_more = false, $_order = 'date_created desc'){
        $c = new Query();
        $c->where_eq('id_user',$id_user);
//        $c->page = $page_no;
//        $c->page_size = $page_size;

        if ($page_size)
        {
            $c->limit = $page_size;
        }

        if($_more){
            $where = 'id < ' . $_last_id;
            $c->where($where);
        }

        if($_order) $c->order = $_order;
        $select = 'id,id_user,type,file_photo,photo_width,photo_height,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $select = $select.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';
        return $this->fetch($select,$c);
    }

    function get_me_by_id_user_cnt($id_user){
        $c = new Query();
        $c->where_eq('id_user',$id_user);
        return $this->counts($c);
    }

    //위치 아이디로 에피소드 가져오기
    function get_by_id_location($id_location ,$_last_id,$page_size =10, $_more = false, $_order = 'date_created desc, id desc')
    {
        $c = new Query();
        $c->where("e_id_location=".'HEX(AES_ENCRYPT('.$id_location.',\''.$this->settings->AES_KEY.'\'))' );
//        $c->page = $page_no;
//        $c->page_size = $page_size;


        if ($page_size)
        {
            $c->limit = $page_size;
        }

        if($_more){
//            $where = '((date_created < \'' . $_date_created . '\') OR ';
//            $where = $where.'(date_created = \''. $_date_created . '\' AND id_foreign < ' . $_id_foreign . '))';
            $where = 'id < ' . $_last_id;

            $c->where($where);
        }



        if($_order) $c->order = $_order;
        $select = 'id,id_user,type,file_photo,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $select = $select.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';
        return $this->fetch($select,$c);
    }

    function get_by_id_location_count($id_location)
    {
        $c = new Query();
        $c->where("e_id_location=".'HEX(AES_ENCRYPT('.$id_location.',\''.$this->settings->AES_KEY.'\'))' );
        return $this->counts($c);
    }


    function get_by_distance($location_lat, $location_lon, $distance, $_last_id, $page_size= 10, $_more = false, $order = 'date_created desc, id desc')
    {
        /* http://www.phpschool.com/gnuboard4/bbs/board.php?bo_table=qna_function&wr_id=324492#c_324492 참조 */
        $where = 'id in (select id_update from '
        .'(select '
        .'AES_DECRYPT( UNHEX(e_id_update) , \''.$this->settings->AES_KEY.'\') as id_update'
        .',location_lat'
        .',location_lon'
        .',date_created'
        .',ROUND((ACOS(COS(RADIANS(90- '.$location_lat.'))*COS(RADIANS(90- location_lat ))+SIN(RADIANS(90- '.$location_lat.'))*SIN(RADIANS(90- location_lat ))*COS(RADIANS('.$location_lon.'-location_lon)))*6371000), 0) distance'
        .' from updates_locations'
        .' where location_lat between '.$location_lat.'-'.$distance.'/(31*3600) and '.$location_lat.'+'.$distance.'/(31*3600)'
        .' and location_lon between '.$location_lon.'-'.$distance.'/(25*3600) and '.$location_lon.'+'.$distance.'/(25*3600) ) a'
        .' where a.distance <='.$distance.')';
        $c = new Query();
        $c->where($where);
//        $c->page = $page_no;
//        $c->page_size = $page_size;

        if ($page_size)
        {
            $c->limit = $page_size;
        }

        if($_more){
//            $where = '((date_created < \'' . $_date_created . '\') OR ';
//            $where = $where.'(date_created = \''. $_date_created . '\' AND id_foreign < ' . $_id_foreign . '))';
            $where = 'id < ' . $_last_id;
            $c->where($where);
        }

        $c->order = $order;
        $select = 'id,id_user,type,file_photo,key_movie,type_movie,contents,cnt_comments,cnt_likes,date_created,thum_url_movie,';
        $select = $select.'AES_DECRYPT( UNHEX(e_id_location) , \''.$this->settings->AES_KEY.'\') as id_location';
        return $this->fetch($select,$c);

    }

    function get_by_distance_count($location_lat, $location_lon, $distance)
    {
        /* http://www.phpschool.com/gnuboard4/bbs/board.php?bo_table=qna_function&wr_id=324492#c_324492 참조 */
        $where = 'id in (select id_update from '
        .'(select '
        .'AES_DECRYPT( UNHEX(e_id_update) , \''.$this->settings->AES_KEY.'\') as id_update'
        .',location_lat'
        .',location_lon'
        .',date_created'
        .',ROUND((ACOS(COS(RADIANS(90- '.$location_lat.'))*COS(RADIANS(90- location_lat ))+SIN(RADIANS(90- '.$location_lat.'))*SIN(RADIANS(90- location_lat ))*COS(RADIANS('.$location_lon.'-location_lon)))*6371000), 0) distance'
        .' from updates_locations'
        .' where location_lat between '.$location_lat.'-'.$distance.'/(31*3600) and '.$location_lat.'+'.$distance.'/(31*3600)'
        .' and location_lon between '.$location_lon.'-'.$distance.'/(25*3600) and '.$location_lon.'+'.$distance.'/(25*3600) ) a'
        .' where a.distance <='.$distance.')';
        $c = new Query();
        $c->where($where);
        return $this->counts($c);

    }

    // 여기까지 유진우 작업

    // byyeong :: 1.5 추가
    function next_media_feed($id_user, $last_id_update, $is_pre = 0, $is_media = 0)
    {
        $c = new Query();
        $c->where("id_user = ".$id_user);

        if ($is_media) {
            $c->where("(file_photo != '' OR key_movie != '')");
            $c->where("(TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
        }
//        else
//            $c->where("(TYPE = 1 OR TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
        if ($is_pre) {
            $c->where("id < ".$last_id_update);
            $c->order="id DESC";
        }
        else {
            $c->where("id > ".$last_id_update);
            $c->order="id ASC";
        }

        $c->limit=1;
        $result = $this->fetch_one("*", $c);

        if (!$result) {

            if ($is_pre) {

                $d = new Query();
                $d->where("id_user = ".$id_user);

                if ($is_media) {
                    $d->where("(file_photo != '' OR key_movie != '')");
                    $d->where("(TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
                }
//                else
//                    $d->where("(TYPE = 1 OR TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
                $d->order="id DESC";
                $d->limit=1;
                $result = $this->fetch_one("*", $d);

            }
            else {

                $e = new Query();
                $e->where("id_user = ".$id_user);

                if ($is_media) {
                    $e->where("(file_photo != '' OR key_movie != '')");
                    $e->where("(TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
                }
//                else
//                    $e->where("(TYPE = 1 OR TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
                $e->order="id ASC";
                $e->limit=1;
                $result = $this->fetch_one("*", $e);

            }
        }

        return $result['id'];
    }

    // byyeong :: 1.5 추가
    function next_pet_media_feed($id_user, $last_id_update, $is_pre = 0, $media = 2, $pet = 0)
    {
        $c = new Query();
        $c->from="updates u, updates_pets up";
        $c->where("up.id_update = u.id");
        if ($media == 2) {
            $c->where("file_photo != ''");
            $c->where("TYPE IN ( 2, 6)");
        }
        else if ($media == 3) {
            $c->where("key_movie != ''");
            $c->where("TYPE = 3");
        }

        $c->where("id_pet = ".$pet);

//        else
//            $c->where("(TYPE = 1 OR TYPE = 2 OR TYPE = 3 OR TYPE = 6)");
        if ($is_pre) {
            $c->where("id < ".$last_id_update);
            $c->order="id DESC";
        }
        else {
            $c->where("id > ".$last_id_update);
            $c->order="id ASC";
        }

        $c->limit=1;
        $result = $this->fetch_one("*", $c);

        if (!$result) {

            if ($is_pre) {

                $d = new Query();
                $d->from="updates u, updates_pets up";
                $d->where("up.id_update = u.id");
                if ($media == 2) {
                    $d->where("file_photo != ''");
                    $d->where("TYPE IN ( 2, 6)");
                }
                else if ($media == 3) {
                    $d->where("key_movie != ''");
                    $d->where("TYPE = 3");
                }
                $d->where("id_pet = ".$pet);

                $d->order="id DESC";
                $d->limit=1;
                $result = $this->fetch_one("*", $d);

            }
            else {

                $e = new Query();
                $e->from="updates u, updates_pets up";
                $e->where("up.id_update = u.id");
                if ($media == 2) {
                    $e->where("file_photo != ''");
                    $e->where("TYPE IN ( 2, 6)");
                }
                else if ($media == 3) {
                    $e->where("key_movie != ''");
                    $e->where("TYPE = 3");
                }
                $e->where("id_pet = ".$pet);

                $e->order="id ASC";
                $e->limit=1;
                $result = $this->fetch_one("*", $e);

            }
        }

        return $result['id'];
    }

    function active_users()
    {
//        $this->debug();
        $c = new Query();
        $c->from="updates up,users u";
        $c->where("up.id_user = u.id");
        $c->where("type IN (1,2,3,5,6)");
        $c->where("up.date_created > DATE_ADD(NOW(), INTERVAL -7 DAY)");
        $c->group="id_user";
        $c->order="cnt DESC";
        return $this->fetch("COUNT(*) cnt, u.id, login_name, nickname, welcome, url, recv_email, date_updated", $c);
    }

    function del_cache($_id_update)
    {
        $this->cache->delete("cache_update_".$_id_update, "ALL");
    }

}
