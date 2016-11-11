<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Your Account</title>
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
        <br>
        <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-4">
              <?php
                  $team = $user_row->get('teamname');

                  echo "<h1>$username</h1>";
                  echo "<h6>Team $team</h6>"
              ?>
          </div>
          <div class="col-md-2"></div>
          <div class="col-md-2">
              <form action="<?= BASE_URL ?>/logout">
                  <button type="submit" class="btn btn-success">
                    <i class="fa fa-sign-out" aria-hidden="true"></i> logout
                  </button>
              </form>
          </div>
        </div>
      <br>
      <hr>
      <br>
      <div class="account">
        <div class="yourJar col-md-8">
            <?php
                echo "<h3>You have $overall_score Jars of Marmalade</h3>";
            ?>
          <div class="myPic">
            <img src="<?= BASE_URL ?>/public/media/jar.png" alt="icon" class="myPic">
          </div>
          <br>
        </div>
        <div class = "uploads col-md-4">
          <div class="upContent">
            <h5>Your Uploads</h5>

                <?php
                if ($pix != null){
                    foreach($pix as $entry){
                        $pic = $entry->get('file');
                        $date = $entry->get('date');
                        $theme_row = DateTheme::getTheme($date);
                        if($theme_row != null) $theme = $theme_row->get('theme');
                        $score = $entry->get('numvotes');

                        echo '<div class="past">';
                            echo '<img src="'.BASE_URL.$pic.'" alt="icon" class="tinyPic">';
                            echo '<div class="pastPicInfo">';
                                if($theme_row != null) echo "<p class='accTheme'>Theme: $theme</p>";
                                echo "<p class='accPoints'>Points: $score</p>";
                            echo '</div>';
                        echo '</div>';
                    }
                }
                ?>
        </div>
      </div>
    </div>
  </div>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>    <script src="https://use.fontawesome.com/625f8d2098.js"></script>

<script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
