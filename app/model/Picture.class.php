<?php

class picture extends DbObject {
    const DB_TABLE = "picture";

    //database fields
    protected $id;
    protected $username;
    protected $numvotes;
    protected $numflags;
    protected $date;
    protected $file;

    //constructor
    public function __construct($args = array()){
        $defaultArgs = array(
            'id' => null,
            'username' => '',
            'numvotes' => 0,
            'numflags' => 0,
            'date' => null,
            'file' => ''
        );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->numvotes = $args['numvotes'];
        $this->numflags = $args['numflags'];
        $this->date = $args['date'];
        $this->file = $args['file'];
    }

    //save changes to database
    public function save(){
        $db = Db::instance();

        $db_properties = array(
            'id' => $this->picid,
            'username' => $this->username,
            'numvotes' => $this->numvotes,
            'numflags' => $this->numflags,
            'date' => $this->date,
            'file' => $this->file
        );

        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    public static function loadById($id){
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    //get all of today's submissions
    public static function getAllToday() {
        $today = date("Y-m-d", time());

        $query = sprintf(" SELECT * FROM %s WHERE Date='%s' ",
            self::DB_TABLE,
            $today
        );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    //get all the winning photos sorted by most recent to oldest date
    public static function getAllWinning() {
        $query = sprintf("SELECT id, max(numvotes) FROM %s GROUP BY date DESC",
            self::DB_TABLE
        );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    public static function getAllWinningExceptToday(){
      $winners = array();

      $all_dates = DateTheme::getAll();

        if($all_dates != null){
            foreach($all_dates as $date){
              $day = $date->get('date');
              if($day >= date("Y-m-d")) continue; //don't show today or futuer day's winner

              $pic = Picture::getWinnerByDate($day);
               if($pic != null) array_push($winners, $pic);
            }
        }

        return ($winners);
    }


    public static function getWinnerByDate($date) {

        $query = sprintf(" SELECT * FROM %s WHERE date='%s' ORDER BY numvotes DESC limit 1 ",
            self::DB_TABLE,
            $date
        );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $row = mysql_fetch_assoc($result);
            $obj = self::loadById($row['id']);
            return ($obj);
        }
    }

    //get yesterday's winner
    public static function getYesterdayWinner() {
        $yesterday = date("Y-m-d", time() - 60*60*24);

        return self::getWinnerByDate($yesterday);
    }

    //get all pics by user
    public static function getAllByUser($user) {
        $query = sprintf(" SELECT * FROM %s WHERE username = '%s' ORDER BY date DESC",
            self::DB_TABLE,
            $user
        );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }

    //get pic from user on specific day
    public static function getPicByUserAndDate($user, $date) {
        $query = sprintf(" SELECT * FROM %s WHERE username = '%s' AND date = '%s'",
            self::DB_TABLE,
            $user,
            $date
        );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $row = mysql_fetch_assoc($result);
            $obj = self::loadById($row['id']);
            return ($obj);
        }
    }

    public function delete()
    {
        $db = Db::instance();
        $query = sprintf(" DELETE FROM %s  WHERE id = '%s'",
            self::DB_TABLE,
            $this->id
        );
        mysql_query($query);
    }

    public function incVotes(){
       $db = Db::instance();
       $query = sprintf(" UPDATE %s SET numvotes=numvotes+1 WHERE id = '%s'",
           self::DB_TABLE,
           $this->id
       );
       mysql_query($query);

       //Update user's score
       $pic_user = User::loadByUsername($this->username);
       $userid = $pic_user->get('id');
       $query2 = sprintf(" UPDATE %s SET score=score+1 WHERE id = '%s'",
           "user",
           $userid
       );
       mysql_query($query2);

       //Update team's score
       $teamname = $pic_user->get('teamname');
       $query3 = sprintf(" UPDATE %s SET score=score+1 WHERE teamname = '%s'",
           "team",
           $teamname
       );
       mysql_query($query3);
    }

    public function decVotes(){
       $db = Db::instance();
       $query = sprintf(" UPDATE %s SET numvotes=numvotes-1 WHERE id = '%s'",
           self::DB_TABLE,
           $this->id
       );
       mysql_query($query);

       $pic_user = User::loadByUsername($this->username);
       $userid = $pic_user->get('id');
       $query2 = sprintf(" UPDATE %s SET score=score-1 WHERE id = '%s'",
           "user",
           $userid
       );
       mysql_query($query2);

       $teamname = $pic_user->get('teamname');
       $query3 = sprintf(" UPDATE %s SET score=score-1 WHERE teamname = '%s'",
           "team",
           $teamname
       );
       mysql_query($query3);
    }

    public function incFlags(){
       $db = Db::instance();
       $query = sprintf(" UPDATE %s SET numflags=numflags+1 WHERE id = '%s'",
           self::DB_TABLE,
           $this->id
       );
       mysql_query($query);
    }
}
?>
