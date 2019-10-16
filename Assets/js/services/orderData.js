(function () {
    'use strict';
    app.factory("orderData", orderData);
    orderData.$inject = ["$http", "$q", "BASE_URL"];
    function orderData($http, $q, BASE_URL) {
        return {
            modifyOrderDetail: function (filter) {
                return $http({
                    url: BASE_URL + 'order/modifyOrderDetail',
                    method: 'POST',
                    data: filter,
                    headers: { 'Content-Type': undefined },
                    //transformRequest: angular.identity
                }).then(function (data) {
                    return data;
                });
                //return $http.post(BASE_URL + 'order/modifyOrderDetail', filter).then(function (data) {
                //    return data;
                //});
            },
            modifyOrderAddOns: function (filter) {
                return $http({
                    url: BASE_URL + 'order/modifyOrderAddOns',
                    method: 'POST',
                    data: filter,
                    headers: { 'Content-Type': undefined },
                    //transformRequest: angular.identity
                }).then(function (data) {
                    return data;
                });
                //return $http.post(BASE_URL + 'order/modifyOrderAddOns', filter).then(function (data) {
                //    return data;
                //});
            },
            getOrders: function (filter) {
                return $http.post(BASE_URL + 'order/getOrders', filter).then(function (data) {
                    return data;
                });
            },
            getOrderDetail: function (filter) {
                return $http.post(BASE_URL + 'order/getOrderDetail/' + filter).then(function (data) {
                    return data;
                });
            },
            refereshOrderDetail: function (id) {
                return $http.post(BASE_URL + 'order/refereshOrderDetail/' + id).then(function (data) {
                    return data;
                });
            },
            updateProductInfo: function (id) {
                return $http.post(BASE_URL + 'order/UpdateProducts/').then(function (data) {
                    return data;
                });
            },
            getUserSubscriptions: function (filter) {
                return $http.post(BASE_URL + 'order/getUserSubscriptions', filter).then(function (data) {
                    return data;
                });

            },
            getEndUserCompanies: function () {
                return $http.post(BASE_URL + 'order/getEndUserCompanies').then(function (data) {
                    return data;
                });
            },
            initUnitPrice : function(orderDetail){
                return $http.post(BASE_URL + 'order/getUnitPrice',orderDetail).then(function(data){
                    return data;
                });
            },
            initUrlDetails: function (orderDetail) {
                return $http.post(BASE_URL + 'order/getUrlDetails', orderDetail).then(function (data) {
                    return data;
                });
            },
            isUserAuthorizeToIncreaseSeat: function (orderLine, ordernumber, originalQuantity) {
                return $http.post(BASE_URL + 'order/isUserAuthorizeToIncreaseSeat', { 'orderLine': orderLine, 'ordernumber': ordernumber, 'originalQuantity': originalQuantity }).then(function (data) {
                    return data;
                })
            },
            changingOrderStatus: function(status){
                return $http.post(BASE_URL + 'order/changingOrderStatus', { 'subscription': status }).then(function (data) {
                    return data;
                })
            },
            updateSeatCountForDay: function (orderLine, ordernumber, originalQuantity) {
                return $http.post(BASE_URL + 'order/updateSeatCountForDay', { 'orderLine': orderLine, 'ordernumber': ordernumber, 'originalQuantity': originalQuantity }).then(function (data) {
                    return data;
                });
            }
        };
    };
})();
