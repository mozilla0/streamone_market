(function () {
    'use strict';
    app.factory("customerData", customerData);
    customerData.$inject = ["$http", "$q", "BASE_URL"];
    function customerData($http, $q, BASE_URL) {
        return {
            getEndCustomers: function (filter) {               
                return $http.post(BASE_URL + 'reseller/GetCustomersInfo/', filter).then(function (data) {
                    return data;
                });
            }
        };
    };
})();
