<?php

class team extends DbObject{
    const DB_TABLE = "team";

    //database fields
    protected $teamname;
    protected $score;

    //constructor
    public function __construct($args = array()){
        $defaultArgs = array(
            'teamname' => '',
            'score' => 0,
            'membercount' =>0
            );

        $args += $defaultArgs;

        $this->teamname = $args['teamname'];
        $this->score = $args['score'];
        $this->membercount = $args['membercount'];
    }

    //save changes to database
    public function save(){
        $db = Db::instance();

        $db_properties = array(
            'score' => $this->score,
            'membercount' => $this->membercount
            );

        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    //load by teamname
    public function fetchByTeamname($teamname=null) {
        if($teamname === null) return null;

        $query = sprintf(" SELECT * FROM %s WHERE TeamName = '%s' ",
            self::DB_TABLE,
            $teamname
            );

        $db = Db::instance();
        $result = $db->lookup($query);
    }

    public static function loadByTeamname($teamname){
        $db = Db::instance();
        $obj = $db->fetchByValue("teamname", __CLASS__, self::DB_TABLE, $teamname);
        return $obj;
    }

    //get all teams, sorted by score
    public static function getAllDescScore() {
        $query = sprintf(" SELECT * FROM %s ORDER BY score DESC",
            self::DB_TABLE
            );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadByTeamname($row['teamname']);
            }
            return ($objects);
        }
    }
    public static function getAllTeams($limit=null) {
     $query = sprintf(" SELECT * FROM %s ORDER BY teamname DESC",
        self::DB_TABLE
        );

     $db = Db::instance();
     $result = $db->lookup($query);
     if(!mysql_num_rows($result))
        return null;
    else {
        $objects = array();
        while($row = mysql_fetch_assoc($result)) {
            $objects[] = self::loadByTeamname($row['teamname']);
        }
        return ($objects);
    }
}
}
?>
