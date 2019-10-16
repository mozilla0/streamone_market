(function () {

    'use strict';
    app.controller('customerCtrl', customerCtrl);
    customerCtrl.$inject = ["$scope",  "customerData"];
    function customerCtrl($scope, customerData) {
        $scope.getEndCustomers = function () {
            customerData.getEndCustomers($scope.model.customerFilter).then(function (resp) {
                $scope.model.customersInfo = resp.data;
            })
            .catch(function () {

            });
        }

    };

})();