<?php

class datetheme extends DbObject {
    const DB_TABLE = "datetheme";

    //database fields
    protected $date;
    protected $theme;

    //constructor
    public function __construct($args = array()){
        $defaultArgs = array(
            'date' => null,
            'theme' => ''
        );

        $args += $defaultArgs;

        $this->date = $args['date'];
        $this->theme = $args['theme'];
    }

    //save changes to database
    public function save(){
        $db = Db::instance();

        $db_properties = array(
            'date' => $this->date,
            'theme' => $this->theme
        );

        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    public static function loadById($id){
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function loadByDate($day){
        $db = Db::instance();
        $obj = $db->fetchByValue("date", __CLASS__, self::DB_TABLE, $day);
        return $obj;
    }


    //get theme for 'day'
    public static function getTheme($day) {

        $query = sprintf(" SELECT * FROM %s WHERE Date='%s' ",
            self::DB_TABLE,
            $day
        );

        $db = Db::instance();
        $result = $db->lookup($query);
        if(!mysql_num_rows($result))
            return null;
        else {
            $row = mysql_fetch_assoc($result);
            $obj = self::loadByDate($row['date']);
            return ($obj);
        }

        // $db = Db::instance();
        // $result = $db->lookup($query);
        // if(!mysql_num_rows($result))
        //     return null;
        // else {
        //     $objects = array();
        //     while($row = mysql_fetch_assoc($result)) {
        //         $objects[] = self::loadById($row['id']);
        //     }
        //     return ($objects);
        // }


    }
}
?>
