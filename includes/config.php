
<?php
//making config as we need this everytime we can just use it through include_once
//1st step for database php connection
$serverName = "sql12.freesqldatabase.com";
$dBUsername = "sql12773057";
$dBPassword = "MFfe9Mp89l";
$dBName = "sql12773057";

//Before we can access data in the MySQL database, we need to be able to connect to the server i.e php
$conn = new mysqli($serverName,$dBUsername,$dBPassword,$dBName );

// Check connection
if(!$conn){
    die("Connection failed: ".$conn->connect_error());
}
?>