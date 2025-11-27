window.addEventListener('load', function () {
    var now = new Date();
    var iso = now.toISOString();

    var div = document.getElementById('czasDiv');
    if (div) {
        div.textContent = 'Czas załadowania: ' + iso;
    }

    var input = document.getElementById('czasInput');
    if (input) {
        input.value = iso;
    }
});
