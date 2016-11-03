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
		}
	}

    public function home() {
		self::loggedInCheck();

    	$pageTitle = 'Spot of the Day';

		//Yesterday's winner & picture
		$yesterdays_winner = Picture::getYesterdayWinner();
		$yesterday  = $yesterdays_winner->get('username');
		$yesterday_pic = $yesterdays_winner->get('file');

		//Yesterday's theme
		$yesterdays_date = date("Y-m-d", time() - 60*60*24);
		$yesterdays_theme = DateTheme::getTheme($yesterdays_date)->get('theme');

		//Today's theme
		$todays_date = date("Y-m-d");
		$theme = DateTheme::getTheme($todays_date)->get('theme');

		include_once SYSTEM_PATH.'/view/spotoftheday.tpl';
    }

	public function vote(){
		self::loggedInCheck();

		$pageTitle = 'Vote';

		$todays_entries = Picture::getAllToday();
		shuffle($todays_entries);

		//need to get which photos the user voted on
		$user_row = User::loadByUsername($_SESSION['username']);
		$username = $user_row->get('username');
		$voted = UserVote::getAllByUser($username);

		$votes = array(); //array of picids that the user voted for
		foreach($voted as $vote){
			array_push($votes, $vote->get('picid'));
		}

		include_once SYSTEM_PATH.'/view/vote.tpl';
	}

	public function about(){
		self::loggedInCheck();
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
            $theme = DateTheme::getTheme($today)->get('theme');
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

		header('Location: '.BASE_URL.'/vote');
	}

	public function logout(){
		// erase the session
		unset($_SESSION['username']);
		session_destroy();

		// redirect to home page
		header('Location: '.BASE_URL);
	}

	public function uploadsave(){
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
}
