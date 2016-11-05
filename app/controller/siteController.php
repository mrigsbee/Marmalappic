<?php

include_once '../global.php';

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
			$yesterday = null;
		}
		//Yesterday's theme
		$yesterdays_date = date("Y-m-d", time() - 60*60*24);
		if(!is_null(DateTheme::getTheme($yesterdays_date))){
			$yesterdays_theme = DateTheme::getTheme($yesterdays_date)->get('theme');
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
		shuffle($todays_entries);

		//need to get which photos the user voted on
		$user_row = User::loadByUsername($_SESSION['username']);
		$username = $user_row->get('username');

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

		$msg = "The photo with id ".$flagged." has been reported as inappropriate by ".$username.".";

		//variables from page
		$user = new UserFlag();
		$user->set('picid', $flagged);
		$user->set('username', $username);
		$user->save();

		//incremement flagged count
		$picture = Picture::loadById($flagged);
		$picture->incFlags();

		// send email
		//mail("EMAIL ADDRESS GOES HERE","Marmalappic Flagged Photo",$msg);

		header('Location: '.BASE_URL.'/vote');
	}

	public function about(){
		include_once SYSTEM_PATH.'/view/about.tpl';
	}

	public function upload(){
		self::loggedInCheck();
        $user = $_SESSION['username'];
        $today = date("Y-m-d", time());
        $pic = "/public/media/garden.jpg";
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
		$winners = Picture::getAllWinning();
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
		$overall_score = User::score($pix);
		include_once SYSTEM_PATH.'/view/account.tpl';
	}

	public function signup(){
		include_once SYSTEM_PATH.'/view/signup.tpl';
	}

	public function login(){
		include_once SYSTEM_PATH.'/view/login.tpl';
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

			  //check that the image isn't too large
		      else if($file_size > 2097152){
				 $_SESSION['error'] = "<b>Uh oh!</b> File size must be less than 2 MB";
				 header('Location: '.BASE_URL.'/upload');
		      }

			  //attempt to store the image in the file system
		      else if (empty($errors) == true){
				 $marmalappic = realpath(dirname(dirname(getcwd())));

				 //Path on local system (CHANGE IF HOST CHANGES)
				 $path = $marmalappic."\\public\\media\\user_uploads\\".$file_name;
		         move_uploaded_file($file_tmp,$path);
		         $_SESSION['success'] = "<b>Success!</b> Your picture has been uploaded.";

				  //delete existing upload if exists
		  	      if($current_pic != null){
		  			  $current_pic->delete();
		  		  }

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

	private function getPictureUploadError($code)
    {
        switch ($code) {
            case UPLOAD_ERR_INI_SIZE:
                //$message = "The uploaded file exceeds the upload_max_filesize directive in php.ini";
				$message = "The uploaded file exceeds the maximum file size.";
                break;
            case UPLOAD_ERR_FORM_SIZE:
                // $message = "The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form";
				$message = "The uploaded file exceeds the maximum file size.";
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
		$teamname = $_POST['teamname'];
		$passwd = $_POST['passwd'];
		$email  = $_POST['email'];

		// do some simple form validation

		// are all the required fields filled?
		if ($username == '' || $teamname == '' || $passwd == '' || $email == '') {
			// missing form data; send us back
			$_SESSION['registerError'] = 'Please complete all registration fields.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}

		// is username in use?
		$user = User::loadByUsername($username);
		if(!is_null($user)) {
			// username already in use; send us back
			$_SESSION['registerError'] = 'Sorry, that username is already in use. Please pick a unique one.';
			header('Location: '.BASE_URL.'/signup');
			exit();
		}

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
}
