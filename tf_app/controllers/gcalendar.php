<?
class Gcalendar extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "";
    var $use_models = array("Code", "Space_reserve", "Event", "Office_hours", "Competitions");

    public function index(){
        ini_set('memory_limit', -1);
        $this->tpl_name = "";
        require_once '../tf_app/ext/google/autoload.php';
        session_start(); 

        // ********************************************************  //
        // Get these values from https://console.developers.google.com
        // Be sure to enable the Analytics API
        // ********************************************************    //
        
        // violet
        $client_id = '334086275725-f15a3bl6bm7kbhfkm66u9va1si5bb9ia.apps.googleusercontent.com';
        $client_secret = 'FbKWozz_ZNmlk5PUEXPC2BUO';

        // dcamp
        // $client_id = '77977713151-g8vu8dfj8ehn6ac53h3fmifau36g824o.apps.googleusercontent.com';
        // $client_secret = 'fO90AB1epKqAYZUqVojZ883k';

        $redirect_uri = 'http://dcamp.kr/gcalendar';

        $client = new Google_Client();
        $client->setApplicationName("test-calendar");
        $client->setClientId($client_id);
        $client->setClientSecret($client_secret);
        $client->setRedirectUri($redirect_uri);
        $client->setAccessType('offline');   // Gets us our refreshtoken
        $client->setApprovalPrompt('force');
        $client->setScopes(array('https://www.googleapis.com/auth/calendar'));

        // Use refresh token.
        $rt = $this->Code->get_by_key('gcalendar');
        if ($rt[0]["_value"]) {
            $refrestoketn = $rt[0];
            $client->refreshToken($refrestoketn["_value"]);

            $_SESSION['t'] = $client->getAccessToken();
            $token = json_decode($_SESSION['t']);
            if ($token->access_token) $_SESSION['token'] = $_SESSION['t'];
        }
        
        if (isset($_GET['code'])) {
        $client->authenticate($_GET['code']);  
        $_SESSION['token'] = $client->getAccessToken();
        $redirect = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'];
        header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
        }

        // For loging out.
        if (isset($_GET['logout'])) {
        unset($_SESSION['token']);
        }

        // Step 1:  The user has not authenticated we give them a link to login 
        if (!isset($_SESSION['token'])) {

        $authUrl = $client->createAuthUrl();

        print "<a class='login' href='$authUrl'>Connect Me!</a>";
        }      

        // Step 3: We have access we can now create our service
        if (isset($_SESSION['token'])) {
            $client->setAccessToken($_SESSION['token']);
            $service = new Google_Service_Calendar($client);
            $token = json_decode($_SESSION['token']);
            if ($token->refresh_token) {
                $_arr["_key"] = "gcalendar";
                $_arr["_value"] = $token->refresh_token;
                $_arr["id"] = 9222;
                $this->Code->debug();
                $this->Code->add($_arr);
            }                

            // echo "<br>Access Token = " . $token->access_token . '<br/>';
            // echo "Refresh Token = " . $token->refresh_token . '<br/>';
            // echo "Token type = " . $token->token_type . '<br/>';
            // echo "Expires in = " . $token->expires_in . '<br/>';
            // echo "ID Token = " . $token->id_token . '<br/>';
            // echo "Created = " . $token->created . '<br/>';

            print "<a class='logout' href='http://dcamp.kr/gcalendar?logout=1'>LogOut</a><br>";

            // event
            if ($_REQUEST["type"] == "e") {
                $_calId = '3h37pgh9qvtvd9r7jun88elhfk@group.calendar.google.com';
                
                // remove
                $events = $service->events->listEvents($_calId);
                
                while(true) {
                  foreach ($events->getItems() as $event) {
                    $service->events->delete($_calId, $event->id);
                  }
                  $pageToken = $events->getNextPageToken();
                  if ($pageToken) {
                    $optParams = array('pageToken' => $pageToken);
                    $events = $service->events->listEvents($_calId, $optParams);
                  } else {
                    break;
                  }
                }

                // write
                $ev = $this->Event->list_(1, 10000, 'e.state = 1 and open = 1 and (e.date > "'.date('Y.m.d', strtotime('-1 month')).'" or e.date_e > "'.date('Y.m.d', strtotime('-1 month')).'")');
                $len_ev = sizeof($ev);
                for ($r=0; $r<$len_ev; $r++) {
                    $ev[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ev[$r]["date"]).$ev[$r]["start"])), 'T', 10, 0);
                    $ev[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ev[$r]["date_e"]).$ev[$r]["end"])), 'T', 10, 0);
                    $ev[$r]["summary"] = "[Event] ".str_replace('&', '%26', str_replace('#', '%23',$ev[$r]["title"]));
                    if ($ev[$r]["space_id"] == 0)
                        $ev[$r]["location"] =  $ev[$r]["space_etc"];
                    else
                        $ev[$r]["location"] =  "D.CAMP ".$ev[$r]["opt"]."F ".explode_ext($ev[$r]["sname"], '('); 
                }
                
                $fo = $ev;
            }

            // office_hours
            if ($_REQUEST["type"] == "o") {
                $_calId = 'nimj7bsr657bed4tvbs9e2f0v8@group.calendar.google.com';

                // remove
                $events = $service->events->listEvents($_calId);
                
                while(true) {
                  foreach ($events->getItems() as $event) {
                    $service->events->delete($_calId, $event->id);
                  }
                  $pageToken = $events->getNextPageToken();
                  if ($pageToken) {
                    $optParams = array('pageToken' => $pageToken);
                    $events = $service->events->listEvents($_calId, $optParams);
                  } else {
                    break;
                  }
                }

                // write
                $off = $this->Office_hours->list_(1, 1000, 'o.status = 1 and o.is_open = 1 and o.e_start > "'.date('Y.m.d', strtotime('-1 month')).'"');
                $len_off = sizeof($off);
                for ($r=0; $r<$len_off; $r++) {
                    $off[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", str_replace(" ", "", $off[$r]["e_start"])))), 'T', 10, 0);
                    $off[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", str_replace(" ", "", $off[$r]["e_end"])))), 'T', 10, 0);
                    $off[$r]["summary"] = "[Office Hours] ".str_replace('&', '%26', str_replace('#', '%23',$off[$r]["subject"]));
                    $off[$r]["location"] =  "D.CAMP ".$off[$r]["place"];
                }
                
                $fo = $off;
            }
            
            // challenge
            if ($_REQUEST["type"] == "c") {
                $_calId = 'og6984e1dnfuvjdgrv9j52f95o@group.calendar.google.com';

                // remove
                $events = $service->events->listEvents($_calId);
                
                while(true) {
                  foreach ($events->getItems() as $event) {
                    $service->events->delete($_calId, $event->id);
                  }
                  $pageToken = $events->getNextPageToken();
                  if ($pageToken) {
                    $optParams = array('pageToken' => $pageToken);
                    $events = $service->events->listEvents($_calId, $optParams);
                  } else {
                    break;
                  }
                }

                // write
                $ch = $this->Competitions->get_list(1, 1000, 'c.status = 1 and c.open = 1 and (c.date_s > "'.date('Y.m.d', strtotime('-1 month')).'" or c.date_e > "'.date('Y.m.d', strtotime('-1 month')).'")');
                $len_ch = sizeof($ch);
                for ($r=0; $r<$len_ch; $r++) {
                    $ch[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ch[$r]["date_s"]).$ch[$r]["time_s"])), 'T', 10, 0);
                    $ch[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $ch[$r]["date_e"]).$ch[$r]["time_e"])), 'T', 10, 0);
                    $ch[$r]["summary"] = "[Challenge] ".str_replace('&', '%26', str_replace('#', '%23',$ch[$r]["subject"]));
                    $ch[$r]["location"] =  "";
                }
                
                $fo = $ch;
            }

            // reservation
            if ($_REQUEST["type"] == "r") {
                // remove
                $_calId = '6er2bdtm0ojetsnn09uj6plbq8@group.calendar.google.com';
                $events = $service->events->listEvents($_calId);
                
                while(true) {
                  foreach ($events->getItems() as $event) {
                    // echo $event->getSummary();
                    $service->events->delete($_calId, $event->id);
                  }
                  $pageToken = $events->getNextPageToken();
                  if ($pageToken) {
                    $optParams = array('pageToken' => $pageToken);
                    $events = $service->events->listEvents($_calId, $optParams);
                  } else {
                    break;
                  }
                }

                // write
                $rsv = $this->Space_reserve->list_(1, 1000, 'sr.state = 1 and sr.date > "'.date('Y.m.d', strtotime('-1 month')).'"');
                $len_rsv = sizeof($rsv);
                for ($r=0; $r<$len_rsv; $r++) {
                    $rsv[$r]["s"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $rsv[$r]["date"]).$rsv[$r]["start"])), 'T', 10, 0);
                    $rsv[$r]["e"] = substr_replace(date("Y-m-dH:i:00",strtotime(str_replace(".", "-", $rsv[$r]["date"]).$rsv[$r]["end"])), 'T', 10, 0);
                    $rsv[$r]["summary"] = "[".$rsv[$r]["opt"]."F ".explode_ext($rsv[$r]["name"], '(')."] ".$rsv[$r]["purpose"];
                    $rsv[$r]["location"] =  $rsv[$r]["opt"]."F ".explode_ext($rsv[$r]["name"], '(');
                }
                
                $fo = $rsv;
            }

            if ($fo) {
                $len_fo = sizeof($fo);
                for ($i=0; $i<$len_fo; $i++) {
                    $event = new Google_Service_Calendar_Event(array(
                      'summary' => $fo[$i]["summary"],
                      // 'description' => 'A chance to hear more about Google\'s developer products.',
                      'location' => $fo[$i]["location"],
                      'start' => array(
                        'dateTime' => $fo[$i]["s"],
                        'timeZone' => "Asia/Seoul"
                      ),
                      'end' => array(
                        'dateTime' => $fo[$i]["e"],
                        'timeZone' => "Asia/Seoul"
                      ),
                    ));

                    $calendarId = $_calId;
                    $event = $service->events->insert($calendarId, $event);
                    // printf('<br>Event created: %s\n', $event->htmlLink);
                }  
                echo $token->expires_in."/".date("Y-m-d H:i:s")." ".$_REQUEST["type"]." done!";      
            }       
        }
    }
}
?>