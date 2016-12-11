<?php
// A1 - uplne najlepsie http://php.net/manual/en/mysqli-stmt.get-result.php 
// A1 - pripade treba pozriet na real_escape_string() a whitelistovat vyhladavanie teda povolit len znaky a cisla napriklad regexom ;)
// A5 minimalne treba povypinat error message no najlepsie je osetrit cyklus try catchom a v pripade chyby presmerovanie na error_page.php
$query = "SELECT * FROM articles WHERE title LIKE ? OR content LIKE ?";

if (!$statement = $db->prepare($query))
{

}
else
{
    $searchString = $_POST['search'];
    $searchString = htmlspecialchars($searchString);
    $param = "%{$searchString}%";
    $statement->bind_param('ss', $param, $param);
    $statement->execute();
    $search = $statement->get_result();
}
?>

<!--Co tak dat vysledky vyhladavania a data[title] do htmlspecialchars? -->
<h1> Výsledky vyhľadavania: <?=$searchString?></h1>

<div>
    <?php
    try {
        while($data = $search->fetch_array(MYSQL_ASSOC)){
            echo 'Article: <a href=/index.php?id='.$data["id"].'>'.$data["title"].'</a><br />';
        }
    } catch (Exception $e) {
        header("LOCATION: error_page.php");
    }
    ?>
</div>
