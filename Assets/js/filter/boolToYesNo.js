(function () {
    app.filter('boolToYesNo', function () {
        return function (input) {
            input = input || '';
            return input == true || input.toString().toLowerCase() == 'true' ? 'Yes' : 'No';
        }
    })
})();