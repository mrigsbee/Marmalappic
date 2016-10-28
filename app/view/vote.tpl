<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Past Winners</title>
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
        <h1>Vote</h1>
        <hr>
        <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-4"><h3>Today's Entries</h3></div>
          <div class="col-md-4">
            <button type="button" class="btn btn-success upload">
              <i class="fa fa-camera" aria-hidden="true"></i> Upload
            </button>
          </div>
        </div>
        <br>
        <div id = "list">
          <table id="winners">
              <tr>
              <?php
                    $counter = 0;
                  foreach($todays_entries as $entry){
                      if($counter % 3 == 0){
                          if($counter != 0) echo "</tr>";
                          echo "<tr>";
                      }

                      $pic  = $entry->get('file');
                      $username  = $entry->get('username');

                      if($username == "HokieBird12"){ //DUMMY VALUE BEING USED -- UPDATE WHEN AUTHENTIFICATION HAS BEEN UPDATED ************************************
                          continue; //don't show pictures uploaded by the user currently signed in
                      }
                      $picid = $entry->get('id');

                          echo '<td class="col-md-4 project">';
                            echo '<div class="mainPic">';
                            echo '<img src="'.BASE_URL.$pic.'" alt="icon" class="pic">';
                            echo "</div>";
                            echo '<div class="single_winner">';
                            echo "<h6>Uploaded by: $username</h6>";

                            //'Voted' button will appear if user has voted for a particular image; 'vote' button if not
                            if (in_array($entry->get('id'), $votes)){
                                //show 'voted' button
                                echo "<button id='voted" .$counter. "' type='button' onclick='voted(" .$counter. ", ".$picid.")' class='btn btn-success btn-lg'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> Voted</button>";
                                echo "<button id='vote" .$counter. "' style='display:none' type='button' onclick='vote(" .$counter. ", ".$picid.")' class='btn btn-info btn-lg'>Vote</button>";
                            } else {
                                //show 'vote' button
                                echo "<button id='vote" .$counter. "' type='button' onclick='vote(" .$counter. ", ".$picid.")' class='btn btn-info btn-lg'>Vote</button>";
                                echo "<button id='voted" .$counter. "' style='display:none' type='button' onclick='voted(" .$counter. ", ".$picid.")' class='btn btn-success btn-lg'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> Voted</button>";
                            }

                            echo "<br>";
                            echo '<a href="#" class="inappropriate"><i class="fa fa-flag" aria-hidden="true"></i> Flag as inappropriate</a>';
                            echo "</div>";
                          echo "</td>";

                      $counter++;
                  }
              ?>
            </tr>
          </table>
        </div>
      </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

    <script type="text/javascript">
        function voted(id, picid)
        {
            $('#voted' + id).hide();
            $('#vote' + id).show();
        }

        function vote(id, picid)
        {
            $('#vote' + id).hide();
            $('#voted' + id).show();
        }
    </script>



    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://use.fontawesome.com/625f8d2098.js"></script>
    <script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
  </html>
