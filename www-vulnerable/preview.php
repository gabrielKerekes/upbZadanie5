<?php
   //A4 - trosku blba funkcia, huh?
   $file = $_GET['file'];
   if(isset($file))
   {
       include("$file" . ".php");
   }
   else
   {
       include("index.php");
   }
   ?>
