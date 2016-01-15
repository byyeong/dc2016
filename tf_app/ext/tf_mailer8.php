<?

    class TF_mailer
    {
        var $mailto;
        var $subject;
        var $content;
        var $sender_name = "";
        var $sender_address;
        var $sender_password;
        var $port = 25;
        var $server;
        var $sender_user;
        var $assigns = array();
        var $tpl_name;

        public function TF_mailer($setting)
        {
            $this->settings = $setting;
        }
        
                
        function send()
        {
            if ($this->tpl_name)
            {

                include_once '../tf_app/template_/Template_.class.php';
    
                $tpl = new Template_;
                $tpl->define('mail', 'views/mail/'.$this->tpl_name.'.tpl');
                
                $tpl->assign($this->assigns);
                $this->content = $tpl->fetch('mail');
                
            }
            
            
            /*
            $subject=iconv("UTF-8", "EUC-KR", $subject);
            $content=iconv("UTF-8", "EUC-KR", $content);
            */
            

            if (!$this->sender_name)
            {
                $this->sender_name = $this->settings->sender_name;
            }

            if (!$this->sender_password)
            {
                $this->sender_password = $this->settings->sender_password;
            }

            // if (!$this->mailto)
            // {
            //     $this->mailto = $this->settings->mailto;
            // }

            if (!$this->server)
            {
                $this->server = $this->settings->server;
            }

            if (!$this->sender_user)
            {
                $this->sender_user = $this->settings->sender_user;
            }

            if (!$this->sender_address)
            {
                $this->sender_address = $this->settings->sender_address;
            }

            if ($this->mailto) {
                require_once '../tf_app/ext/phpmailer/class.phpmailer.php';
                $mail = new PHPMailer();
                $mail->IsSMTP();
                $mail->SMTPAuth = true;
                $mail->SMTPSecure = 'ssl';
                $mail->Host = $this->server;
                $mail->Port = 465;
                $mail->Username = $this->sender_user;
                $mail->Password = $this->sender_password;
                $mail->From = $this->sender_address;
                $mail->FromName = $this->sender_name;
                $mail->Subject = $this->subject;
                $mail->Body = $this->content;
                $mail->AddAddress($this->mailto);
                $mail->Send();
                
                $mail_log = load_model("Members");
                $mail_log->log_mail($this->mailto, $this->tpl_name, $this->content);
            }
                
        }
                 
    }
    
?>
