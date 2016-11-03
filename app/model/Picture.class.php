<?php

class picture extends DbObject {
    const DB_TABLE = "picture";

    //database fields
    protected $id;
    protected $username;
    protected $numvotes;
    protected $numflags;
    protected $date;
    protected $isWinner;
    protected $file;

    //constructor
    public function __construct($args = array()){
        $defaultArgs = array(
            'id' => null,
            'username' => '',
            'NumVotes' => 0,
            'NumFlags' => 0,
            'Date' => null,
            'isWinner' => 0,
            'file' => ''
        );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->numvotes = $args['NumVotes'];
        $this->numflags = $args['NumFlags'];
        $this->date = $args['Date'];
        $this->isWinner = $args['isWinner'];
        $this->file = $args['file'];
    }

    //save changes to database
    public function save(){
        $db = Db::instance();

        $db_properties = array(
            'id' => $this->picid,
            'username' => $this->username,
            'NumVotes' => $this->numvotes,
            'NumFlags' => $this->numflags,
            'Date' => $this->date,
            'isWinner' => $this->isWinner,
            'file' => $this->file,
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
        $query = sprintf(" SELECT * FROM %s WHERE isWinner = 1 ORDER BY date DESC",
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

    //get yesterday's winner
    public static function getYesterdayWinner() {
        $yesterday = date("Y-m-d", time() - 60*60*24);

        $query = sprintf(" SELECT * FROM %s WHERE isWinner=1 AND Date='%s' ",
            self::DB_TABLE,
            $yesterday
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
}
?>
