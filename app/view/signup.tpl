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
    <div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
      <div class="panel panel-info">
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
        <div class="panel-title">Sign Up</div>
        <div style="float:right; font-size: 85%; position: relative; top:-10px"><a id="signinlink" href="<?= BASE_URL ?>/login/">Sign In</a></div>
      </div>
      <div class="panel-body" >
        <form id="signupform" method="POST" class="form-horizontal" role="form" action="<?php echo BASE_URL.'/signup/register'; ?>">

          <div id="signupalert" style="display:none" class="alert alert-danger" >
            <p>Error:</p>
            <span></span>
          </div>


          <?php
          $fullteams = 0;
          foreach($teams as $team){
              $count = $team->get('membercount');
              if($count == 6){
                $fullteams++;
              }
          }

          //only show form if there are available teams to join
          if ($fullteams < 5){
          echo '
          <div class="form-group">
            <label for="username" class="col-md-3 control-label">Username</label>
            <div class="col-md-9">
              <input type="text" class="form-control" name="username" placeholder="Username">
            </div>
          </div>
          <div class="form-group">
            <label for="email" class="col-md-3 control-label">Email</label>
            <div class="col-md-9">
              <input type="text" class="form-control" name="email" placeholder="Email Address">
            </div>
          </div>
          <div class="form-group">
            <label for="password" class="col-md-3 control-label">Password</label>
            <div class="col-md-9">
              <input type="password" class="form-control" name="passwd" placeholder="Password">
            </div>
          </div>
          <div class="funkyradio">';

          foreach($teams as $team){
              $count = $team->get('membercount');

              if($count < 6){

                $name = $team->get('teamname');

                echo '<div class="funkyradio-success">';
                echo "<input type='radio' name='nteams' id='$name' value='$name' />";
                echo "<label for='$name'>$name</label>";
                echo '</div>';
              }
          }

        echo '</div>

          <!-- submit form -->
          <div class="form-group">
            <div class="col-md-offset-3 col-md-9">
              <button id="btn-signup" type="submit" class="btn btn-info"><i class="icon-hand-right"></i>Sign Up</button>
            </div>
          </div>

          <div style="padding-top:20px"  class="form-group">

          </div>';

        //all the teams are full, show this message instead of form
        } else {
          echo '<br><br><h2>Sorry, all teams are currently full.</h2>';
        }
        ?>

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
