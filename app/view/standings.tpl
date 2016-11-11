<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Standings</title>
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
      <h1>Standings</h1>
      <hr>
      <br>
      <div id = "list">
        <table id="winners">
          <tr>

              <?php
                $pic = "/public/media/jar.png";
                $counter = 0;
                if($teams != null){
                    foreach($teams as $team){
                      if($counter == 3) break;

                        $name = $team->get('teamname');
                        $score = $team->get('score');

                        echo '<td class="col-md-4 project">';
                            echo '<div class="mainPic">';
                            echo '<img src="'.BASE_URL.$pic.'" alt="icon" class="jar">';
                          echo '</div>';
                          echo '<div class="single_winner">';
                            echo "<h5>Team $name</h5>";
                            echo "<h6>$score Jars of Marmalade</h6>";
                          echo '</div>';
                        echo '</td>';

                        $counter++;
                    }
                }
              ?>
          </tr>
        </table>
      </div>
    </div>
    <p>*The jars would be filled with different amounts of marmalade, not just empty</p>

  </div>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
  <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
  <script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
  <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
