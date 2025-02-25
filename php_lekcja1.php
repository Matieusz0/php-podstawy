<?php
// Deklaracja zmiennych
$x = 5;
$tekst = "zmienna zawiera tekst";

// Deklaracja i inicjalizacja
$t = -1;

// Wypisanie zawartości zmiennych
echo "Zmienna x = " . $x . "<br>";
echo "Zmienna tekst: " . $tekst . ".<br><br>";

// Instrukcja if
echo "Instrukcja if<br>";
$a = 2;
$b = 3;

if ($a > $b) { // jeśli a jest większe od b
    echo "Wartość zmiennej a jest większa od zmiennej b.";
} else {
    echo "Wartość zmiennej b jest większa od zmiennej a.";
}

echo "<br><br>";

// Pętla for
echo "Pętla for<br>";

for ($i = 2; $i <= 100; $i += 2) {
    // JS pozwala na zmniejszanie lub zwiększanie licznika pętli w bloku instrukcji
    echo $i . "; ";
}

echo "<br><br>";

// Pętla while
echo "Pętla while<br>";
$w = 0;
while ($w < 10) { // pętla while wykonuje blok instrukcji dopóki warunek pętli jest spełniony
    $w++;
    echo $w . "; ";
}

echo "<br><br>";

// Zadanie
$x = 3;
$y = 4;
$z;
echo "Wartości zmiennych: x = " . $x . "; y = 4;<br>";
$z = $y + 7;
echo "Operacja z = y + 7, wynik z = " . $z . ".<br>";

$z = ($x + $y) / 2;
echo "Operacja z = (x + y)/2, wynik z = " . $z . ".<br>";

$z = ($x > 2) && ($y <= 3);
echo "Operacja z = (x>2)&&(y<=3), wynik z = " . $z . ".<br>";

$z = ($x * 3 + 4) % 5;
echo "Operacja z = (x*3+4)%5, wynik z = " . $z . ".<br>";

// Funkcja
echo "<br>Funkcja<br>";

function podzielnosc($l, $u) {  // deklaracja funkcji
    for ($k = 0; $k < $l; ) {
        $k++;
        if (($k % $u) == 0) {
            echo $k . " - podzielna przez " . $u . ";<br>";
        } else {
            echo $k . " - niepodzielna przez " . $u . ";<br>";
        }
    }
}

podzielnosc(90, 5);  // wywołanie funkcji z parametrem o wartości 90
echo "<br><br>";
podzielnosc(20, 4);

// Zadanie 2
$a = 80;
$b = 24;

echo "<br>Algorytm Euklidesa do szukania NWD<br>";
while ($a != $b) { // dopóki a jest różne od b
    if ($a > $b) {
        $a = $a - $b;
    } else {
        $b = $b - $a;
    }
}
echo "NWD = " . $a . ";<br><br>";

echo "Funkcja zwracająca<br>";

// Funkcja zwracająca tekst
function zwroc($tekst) {  // deklaracja funkcji z jednym parametrem
    return $tekst;  // zwracanie zmiennej tekst
}
echo "Zwroc: " . zwroc("jakiś tekst") . ";<br>";

echo "<br>Algorytm NWD w postaci funkcji<br>";

function nwd($h, $g) {  // deklaracja i inicjalizacja funkcji nwd z dwoma parametrami
    while ($h != $g) {  // dopóki h jest różne od g
        if ($h > $g) {
            $h = $h - $g;
        } else {
            $g = $g - $h;
        }
    }
    return $h;  // zwracanie zmiennej h
}

$pierwszaLiczba = 25;
$drugaLiczba = 5;
echo "NWD 25 i 5 = " . nwd($pierwszaLiczba, $drugaLiczba) . ";<br>";
echo "Pierwsza liczba = " . $pierwszaLiczba . "<br>";
echo "NWD 80 i 24 = " . nwd(80, 24) . ";<br>";
echo "NWD 81 i 36 = " . nwd(81, 36) . ";<br><br>";

// Tablica 4x4
echo "Tablica 4x4<br>";
$A = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16]
];

for ($w = 0; $w < 4; $w++) {
    echo "Wiersz: " . $w . ":<br>";

    for ($k = 0; $k < 4; $k++) {
        echo $A[$w][$k] . "; ";
        if ($k == 3) {
            echo "<br>";
        }
    }
}

echo "<br>";

for ($k = 0; $k < 4; $k++) {
    echo "Wiersz: " . $w . ":<br>";

    for ($w = 0; $w < 4; $w++) {
        echo $A[$w][$k] . "; ";
        if ($w == 3) {
            echo "<br>";
        }
    }
}

echo "<br>Tablica i uzupełnianie wartości<br>";

$B = [];
$wiersze = 15;
$kolumny = 15;
$wartosc = 1;

for ($w = 0; $w < $wiersze; $w++) {
    echo "Wiersz: " . ($w + 1) . ":<br>";
    $B[$w] = [];
    for ($k = 0; $k < $kolumny; $k++) {
        $B[$w][$k] = $wartosc;
        $wartosc++;
        echo $B[$w][$k] . "; ";
        if ($k == $kolumny - 1) {
            echo "<br>";
        }
    }
}

?>
