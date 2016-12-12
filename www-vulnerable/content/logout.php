<?php
//zrusime session
//A8 checkovanie tokenu
if (isset($_GET["csrf"]) && $_GET["csrf"] == $_SESSION["token"]) {
    $_SESSION = array();
    session_destroy();
}

//header("LOCATION: page.php") je v pohode avsak nikdy netreba verit pouzivatelovi a tak to radsej presmeruj priamo na stranku kde sa nachadza login ;)
//A10
header("LOCATION: index.php");
?>
