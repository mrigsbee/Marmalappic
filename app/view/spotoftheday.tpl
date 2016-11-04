<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Upload</title>
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

      <span id="success">
         <?php
             if(isset($_SESSION['success']))
             {
                 if($_SESSION['success'] != '')
                 {
                     echo '<div class="alert alert-info" role="alert">'.$_SESSION["success"].'</div>';
                     $_SESSION['success'] = '';
                 }
             }
         ?>
     </span>

      <h1>Today's theme</h1>
      <div class="buttons col-md-3">
          <form action="<?= BASE_URL ?>/upload">
              <button type="submit" class="btn btn-success picUpload">
                <i class="fa fa-upload" aria-hidden="true"></i> Upload
              </button>
          </form>
      </div>
      <?php
        echo "<h4 class='theme col-md-6'>$theme</h4>";
      ?>
      <div class="buttons col-md-3">
        <button type="button" class="btn btn-success picUpload">
          <i class="fa fa-camera" aria-hidden="true"></i> Take A Picture
        </button>
      </div>
    <br>
      <br>
      <hr>
      <br>

      <h3>Yesterday's a-PEEL-ing Pic</h3>
      <?php
        echo "<h6>Uploaded by: $yesterday</h6>";
      ?>
      <div id ="individual">
        <div class="myPic">

                <?php
                if($yesterday_pic != null){
                    echo '<img src="'.BASE_URL.$yesterday_pic.'" alt="icon" class="myPic">';
                  }
                  else{
                    echo '<p>Sadly no pic to show</p>';
                  }
                ?>
        </div>
        <br>
      </div>
      <?php
        echo "<h6>Theme: $yesterdays_theme</h6>";
      ?>
    </div>
  </div>


  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
  <script src="https://use.fontawesome.com/625f8d2098.js"></script>
  <!-- <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script> -->
  <script src="?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  <!-- <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script> -->

</body>
</html>
