<?php
$host = "sql12773103";     // your DB host
$user = "sql12773103";     // your DB username
$pass = "your_password";   // your DB password
$db   = "sql12773103";     // your DB name

$conn = new mysqli($host, $user, $pass, $db);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Path to your SQL file
$filename = 'database.sql';

if (file_exists($filename)) {
    $sql = file_get_contents($filename);

    if ($conn->multi_query($sql)) {
        do {
            // flush multi_query results
            if ($result = $conn->store_result()) {
                $result->free();
            }
        } while ($conn->next_result());

        echo "✅ Database imported successfully!";
    } else {
        echo "❌ Error importing database: " . $conn->error;
    }
} else {
    echo "❌ SQL file not found.";
}

$conn->close();
?>
