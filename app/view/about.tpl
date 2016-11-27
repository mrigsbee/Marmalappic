<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>About</title>
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
      <br>
      <h1>About</h1>
      <hr>
      <br>
      <div id ="summary">
          <h4 style="color:blue">The competition will be held Tuesday, November 29, 2016 to Saturday, December 3, 2016.</h4>
          <br><br>

          <h2> What is Marmalappic? </h2>
          <p>
            In a fun attempt to help students get more acquainted with both their campus and the greater
            Blacksburg area, this game encourages students to participate in this competition to think
            creatively and have fun with their fellow Hokies.
            <br>
            A win-win, our mission is to help keep the community strong!
          </p>
          <br>
          <h2> How do I participate? </h2>
          <p>
            Make your account on our sign up page. Join a team with old friends or make some new ones!<br>
            Each day during the competition, there will be a theme posted on the front page.<br>
            Take a photo that you think best captures that theme and upload it to our website.<br>
            Once you've uploaded your photo, check out photos your fellow Hokies have submitted and vote for your favorites.<br>
            Check back the next day to see if your photo won!<br>
          </p>
          <br>
          <h2> What do I get for participating? </h2>
          <p>
              The team with the most points by <b>Sunday, December 4,2016</b> will win a <b style="color:blue">CASH PRIZE!!</b><br>
          </p>
      </div>
    </div>
  </div>


  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
  <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
  <script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
