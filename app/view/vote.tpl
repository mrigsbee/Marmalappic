<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/vahstyles.css">
  <title>Vote</title>
  <link href="<?= BASE_URL ?>/public/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Chewy|Raleway" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
  <script src="https://code.jquery.com/jquery-2.2.0.js"></script>

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
        <h1>Vote</h1>
        <hr>
        <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-4"><h3>Today's Entries</h3></div>
          <div class="col-md-4">
              <form action="<?= BASE_URL ?>/upload">
                  <button type="submit" class="btn btn-success picUpload">
                    <i class="fa fa-camera" aria-hidden="true"></i> Upload
                  </button>
              </form>
          </div>
        </div>

        <?php
            if($hide){
                echo "<br><br><h3>You cannot vote until you upload a photo today!</h3>";
            }
            else {
        ?>

        <div id = "list">
          <table id="winners">
              <tr>
              <?php
                    $counter = 0;
                    if($todays_entries != null){
                        foreach($todays_entries as $entry){
                          if($counter % 3 == 0){
                              if($counter != 0) echo "</tr>";
                              echo "<tr>";
                          }


                      $pic  = $entry->get('file');
                      $un  = $entry->get('username');

                       //don't show pictures uploaded by the user and their teammates
                      if(in_array($un, $teammates)){
                          continue;
                      }

                      $picid = $entry->get('id');

                          echo '<td class="col-md-4 project">';
                            echo '<div class="mainPic">';
                            echo '<img id='.$picid.' src="'.BASE_URL.$pic.'" alt="icon" class="pic">';
                            echo "</div>";
                            echo '<div class="single_winner">';
                            echo "<h6>Uploaded by: $un</h6>";

                            //'Voted' button will appear if user has voted for a particular image; 'vote' button if not
                            if (in_array($picid, $votes)){
                                //show 'voted' button
                                echo "<button id='voted_".$picid."' type='button' class='voted btn btn-success btn-lg'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> Voted</button>";
                                echo "<button id='vote_".$picid."' style='display:none' type='button' class='vote btn btn-info btn-lg'>Vote</button>";
                            } else {
                                //show 'vote' button
                                echo "<button id='voted_".$picid."' style='display:none' type='button' class='voted btn btn-success btn-lg'><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> Voted</button>";
                                echo "<button id='vote_".$picid."' type='button' class='vote btn btn-info btn-lg'>Vote</button>";
                            }

                            echo "<br>";

                            //Flagged button: show if not clicked, disable if clicked
                            if (in_array($picid, $flags)){
                                echo "<button id='flagged_".$picid."' type='button' class='btn btn-warning btn-sm' disabled>You have flagged this image</button>";
                                echo "<button id='flag_".$picid."' style='display:none' type='button' class='flagged btn btn-warning btn-sm'><i class='fa fa-flag' aria-hidden='true'></i> Flag as inappropriate</button>";

                            } else {
                                echo "<button id='flag_".$picid."' type='button' class='flagged btn btn-warning btn-sm'><i class='fa fa-flag' aria-hidden='true'></i> Flag as inappropriate</button>";
                                echo "<button id='flagged_".$picid."' style='display:none' type='button' class='btn btn-warning btn-sm' disabled>You have flagged this image</button>";
                            }

                            echo "</div>";
                          echo "</td>";

                      $counter++;
                    }
                  }
             } //close else statement
              ?>
            </tr>
          </table>
        </div>
      </div>
    </div>

    <script src="https://use.fontawesome.com/625f8d2098.js"></script>
    <script src="<?= BASE_URL ?>/public/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<?= BASE_URL ?>/public/js/marmalappic.js"></script>

  </body>
  </html>
