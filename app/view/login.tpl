<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Sign Up</title>
  <link href="<?= BASE_URL ?>/public/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Chewy|Raleway" rel="stylesheet">

  <!-- Custom styles for this template -->
  <!--   <link href="css/navbar-top-fixed.css" rel="stylesheet"> -->
</head>

<body>
  <!-- This is the Navbar copy this-->
  <div class="pos-f-t">
    <div class="collapse" id="navbar-header">

      <div class="container-fluid bg-inverse p-a-1">
      </div>
    </div>
    <div class="navbar navbar-light navbar-static-top">
      <img src="<?= BASE_URL ?>/public/media/marma.png" alt="icon" style="width:40px;height:40px;" id="logo">
      <div class="collapse navbar-toggleable-sm pull-sm-right" id="navbar-header">
        <ul class="nav navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="<?= BASE_URL ?>">Today's Theme</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<?= BASE_URL ?>/vote/">Vote</a>
            </li>
           <li class="nav-item">
             <a  class="nav-link" href="<?= BASE_URL ?>/about/">About</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="<?= BASE_URL ?>/upload/">Upload</a>
           </li>
           <li class="nav-item">
             <a class="nav-link"  href="<?= BASE_URL ?>/pastwinners/">Past Winners</a>
           </li>
           <li class="nav-item">
             <a class="nav-link"  href="<?= BASE_URL ?>/standings/">Standings</a>
           </li>
           <li class="nav-item">
             <a class="nav-link"  href="<?= BASE_URL ?>/account/">Your Account</a>
           </li>
        </ul>
      </div>
    </div>
  </div>
  <!-- End of navbar code-->


  <div class="container">
    <div class="jumbotron">
      <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info" >
          <div class="panel-heading">

         <span id="error">
			<?php
				if(isset($_SESSION['error']))
				{
					if($_SESSION['error'] != '')
					{
                        echo '<div class="alert alert-danger" role="alert">'.$_SESSION["error"].'</div>';
                        $_SESSION['error'] = '';
					}
				}
			?>
		</span>

            <div class="panel-title">Sign In</div>
            <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot password?</a></div>
          </div>

          <div style="padding-top:30px" class="panel-body" >

            <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>


            <form id="loginform" method="POST" action="<?= BASE_URL ?>/postlogin" class="form-horizontal" role="form">

              <div style="margin-bottom: 25px" class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                <input id="login-username" name="username" type="text" class="form-control" name="username" value="" placeholder="username or email">
              </div>

              <div style="margin-bottom: 25px" class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                <input id="login-password" name="password" type="password" class="form-control" name="password" placeholder="password">
              </div>



              <div class="input-group">
                <div class="checkbox">
                  <label>
                    <input id="login-remember" type="checkbox" name="remember" value="1"> Remember me
                  </label>
                </div>
              </div>


              <div style="margin-top:10px" class="form-group">
                <!-- Button -->

                <div class="col-sm-12 controls">
            		<input id="btn-login" class ="btn btn-success" type="submit" value="Log In" name="submit"/>
            	</div>

                <!-- <div class="col-sm-12 controls">
                  <a id="btn-login" href="#" class="btn btn-success">Login  </a>

                </div> -->
              </div>


              <div class="form-group">
                <div class="col-md-12 control">
                  <div style="padding-top:15px; font-size:85%" >
                    Don't have an account!
                    <a href="<?= BASE_URL ?>/signup/">
                      Sign Up Here
                    </a>
                  </div>
                </div>
              </div>
            </form>



          </div>
        </div>
      </div>
    </div>
  </div>



  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
  <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
  <script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
  <script src="https://use.fontawesome.com/625f8d2098.js"></script>

  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
