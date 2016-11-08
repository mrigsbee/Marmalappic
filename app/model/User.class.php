<?php
class User extends DbObject {
    // name of database table
    const DB_TABLE = 'user';
    // database fields
    protected $id;
    protected $username;
    protected $teamname;
    protected $email;
    protected $password;
    protected $score;
    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'username' => '',
            'teamname' => '',
            'email' => '',
            'password' => '',
            'score' => 0
            );
        $args += $defaultArgs;
        $this->id = $args['id'];
        $this->username = $args['username'];
        $this->teamname = $args['teamname'];
        $this->email = $args['email'];
        $this->password = $args['password'];
        $this->score = $args['score'];
    }
    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'username' => $this->username,
            'teamname' => $this->teamname,
            'email' => $this->email,
            'password' => $this->password,
            'score' => $this->score
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }
    // delete object
    public function delete()
    {
         $db = Db::instance();
            $query = sprintf(" DELETE FROM %s  WHERE username = '%s' AND pw = '%s' ",
            self::DB_TABLE,
            $this->username,
            $this->pw
            );
            $ex = mysql_query($query);
            if(!$ex)
            die ('Query failed:' . mysql_error());
    }
    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }
    // load user by username
    public static function loadByUsername($username=null) {
        if($username === null)
            return null;
        $query = sprintf(" SELECT id FROM %s WHERE username = '%s' ",
            self::DB_TABLE,
            $username
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

        public static function loadByEmail($email=null) {
        if($email === null)
            return null;
        $query = sprintf(" SELECT id FROM %s WHERE email = '%s' ",
            self::DB_TABLE,
            $email
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

    public static function getTeamMembers($team) {
        $query = sprintf(" SELECT * FROM %s WHERE teamname='%s'",
            self::DB_TABLE,
            $team
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
