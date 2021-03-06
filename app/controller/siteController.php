<?php

include_once '../global.php';
include_once 'class.phpmailer.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a SiteController and route it
$sc = new SiteController();
$sc->route($action);

class SiteController {

	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'home':
				$this->home();
				break;
			case 'vote':
				$this->vote();
				break;
			case 'about':
				$this->about();
				break;
			case 'upload':
				$this->upload();
				break;
			case 'pastwinners':
				$this->pastwinners();
				break;
			case 'standings':
				$this->standings();
				break;
			case 'signupRegister':
				$this->signupRegister();
			break;
			case 'account':
				$this->account();
				break;
			case 'signup':
				$this->signup();
				break;
			case 'login':
				$this->login();
				break;
			case 'postlogin':
				$this->postlogin();
				break;
			case 'forgotpassword':
				$this->forgotpassword();
				break;
			case 'votedelete':
				$this->votedelete();
				break;
			case 'votesave':
				$this->votesave();
				break;
			case 'logout':
				$this->logout();
				break;
			case 'uploadsave':
				$this->uploadsave();
				break;
			case 'uploaddelete':
				$this->uploaddelete();
				break;
			case 'postvote':
				$this->postvote();
				break;
			case 'admindelete':
				$this->admindelete();
				break;
			case 'postpassword':
				$this->postpassword();
				break;
		}
	}

    public function home() {
		self::loggedInCheck();

		$pageTitle = 'Spot of the Day';

		//Yesterday's winner & picture
		$yesterdays_winner = Picture::getYesterdayWinner();
		if(!is_null($yesterdays_winner)){
			$yesterday  = $yesterdays_winner->get('username');
			$yesterday_pic = $yesterdays_winner->get('file');
		}
		else{

			$yesterday = 'No winner';
			$yesterday_pic = null;
			$yesterday = null;
		}
		//Yesterday's theme
		$yesterdays_date = date("Y-m-d", time() - 60*60*24);
		if(!is_null(DateTheme::getTheme($yesterdays_date))){
		$yesterdays_theme = DateTheme::getTheme($yesterdays_date)->get('theme');
	}
	else{
		$yesterdays_theme = 'No Theme';
	}

		//Today's theme
		$todays_date = date("Y-m-d");
		$theme_row = DateTheme::getTheme($todays_date);
		if($theme_row != null){
			$theme = $theme_row->get('theme');
		}
		else{
			$theme = null;
		}

		include_once SYSTEM_PATH.'/view/spotoftheday.tpl';
	}

	public function postpassword(){
		$email = $_POST['email'];
		$user = User::loadByEmail($email);

		if ($user != null){
			$username = $user->get('username');
			$pw = $user->get('password');

			//Email user their username & password
			$mail = new PHPMailer;
			$mail->setFrom('marmalappic@gmail.com', 'Marmalappic');
			$mail->addAddress($email, $username);
			$mail->Subject  = 'Marmalappic Account Information';
			$mail->Body     = 'Your username: '.$username."\r\n".'Your password: '.$pw;
			if(!$mail->send()) {
			    $_SESSION['error'] = "There was an error when attempting to email your password.<br>
			  			            Please feel free to email us at marmalappic@gmail.com for assistance.";
			} else {
				$_SESSION['info'] = "An email has been sent with your password.";
			}
			header('Location: '.BASE_URL.'/login');
		} else {
			$_SESSION['error'] = "We do not have an account associated with this email.";
			header('Location: '.BASE_URL.'/forgotpassword');
		}
	}

	public function vote(){
		self::loggedInCheck();

		$pageTitle = 'Vote';

		//check if user uploaded a photo todays_entries
		$user = $_SESSION['username'];
		$today = date("Y-m-d", time());
		$picture_row = Picture::getPicByUserAndDate($user, $today);
		$hide = false;
		if($picture_row == null){
			$hide = true;
		}

		$todays_entries = Picture::getAllToday();
		if ($todays_entries != null) shuffle($todays_entries);

		//need to get which photos the user voted on
		$user_row = User::loadByUsername($_SESSION['username']);
		$username = $user_row->get('username');

		//Get the user's teammates
		$teammate_rows = User::getTeamMembers($user_row->get('teamname'));
		$teammates = [];
		if($teammate_rows != null){
			foreach($teammate_rows as $team){
				$teammates[] = $team->get('username');
			}
		}

		$voted = UserVote::getAllByUser($username);
		$votes = []; //array of picids that the user voted for
		if($voted != null){
			foreach($voted as $vote){
				$votes[] = $vote->get('picid');
			}
		}
		$flagged = UserFlag::getAllByUser($username);
		$flags = []; //array of picids that the user voted for
		if($flagged != null){
			foreach($flagged as $flag){
				$flags[] = $flag->get('picid');
			}
		}

		include_once SYSTEM_PATH.'/view/vote.tpl';
	}

	public function postvote(){
		$flagged = $_POST['picid'];
		$username = $_SESSION['username'];

		//Show user that they have already flagged this photo
		$user = new UserFlag();
		$user->set('picid', $flagged);
		$user->set('username', $username);
		$user->save();

		//incremement flagged count
		$picture = Picture::loadById($flagged);
		$picture->incFlags();

		// send email
		$mail = new PHPMailer;
		$mail->setFrom('marmalappic@gmail.com', 'Marmalappic');
		$mail->addAddress('marmalappic@gmail.com');
		$mail->Subject  = 'Flagged Photo Alert';
		$mail->Body     = 'The photo with id '.$flagged.' has been reported as inappropriate by '.$username.'.';
		$mail->send();
		header('Location: '.BASE_URL.'/vote');
	}

	public function about(){
		include_once SYSTEM_PATH.'/view/about.tpl';
	}

	public function upload(){
		self::loggedInCheck();
        $user = $_SESSION['username'];
        $today = date("Y-m-d", time());
        $pic = "/public/media/upload.jpeg";
        $uploaded = false;

        //check if user already uploaded photo, if so, display it
        $result = Picture::getPicByUserAndDate($user, $today);
        if($result != null){
            $pic = $result->get('file');
            $uploaded = true;
            $theme_row = DateTheme::getTheme($today);
			if($theme_row != null) $theme = $theme_row->get('theme');
        }

		include_once SYSTEM_PATH.'/view/upload.tpl';
	}

	public function pastwinners(){
		self::loggedInCheck();
		$winners = Picture::getAllWinningExceptToday();

		include_once SYSTEM_PATH.'/view/pastwinners.tpl';
	}

	public function standings(){
		self::loggedInCheck();
		$teams = Team::getAllDescScore();
		include_once SYSTEM_PATH.'/view/standings.tpl';
	}

	public function account(){
		self::loggedInCheck();

		//get username
		$user_row = User::loadByUsername($_SESSION['username']);
		$username = $user_row->get('username');

		//get all images uploaded
		$pix = Picture::getAllByUser($username);
		$overall_score = $user_row->get('score');
		include_once SYSTEM_PATH.'/view/account.tpl';
	}

	public function signup(){
		$teams = Team::getAllTeams();
		include_once SYSTEM_PATH.'/view/signup.tpl';
	}

	public function login(){
		include_once SYSTEM_PATH.'/view/login.tpl';
	}

	public function forgotpassword(){
		//$_SESSION['info'] = "If you've forgotten your password, send an email to <b>marmalappic@gmail.com</b> using the email associated with your Marmalappic account.<br>We'll get back to you as soon as we can!";
		//header('Location: '.BASE_URL.'/login');

		include_once SYSTEM_PATH.'/view/forgotpassword.tpl';
	}

	public function postlogin(){
	 	$un = $_POST['username'];
		$pw = $_POST['password'];
		$user = User::loadByUsername($un);
		if($user == null) {
			// username not found
			$_SESSION['error'] = "<b>Uh oh!</b> Username <u>".$un."</u> not found!";
			header('Location: '.BASE_URL.'/login');
		} // incorrect password
		elseif($user->get('password') != $pw)
		{
			$_SESSION['error'] = "<b>Uh oh!</b> Incorrect password for username <u>".$un."</u>";
			header('Location: '.BASE_URL.'/login');
		}
		else
		{
			$_SESSION['username'] = $un;
			$_SESSION['success'] = "Welcome back, <u>".$un."</u>!";
			header('Location: '.BASE_URL);
		}
	}

	private function loggedInCheck(){
		//checks if user  is logged in
		// if not redirects to sign up page
		if( !isset($_SESSION['username']) || $_SESSION['username'] == '')
		{
			header('Location: '.BASE_URL.'/login');
		}
		else
		{
			$user = User::loadByUsername($_SESSION['username']);
			$userName = $user->get('username');
		}
	}

	public function votedelete(){
		//variables from page
		$username = $_SESSION['username'];
		$picid = $_POST['picid'];

		$row = UserVote::getRow($username, $picid);
		$row->delete();


		$picture = Picture::loadById($picid);
		$picture->decVotes();

		header('Location: '.BASE_URL.'/vote');
	}

	public function votesave(){
		//variables from page
		$username = $_SESSION['username'];
		$picid = $_POST['picid'];

		$user = new UserVote();
		$user->set('picid', $picid);
		$user->set('username', $username);
		$user->save();

		$picture = Picture::loadById($picid);
		$picture->incVotes();

		header('Location: '.BASE_URL.'/vote');
	}

	public function logout(){
		// erase the session
		unset($_SESSION['username']);
		session_destroy();

		// redirect to home page
		header('Location: '.BASE_URL);
	}

	public function uploaddelete(){
		$user = $_SESSION['username'];
		$today = date("Y-m-d");
		$current_pic = Picture::getPicByUserAndDate($user, $today);
		if($current_pic != null){
			$numvotes = $current_pic->get('numvotes');
			User::removePicFromScore($user, $numvotes);
			$current_pic->delete();
		}
		$uploaded = false;
		header('Location: '.BASE_URL.'/upload');
	}

	public function uploadsave(){
		$user = $_SESSION['username'];
		$today = date("Y-m-d");
		$current_pic = Picture::getPicByUserAndDate($user, $today);

		if(isset($_FILES['image'])){
		      $errors= array();
		      $file_name = $_FILES['image']['name'];
		      $file_size = $_FILES['image']['size'];
		      $file_tmp  = $_FILES['image']['tmp_name'];
		      $file_type = $_FILES['image']['type'];
			  $file_error= $_FILES['image']['error'];

			  $file_ext=strtolower(end(explode('.',$_FILES['image']['name'])));

			  $allowed_extensions = array("jpeg","jpg","png");

			  //there was a problem uploading the file
			  if ($file_error !== UPLOAD_ERR_OK) {
				     $error = self::getPictureUploadError($file_error);
					 $_SESSION['error'] = "<b>Uh oh!</b> There was an error uploading your image: ".$error;
 					 header('Location: '.BASE_URL.'/upload');
			  }

			  //make sure user uploaded the correct file extension
		      else if(in_array($file_ext, $allowed_extensions) === false){
				 $_SESSION['error'] = "<b>Uh oh!</b> <i>.".$file_ext."</i> files are not allowed, please choose a JPEG or PNG file.";
				 header('Location: '.BASE_URL.'/upload');
		      }

			  //attempt to store the image in the file system
		      else if (empty($errors) == true){
				 $marmalappic = realpath(dirname(dirname(getcwd())));

				 //Path on local system (CHANGE IF HOST CHANGES)
				 $path = $marmalappic."\\public\\media\\user_uploads\\".$file_name;

				 //check if file name already exists
				 if(file_exists($path)){
					 $_SESSION['error'] = "File with that name already exists. Please rename your file and resubmit.";
					 header('Location: '.BASE_URL.'/upload');
					 exit();
				 }

		         move_uploaded_file($file_tmp,$path);
				 self::image_fix_orientation($path);
		         $_SESSION['success'] = "<b>Success!</b> Your picture has been uploaded.";

				  //ADD TO DATABASE
				  $picture = new Picture();
				  $picture->set('username', $_SESSION['username']);
				  $picture->set('numvotes', 0);
				  $picture->set('numflags', 0);
				  $picture->set('date', date("Y-m-d"));
				  $picture->set('isWinner', 0);
				  $picture->set('file', "/public/media/user_uploads/".$file_name);
				  $picture->save();

				  header('Location: '.BASE_URL.'/upload');
		      }
              //There's an error with the file system.
			  else{
				 $_SESSION['error'] = "<b>FILE SYSTEM ERROR</b> Could not save the image.";
				 header('Location: '.BASE_URL.'/upload');
		      }
		   }
	}

	function image_fix_orientation($path)
	{
	    $image = imagecreatefromjpeg($path);
	    $exif = exif_read_data($path);

	    if (empty($exif['Orientation']))
	    {
	        return false;
	    }

	    switch ($exif['Orientation'])
	    {
	        case 3:
	            $image = imagerotate($image, 180, 0);
	            break;
	        case 6:
	            $image = imagerotate($image, - 90, 0);
	            break;
	        case 8:
	            $image = imagerotate($image, 90, 0);
	            break;
	    }

	    imagejpeg($image, $path);

	    return true;
	}

	private function getPictureUploadError($code)
    {
        switch ($code) {
            case UPLOAD_ERR_INI_SIZE:
                //The uploaded file exceeds the upload_max_filesize directive in php.ini (default 2MB)
				$message = "The uploaded file exceeds the maximum file size of 2MB.";
                break;
            case UPLOAD_ERR_FORM_SIZE:
                //The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form (default 2MB)
				$message = "The uploaded file exceeds the maximum file size of 2MB.";
                break;
            case UPLOAD_ERR_PARTIAL:
                $message = "The uploaded file was only partially uploaded.";
                break;
            case UPLOAD_ERR_NO_FILE:
                $message = "No file was uploaded.";
                break;
            case UPLOAD_ERR_NO_TMP_DIR:
                $message = "Missing a temporary folder.";
                break;
            case UPLOAD_ERR_CANT_WRITE:
                $message = "Failed to write file to disk.";
                break;
            case UPLOAD_ERR_EXTENSION:
                $message = "File upload stopped by extension.";
                break;
            default:
                $message = "Unknown upload error.";
                break;
        }
        return $message;
    }


	public function signupRegister() {
		// get post data
		$username  = $_POST['username'];
		$teamname = $_POST['nteams'];
		$passwd = $_POST['passwd'];
		$email  = $_POST['email'];

		// do some simple form validation

		// are all the required fields filled?
		if ($username == '' || $teamname == '' || $passwd == '' || $email == '') {
			// missing form data; send us back
			$_SESSION['error'] = 'Please complete all registration fields.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		if(strlen($username) > 25){
			$_SESSION['error'] = 'Sorry, that username is too long.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		if(strlen($passwd) > 30){
			$_SESSION['error'] = 'Sorry, that password is too long.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		if(strlen($email) > 100){
			$_SESSION['error'] = 'Sorry, that email is too long.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		if(preg_match('/[^A-Za-z0-9]/', $username)){
			$_SESSION['error'] = 'Sorry, that username contains invalid characters';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		if(preg_match('/[^A-Za-z0-9@._]/', $email)){
			$_SESSION['error'] = 'Sorry, that email contains invalid characters';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}

		// is username in use?
		$user = User::loadByUsername($username);
		if(!is_null($user)) {
			// username already in use; send us back
			$_SESSION['error'] = 'Sorry, that username is already in use. Please pick a unique one.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		$user = User::loadByEmail($email);
		if(!is_null($user)) {
			// email is in use
			$_SESSION['error'] = 'Sorry, that email is already in use. Please pick a different one.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		$allowed_domains = array("vt.edu");
		$array_pid = explode("@", $email);
		$first = array_shift($array_pid);
		$email_domain = array_pop(explode("@", $email));
		if(!in_array($email_domain, $allowed_domains)) {
    	// Not an authorised email
			$_SESSION['error'] = 'Sorry, that email is not a vt.edu email';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}
		if(is_null($first) || preg_match('/[^A-Za-z0-9._]/', $first)) {
    	// Not an authorised email
			$_SESSION['error'] = 'Sorry, that email is not a valid email';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}

		//add member to team
		Team::incMemberCount($teamname);

		// okay, let's register
		$user = new User();
		$user->set('username', $username);
		$user->set('teamname', $teamname);
		$user->set('password', $passwd);
		$user->set('email', $email);
		$user->save(); // save to db

		// log in this freshly created user and redirect to home page
		$_SESSION['username'] = $username;
		$_SESSION['success'] = "You successfully registered as ".$username.".";
		header('Location: '.BASE_URL);
		exit();
	}

	public function admindelete(){
		$user = $_POST['username'];
		$picid = $_POST['picid'];

		$today = date("Y-m-d");
		$current_pic = Picture::getPicByUserAndDate($user, $today);
		if($current_pic != null){
			$numvotes = $current_pic->get('numvotes');
			User::removePicFromScore($user, $numvotes);
			$current_pic->delete();
		}
		header('Location: '.BASE_URL.'/vote');
	}
}
