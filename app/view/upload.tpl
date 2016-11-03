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
     <span id="success">
        <?php
            if(isset($_SESSION['success']))
            {
                if($_SESSION['success'] != '')
                {
                    echo '<div class="alert alert-success" role="alert">'.$_SESSION["success"].'</div>';
                    $_SESSION['success'] = '';
                }
            }
        ?>
    </span>


      <h1>Upload Your Pic!</h1>
      <hr>
      <br>
      <div id ="individual">
        <div class="myPic">
          <?php
            if($uploaded){
                echo "<h3>Your submission for: ".$theme."</h3>";
            }
            echo "<img src='".BASE_URL.$pic."' alt='icon' class='myPic'>";
          ?>
        </div>
        <br>
    </div>
    
    <?php
      // hides the upload form if the user has already uploaded a picture
      if($uploaded){
          ?><style type="text/css">#uploadDiv{
              display:none;
           }</style><?php
      }
    ?>
    <div id="uploadDiv" class="row">
      <div class="col-md-3"></div>
        <div class="col-md-6">


            <div id="picUpload" style="text-align:center; vertical-align:middle">
              <span><b>Upload</b></span>
              <br>
              <form action="<?= BASE_URL ?>/upload/save" method="POST" enctype="multipart/form-data">
                  <input id="uploadBtn" type="file" class="upload" name="image" />
                  <input type="submit"/>
              </form>
            </div>

      </div>
      <div class="col-md-3"></div>
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
