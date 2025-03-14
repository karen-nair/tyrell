<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $numPeople = isset($_POST['numPeople']) ? (int)$_POST['numPeople'] : 0;
    echo "<h3>Distributed Cards:</h3><pre>" . nl2br(distributeCards($numPeople)) . "</pre>";
}

function distributeCards($numPeople) {
    try {
        if (!is_int($numPeople) || $numPeople <= 0) {
            throw new Exception("Input value does not exist or value is invalid\n");
        }
        
        $suits = ['S', 'H', 'D', 'C'];
        $values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'X', 'J', 'Q', 'K'];
        $deck = [];
        
        // Create the deck
        foreach ($suits as $suit) {
            foreach ($values as $value) {
                $deck[] = "$suit-$value";
            }
        }
        
        // Shuffle the deck
        if (!shuffle($deck)) {
            throw new Exception("Irregularity occurred: Unable to shuffle deck\n");
        }
        
        // Distribute cards
        $result = array_fill(0, $numPeople, []);
        foreach ($deck as $index => $card) {
            $result[$index % $numPeople][] = $card;
        }
        
        return implode("\n", array_map(fn($hand) => implode(",", $hand), $result)) . "\n";
    } catch (Exception $e) {
        return "Error: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Card Distribution</title>
</head>
<body>
    <h2>Card Distribution</h2>
    <form method="post">
        <label for="numPeople">Enter Number of People:</label>
        <input type="number" id="numPeople" name="numPeople" min="1" required>
        <button type="submit">Distribute</button>
    </form>
</body>
</html>
