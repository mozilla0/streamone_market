(function () {
    'use strict';
    app.factory("globalData", globalData);
    globalData.$inject = ["$http", "$q", "BASE_URL"];
    function globalData($http, $q, BASE_URL) {
        return {
            getSiteTermsAndConditions: function () {
                return $http.post(BASE_URL + 'home/getSiteTermsAndConditions').then(function (data) {
                    return data;
                });
            }
        };
    };
})();
