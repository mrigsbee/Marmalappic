<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Login</title>
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
       <img src="<?= BASE_URL ?>/public/media/applogo.png" alt="icon" class="applogo">
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
    </div>

          <div style="padding-top:30px" class="panel-body" >

              <h5> Enter your email: </h5>

            <form id="loginform" method="POST" action="<?= BASE_URL ?>/postpassword" class="form-horizontal" role="form">

              <div style="margin-bottom: 25px" class="input-group">
                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                <input  name="email" type="text" class="form-control" name="username" value="" placeholder="email">
              </div>

              <div style="margin-top:10px" class="form-group">
                <!-- Button -->
                <div class="col-sm-12 controls">
            		<input id="btn-login" class ="btn btn-success" type="submit" value="Email me my password" name="submit"/>
            	</div>

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
  <script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
  <script src="https://use.fontawesome.com/625f8d2098.js"></script>

</body>
</html>
