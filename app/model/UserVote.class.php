<?php

class UserVote extends DbObject {
    const DB_TABLE = "uservote";

    //database fields
    protected $id;
    protected $username;
    protected $picid;

    //constructor
    public function __construct($args = array()){
        $defaultArgs = array(
            'id' => null,
            'username' => '',
            'picid' => null
        );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->picid = $args['picid'];
    }

    //save changes to database
    public function save(){
        $db = Db::instance();

        $db_properties = array(
            'id' => $this->picid,
            'username' => $this->username,
            'picid' => $this->picid
        );

        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    public static function loadById($id){
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function getAllByUser($user){
        $query = sprintf(" SELECT * FROM %s WHERE username = '%s' ORDER BY picid ASC",
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

}
?>
