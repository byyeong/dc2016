<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class Lounge extends Controller
{
    var $assigns = array();
    var $assigns_layout = array();
    var $layout = "lounge";
    var $use_models = array("Board", "Event", "Event_reserve", "Entrance", "Member_ext"
            , "Startup_member", "Main", "Notice", "Content", "Competitions", "Office_hours"
            , "Members", "Program", "Startup_service");

    public function before_calling()
    {
        $this->assigns_layout["gnb"] = "lounge";
        $this->assigns_layout["gnb_title"] = "디캠프 라운지";
        $this->assigns["s"] = $_SESSION["s"];
        $this->assigns_layout["s"] = $_SESSION["s"];
    }

    public function today()
    {
        $this->assigns["event"] = $this->Event->list_(1, 10, 'e.date <= "' .date("Y.m.d"). '" and e.date_e >= "' .date("Y.m.d"). '" and  open = 1 and e.state = 1', '', 'e.date DESC');
        $today_ev_users = $this->Event_reserve->list_(1, 100, "e.space_id > 0 and er.state = 1 and CONCAT(date, ' ', start) < '".date("Y.m.d H:i")."' AND CONCAT(date_e, ' ', end) > '".date("Y.m.d H:i")."'");

        $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out IS NULL and  date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');
        $users = array_merge($today_dcamp_users, $today_ev_users);
        $this->assigns["users"] = $users;
        $this->assigns_layout["users"] = $users;
    }
    
    public function index()
    {
        $this->assigns_layout["tpl"] = "main";
        $today_ev_users = $this->Event_reserve->list_(1, 100, "e.space_id > 0 and er.state = 1 and date = '".date("Y.m.d")."'");
        $today_dcamp_users = $this->Entrance->list_('', '', '', 'date_out IS NULL and date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');

        $users = array_merge($today_dcamp_users, $today_ev_users);

        // $comments = $this->Board->list_(Board_model::EVENT_TYPE, 0, $_page = 1, $_pagesize = 10);
        $comments = $this->Board->list_in(0, $_page = 1, $_pagesize = 10, "p_type in (3, 6, 7, 8, 9, 10)");
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($comments[$i]["p_type"] == 3 && $comments[$i]["p_id"] > 0 ) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
            }
            else if ($comments[$i]["p_type"] == 6) {
                $e = $this->Content->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["subject"];
            }
            else if ($comments[$i]["p_type"] == 7) {
                $e = $this->Competitions->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["subject"];
            }
            else if ($comments[$i]["p_type"] == 8) {
                $e = $this->Office_hours->get_detail($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["subject"];
            }
            else if ($comments[$i]["p_type"] == 9) {
                $e = $this->Program->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
            }
            else if ($comments[$i]["p_type"] == 10) {
                $e = $this->Startup_service->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["name"];
            }
            $comments[$i]["comm"] = $this->Board->get_comment($comments[$i]["p_type"], $comments[$i]["id"]);
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
            $comments[$i]["is_like"] = $this->Board->get_like_this($comments[$i]["id"], $_SESSION["s"]["id"]);
        }
        
        $this->assigns["comments"] = $comments;
        $this->assigns["page"] = 1;
        $this->assigns["users"] = $users;
        $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::TWITTER_TYPE);
        $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::FACEBOOK_TYPE);
        $this->assigns["id"] = 0;
        $this->today();
        $this->assigns_layout["og_url"] = "http://dcamp.kr/lounge";
    }

    public function event($_id = '')
    {
        $this->assigns_layout["tpl"] = "event";
        $res = $this->Event->get($_id);
        if ( ! $_id || ! $res) {
            header("Location: /lounge");
        }

        $users = $this->Event_reserve->list_('', '', "er.state = 1 and e.id = ".$_id);
        $comments = $this->Board->list_(Board_model::EVENT_TYPE, $_id, $_page = 1, $_pagesize = 10);
        for ( $i=0; $i<sizeof($comments); $i++ ){
            if ($_id == 0 && $comments[$i]["p_id"] > 0 ) {
                $e = $this->Event->get($comments[$i]["p_id"]);
                $comments[$i]["p_name"] = $e["title"];
            }
            $comments[$i]["comm"] = $this->Board->get_comment($_type = 3, $comments[$i]["id"]);
            $comments[$i]["like"] = $this->Board->get_like_cnt($comments[$i]["id"]);
            $comments[$i]["is_like"] = $this->Board->get_like_this($comments[$i]["id"], $_SESSION["s"]["id"]);
        }

        $this->assigns["comments"] = $comments;
        $this->assigns["paging"] = get_paging_dot2($_page, $comments_cnt, $_pagesize); 
        $this->assigns["page"] = $_page;
        $this->assigns["res"] = $res;

        $this->today();
        $this->assigns["users"] = $users;
        $this->assigns["star"] = $this->Event->get_average_star($_id);

        $this->assigns["tw"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::TWITTER_TYPE);
        $this->assigns["fb"] = $this->Member_ext->get_by_user_id_type($_SESSION["s"]["id"], Member_ext_model::FACEBOOK_TYPE);
        $this->assigns["id"] = $_id;
        $this->assigns["check"] = $this->Event->check_star($_id, $_SESSION["s"]["id"]);
        $this->assigns_layout["og_url"] = "http://dcamp.kr/lounge/event/".$_id;
    }

    public function comment($_id = '')
    {
        $this->assigns_layout["tpl"] = "permalink";
        $res = $this->Board->get_detail($_id);
        if ( ! $_id || ! $res) {
            header("Location: /lounge");
        }

        $this->today();

        if ($res["p_type"] == 3 && $res["p_id"] > 0) {
            $ev = $this->Event->get($res["p_id"]);
            $ev["u"] = "/lounge/event/".$ev["id"];
            $ev["t"] = "Event - ".$ev["title"];
            $this->assigns["ev"] = $ev;
        }
        else if ($res["p_type"] == 6) {
            $ev = $this->Content->get($res["p_id"]);
            $ev["u"] = "/contents/views/".$ev["id"];
            $ev["t"] = "Blog - ".$ev["subject"];
            $this->assigns["ev"] = $ev;
        }
        else if ($res["p_type"] == 7) {
            $ev = $this->Competitions->get($res["p_id"]);
            $ev["u"] = "/challenge/views/".$ev["id"];
            $ev["t"] = "Challenge - ".$ev["subject"];
            $this->assigns["ev"] = $ev;
        }
        else if ($res["p_type"] == 8) {
            $ev = $this->Office_hours->get_detail($res["p_id"]);
            $ev["u"] = "/office_hours/mentor/".$ev["mento_id"];
            $ev["t"] = "Office Hours - ".$ev["subject"];
            $this->assigns["ev"] = $ev;
        }
        else if ($res["p_type"] == 9) {
            $ev = $this->Program->get($res["p_id"]);
            $ev["u"] = "/benefits/views/".$ev["id"];
            $ev["t"] = "Benefits - ".$ev["title"];
            $this->assigns["ev"] = $ev;
        }
        else if ($res["p_type"] == 10) {
            $ev = $this->Startup_service->get($res["p_id"]);
            $ev["u"] = "/showcase/views/".$ev["id"];
            $ev["t"] = "Showcase - ".$ev["name"];
            $this->assigns["ev"] = $ev;
        }
        
        if ($res["p_type"] == 3 && $res["p_id"] > 0) {
            $users = $this->Event_reserve->list_('', '', "er.state = 1 and e.id = ".$res["p_id"]);
            $this->assigns["users"] = $users;
        }
        else {
            $this->today();
        }

        $this->assigns["res"] = $res;
        $this->assigns_layout["og_url"] = "http://dcamp.kr/lounge/comment/".$_id;
    }
    
    public function tv()
    {
        $this->layout = "";
        $users = $this->Entrance->list_('', '', '', 'date_out IS NULL and  date_in LIKE "'.date("Y-m-d").'%" GROUP BY m.id ');
        for($i=0; $i<sizeof($users); $i++) {
            $users[$i]["com"] = $this->Startup_member->get_by_user($users[$i]["id"]);
            $users[$i]["msg"] = "";
            $msg = $this->Board->list_(3, '', 1, 1, 'b.date_created like "'.date("Y-m-d").'%" and b.user_id = '.$users[$i]["user_id"]);
            $users[$i]["msg"] = $msg[0]["contents"];
        }
        // $event = $this->Event->list_(1, 100, 'e.picture IS NOT NULL and e.date <= "' .date("Y.m.d"). '" and e.date_e >= "' .date("Y.m.d"). '" and  open = 1 and e.state = 1', '', 'e.date DESC');
        
        $main = $this->Main->list_("", "type > 0 and type != 3 and type != 4");
        for ($m=0; $m<sizeof($main); $m++) {
            if ($main[$m]["type"] == 1) {
                $main[$m] = $this->Event->get_detail($main[$m]["cid"]);
                if ($main[$m]) {
                    $main[$m]["cat"] = "event";
                }
                else {
                    $main[$m]["cat"] = "";
                }
            }
            else if ($main[$m]["type"] == 2) {
                $main[$m] = $this->Notice->get_detail($main[$m]["cid"], 1);
                if ($main[$m]) {
                    $main[$m]["cat"] = "notice";
                }
                else {
                    $main[$m]["cat"] = "";
                }
            }
            else if ($main[$m]["type"] == 5) {
                $main[$m] = $this->Content->get($main[$m]["cid"]);
                if ($main[$m]) {
                    $main[$m]["cat"] = "content";
                }
                else {
                    $main[$m]["cat"] = "";
                }
            }
            else if ($main[$m]["type"] == 7) {
                $main[$m] = $this->Competitions->get($main[$m]["cid"]);
                if ($main[$m]) {
                    $main[$m]["cat"] = "competition";
                }
                else {
                    $main[$m]["cat"] = "";
                }
            }
            else if ($main[$m]["type"] == 8) {
                $main[$m] = $this->Office_hours->get($main[$m]["cid"]);
                $main[$m]["u"] = $this->Members->get($main[$m]["mid"]);
                if ($main[$m]) {
                    $main[$m]["cat"] = "office";
                }
                else {
                    $main[$m]["cat"] = "";
                }
            }
        }

        $this->assigns["users"] = $users;
        $this->assigns["event"] = $main;

        // write
        // $file = fopen("../tf_app/ext/tf_data.php","w+");
        // if(!$file) die("Cannot open the file.");
        // $msg = 193;
        // fwrite($file, $msg);
        // fclose($file);

        // read
        // $read = file("../tf_app/ext/tf_data.php");
        // echo $read[0];
    }

    public function calendar()
    {
//         require_once 'Google/Calendar.php';  
           
//         $entry = '<entry  
// xmlns="http://www.w3.org/2005/Atom"  
// xmlns:gd="http://schemas.google.com/g/2005">  
// <category  
// scheme="http://schemas.google.com/g/2005#kind"  
// term="http://schemas.google.com/g/2005#event">  
// </category>  
// <title type="text">일정제목</title>  
// <content type="text">내용</content>  
// <gd:where valueString="장소">  
// </gd:where>  
// <gd:when  
// startTime="시작시간"  
// endTime="끝나는시간">  
// <gd:reminder minutes="1" method="sms" />  
// </gd:when>  
// </entry>'
          
//         $service = new Google_Calendar;  
//         // if (!$service->requestClientLogin(본인의 구글아이디,비밀번호)) {  
//         //     exit("ClientLogin has failed\n".$service->getResponseBody());  
//         // }  
//         // if (!$service->insert($entry)) {  
//         //     exit("Inserting an entry has failed\n".$service->getResponseBody());  
//         // }
//         if (!$service->insert($entry, "http://www.google.com/calendar/feeds/[등록하고싶은 캘린더의 ID]/private/full")) {  
//             exit("Inserting an entry has failed\n".$service->getResponseBody());  
//         }

        // $client_id = '591777926178-kvdbu7llidjni1qvrpe330og3518hc9o.apps.googleusercontent.com';
        // $client_secret = '0e1332d5822ba7ba2005fb7667a4ae67f1a2856d';
        // $redirect_uri = 'http://localhost.me:8006/';

        // $cTitle = "캘린더등곡";

        // require_once('../tf_app/ext/google/Client.php');
        // require_once('../tf_app/ext/google/Service/Calendar.php');

        // $client = new Google_Client();
        // $client->setClientId($client_id);
        // $client->setClientSecret($client_secret);
        // $client->setRedirectUri($redirect_uri);
        // $client->setAccessType('offline');
        // $client->setApprovalPrompt('force');
        // $client->setScopes(array('https://www.googleapis.com/auth/calendar.readonly', 'https://www.googleapis.com/auth/calendar'));

        // $cal = new Google_Service_Calendar($client);

        // $calendarId = 'ko.south_korea#holiday@group.v.calendar.google.com'; //
        // $targetDate = '2015-03-18';
        // $tDate = new Google_Service_Calendar_EventDateTime();
        // $tDate->setDate($targetDate);
           
        // $body = new Google_Service_Calendar_Event();
        // $body->setSummary($cTitle);  // 일정 제목
        // $body->setStart($tDate); // 일정 시작
        // $body->setEnd($tDate); // 일정 종료
           
        // $cal->events->insert($calendarId, $body);


// step2
        // phpinfo();
        // exit(1);
        // error_reporting(E_ALL);
        // // require_once('../tf_app/ext/google/Client.php');
        // // require_once('../tf_app/ext/google/Service/Calendar.php');
        // require_once '../tf_app/ext/google/autoload.php';

        // $client_id = '591777926178-kvdbu7llidjni1qvrpe330og3518hc9o.apps.googleusercontent.com';
        // $client_secret = '0e1332d5822ba7ba2005fb7667a4ae67f1a2856d';
        // $redirect_uri = 'http://localhost.me:8006/';
        // $calendarId = 'ko.south_korea#holiday@group.v.calendar.google.com';

        // $client = new Google_Client();
        // $client->setClientId($client_id);
        // $client->setClientSecret($client_secret);
        // $client->setRedirectUri($redirect_uri);
        // $client->setAccessType('offline');
        // $client->setApprovalPrompt('force');
        // $client->setScopes(array('https://www.googleapis.com/auth/calendar.readonly', 'https://www.googleapis.com/auth/calendar'));
        // $cal = new Google_Service_Calendar($client);

        // $event = new Google_Service_Calendar_Event();
        // $event->setSummary('Appointment');
        // $event->setLocation('Somewhere');
        // $start = new Google_Service_Calendar_EventDateTime();
        // $start->setDateTime('2015-03-19T10:00:00.000-07:00');
        // $start->setTimeZone('America/Los_Angeles');
        // $event->setStart($start);
        // $end = new Google_Service_Calendar_EventDateTime();
        // $end->setDateTime('2011-06-03T10:25:00.000-07:00');
        // $end->setTimeZone('America/Los_Angeles');
        // $event->setEnd($end);
        // $event->setRecurrence(array('RRULE:FREQ=WEEKLY;UNTIL=20150319T170000Z'));
        // $attendee1 = new Google_Service_Calendar_EventAttendee();
        // $attendee1->setEmail('attendeeEmail');
        // // ...
        // $attendees = array($attendee1,
        //                    // ...
        //                    );
        // $event->attendees = $attendees;
        // // $recurringEvent = $cal->events->insert('primary', $event);
        // $recurringEvent = $cal->events->insert($calendarId, $event);

        // echo $recurringEvent->getId();

// step3
        
        // $this->tpl_name = "";
        // // require_once('../tf_app/ext/google/Client.php');
        // // require_once('../tf_app/ext/google/Service/Calendar.php');  
        // require_once '../tf_app/ext/google/autoload.php';
        // // require_once 'CalendarHelper.php';  
        // session_start(); 
        // $client = new Google_Client();
        // $client->setApplicationName("calendar-api-test");
        // // $client->setDeveloperKey("AIzaSyBBH88dIQPjcl5nIG-n1mmuQ12J7HThDBE");  
        // $client->setClientId('591777926178-kvdbu7llidjni1qvrpe330og3518hc9o.apps.googleusercontent.com');
        // $client->setClientSecret('0e1332d5822ba7ba2005fb7667a4ae67f1a2856d');
        // $client->setRedirectUri('http://localhost.me:8006/lounge/calendar');
        // $client->setAccessType('offline');   // Gets us our refreshtoken

        // $client->setScopes(array('https://www.googleapis.com/auth/calendar.readonly'));


        // //For loging out.
        // if (isset($_GET['logout'])) {
        //     unset($_SESSION['token']);
        // }


        // // Step 2: The user accepted your access now you need to exchange it.
        // if (isset($_GET['code'])) {
            
        //     $client->authenticate($_GET['code']);  
        //     $_SESSION['token'] = $client->getAccessToken();
        //     $redirect = 'http://localhost.me:8006/lounge/calendar';
        //     header('Location: ' . filter_var($redirect, FILTER_SANITIZE_URL));
        // }

        // // Step 1:  The user has not authenticated we give them a link to login    
        // if (!isset($_SESSION['token'])) {

        //     $authUrl = $client->createAuthUrl();

        //     print "<a class='login' href='$authUrl'>Connect Me!</a>";
        // }    
        // // Step 3: We have access we can now create our service
        // if (isset($_SESSION['token'])) {
        //     $client->setAccessToken($_SESSION['token']);
        //     print "<a class='logout' href='".$_SERVER['PHP_SELF']."?logout=1'>LogOut</a><br>";  
            
        //     $service = new Google_Service_Calendar($client);    
            
        //     $calendarList  = $service->calendarList->listCalendarList();;
        //     print_r($calendarList);
        //     while(true) {
        //         foreach ($calendarList->getItems() as $calendarListEntry) {
        //             echo $calendarListEntry->getSummary()."<br>\n";
        //         }
        //         $pageToken = $calendarList->getNextPageToken();
        //         if ($pageToken) {
        //             $optParams = array('pageToken' => $pageToken);
        //             $calendarList = $service->calendarList->listCalendarList($optParams);
        //         } else {
        //             break;
        //         }
        //     }
        // }


// step4
        // If you've used composer to include the library, remove the following line
        // and make sure to follow the standard composer autoloading.
        // https://getcomposer.org/doc/01-basic-usage.md#autoloading
        require_once '../tf_app/ext/google/autoload.php';

        // $client = new Google_Client();
        // // OAuth2 client ID and secret can be found in the Google Developers Console.
        // $client->setClientId('591777926178-kvdbu7llidjni1qvrpe330og3518hc9o.apps.googleusercontent.com');
        // $client->setClientSecret('0e1332d5822ba7ba2005fb7667a4ae67f1a2856d');
        // $client->setRedirectUri('http://localhost.me:8006/lounge/calendar');
        // $client->addScope('https://www.googleapis.com/auth/calendar');

        // $service = new Google_Service_Calendar($client);

        // $authUrl = $client->createAuthUrl();

        // //Request authorization
        // print "Please visit:\n$authUrl\n\n";
        // print "Please enter the auth code:\n";
        // $authCode = trim(fgets(STDIN));

        // // Exchange authorization code for access token
        // $accessToken = $client->authenticate($authCode);
        // $client->setAccessToken($accessToken);


// step5
        // Service Account info
        $client_id = '591777926178-kvdbu7llidjni1qvrpe330og3518hc9o.apps.googleusercontent.com';
        $service_account_name = '591777926178-kvdbu7llidjni1qvrpe330og3518hc9o@developer.gserviceaccount.com';
        $key_file_location = '../tf_app/ext/calendar-api-test-826600ed61c3.p12';

        // Calendar id
        $calName = 'violet8372@gmail.com';


        $client = new Google_Client();
        $client->setApplicationName("Calendar test");

        $service = new Google_Service_Calendar($client);

        $key = file_get_contents($key_file_location);
        $cred = new Google_Auth_AssertionCredentials(
         $service_account_name,
         array('https://www.googleapis.com/auth/calendar.readonly'),
         $key
        );

        $client->setAssertionCredentials($cred);

        $cals = $service->calendarList->listCalendarList();
        print_r($cals);
        //exit;

        // // Convert recurring events to single events
        // // Look for events in the next week - now to now+1week
        // $params = array(
        //  'singleEvents' => TRUE,
        //  'timeMin' => (new DateTime())->format(DateTime::RFC3339),
        //  'timeMax' => (new DateTime())->add(new DateInterval('P1W'))->format(DateTime::RFC3339),
        // );
        // $events = $service->events->listEvents($calName, $params);

        // foreach ($events->getItems() as $event) {
        //  echo "Summary:  ", $event->getSummary(), "\n";
        //  echo "Location: ", $event->getLocation(), "\n";
        //  echo "Start:    ", fmt_gdate($event->getStart()), "\n";
        //  echo "End:      ", fmt_gdate($event->getEnd()), "\n";
        // }

        // function fmt_gdate( $gdate ) {
        //   if ($val = $gdate->getDateTime()) {
        //     return (new DateTime($val))->format( 'd/m/Y H:i' );
        //   } else if ($val = $gdate->getDate()) {
        //     return (new DateTime($val))->format( 'd/m/Y' ) . ' (all day)';
        //   }
        // }

        $calendar = new Google_Service_Calendar_Calendar();
        $calendar->setSummary('calendarSummary');
        $calendar->setTimeZone('America/Los_Angeles');

        $createdCalendar = $service->calendars->insert($calendar);

        echo $createdCalendar->getId();
    }
}
?>
