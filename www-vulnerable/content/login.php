<?php
function verify_login(){
    global $db;
    $query = "SELECT id,name,password FROM admins WHERE name=? AND password=? LIMIT 1";

    if ($statement = $db->prepare($query))
    {
        $hash = hash("sha512", $_GET['pass']);
        $statement->bind_param('ss', $_GET['name'], $hash);
        $statement->execute();
        $data = $statement->get_result()->fetch_array();
    }

    if(!empty($data)){
        $_SESSION['id']  = $data['id'];
        $_SESSION['name'] = $data['name'];
        $_SESSION['session_id'] = session_id();
        return true;
    }else{
        return false;
    }
}

//echo hash("sha512","student");

if(@$_GET['logIN']){
    if(verify_login()) {
        header('LOCATION: index.php');
    }else{
        $error = "Wrong name or password!! Pls try it again!!";
    }
}
?>
<?if(!isLogin()){?>
<div style="width:20%;">
    <?=@$error?>
    <form method="get" name="login">
        <label>Meno</label>
        <input name="name" value="" type="text" placeholder="LamaCoder" autofocus />
        <label>Heslo</label>
        <input name="pass" value="" type="password" placeholder="********" />
        <br />
        <button class="button" name="logIN" value="1">Prihlasiť</button>
    </form>
</div>
<?}else{?>
    <div style="width:20%;">
        <?=@$error?>
        <a href="./?page=logout"><button class="button">Odhlásiť sa</button></a>
    </div>
<?}?>
