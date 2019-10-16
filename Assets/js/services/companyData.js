(function () {
    'use strict';
    app.factory("companyData", companyData);
    companyData.$inject = ["$http", "$q", "BASE_URL"];
    function companyData($http, $q, BASE_URL) {
        return {
            addEndUserMapping: function (filter) {
                return $http({
                    url: BASE_URL + 'company/addEndUserMapping',
                    method: 'POST',
                    data: filter,
                    headers: { 'Content-Type': undefined },
                    transformRequest: angular.identity
                }).then(function (data) {
                    return data;
                });

                //return $http.post(BASE_URL + 'company/addEndUserMapping', filter).then(function (data) {
                //    return data;
                //});
            },
            upsertCompanyOrderMapping: function (companyOrder) {
                return $http({
                    url: BASE_URL + 'company/upsertCompanyOrderMapping',
                    method: 'POST',
                    data: companyOrder,
                    headers: { 'Content-Type': undefined },
                    transformRequest: angular.identity
                }).then(function (data) {
                    return data;
                });
                //return $http.post(BASE_URL + 'company/upsertCompanyOrderMapping', companyOrder).then(function (data) {
                //    return data;
                //});

            },
            getCompanyEndUsers: function (filter) {
                return $http.post(BASE_URL + 'company/getCompanyEndUsers', filter).then(function (data) {
                    return data;
                });

            },
            saveMapping: function (unMapped, mapped) {
                return $http.post(BASE_URL + 'company/saveMapping', { unMapped: unMapped, mapped: mapped }).then(function (data) {
                    return data;
                });

            },
            getCompanyOrders: function (filter) {
                return $http.post(BASE_URL + 'company/getCompanyOrders', filter).then(function (data) {
                    return data;
                });

            },

            getPaginatedSubscriptions: function (filter) {
                return $http.post(BASE_URL + 'company/getPaginatedSubscriptions', filter).then(function (data) {
                    return data;
                });

            },


            deleteEndUserMapping: function (user) {
                return $http({
                    url: BASE_URL + 'company/deleteEndUserMapping',
                    method: 'POST',
                    data: user,
                    headers: { 'Content-Type': undefined },
                    transformRequest: angular.identity
                }).then(function (data) {
                    return data;
                });
                //return $http.post(BASE_URL + 'company/deleteEndUserMapping', {customerIds: customerIds }).then(function (data) {
                //    return data;
                //});

            },
            deleteCompanyOrderMapping: function (mapping) {
                return $http({
                    url: BASE_URL + 'company/deleteCompanyOrderMapping',
                    method: 'POST',
                    data: mapping,
                    headers: { 'Content-Type': undefined },
                    transformRequest: angular.identity
                }).then(function (data) {
                    return data;
                });
                //return $http.post(BASE_URL + 'company/deleteCompanyOrderMapping', recordIds).then(function (data) {
                //    return data;
                //});

            },
            updateSubscriptionDetail: function () {
                return $http.get(BASE_URL + 'company/UpdateSubscription/').then(function (data) {
                    return data;
                });
            },

            refreshCompanies: function () {
                return $http.post(BASE_URL + 'company/refreshCompanyList').then(function (data) {
                    return data;
                });
            },
            checkDatabase: function () {
                return $http.post(BASE_URL + 'company/checkDatabase').then(function (data) {
                    return data;
                });
            },
            saveMarkup: function (markup) {
                return $http.post(BASE_URL + 'company/saveMarkup', markup).then(function (data) {
                    return data;
                });
            },
            checkCompanyTable: function () {
                return $http.post(BASE_URL + 'company/checkCompanyTable').then(function (data) {
                    return data;
                })
            },
            removeMarkup: function (company) {
                return $http.post(BASE_URL + 'company/removeMarkup', company).then(function (data) {
                    return data;
                });
            }, saveAllCompanyMapping: function (endCustomerId, mappingType) {
                return $http.post(BASE_URL + 'company/saveAllCompanyMapping', { endCustomerId: endCustomerId, mappingType: mappingType}).then(function (data) {
                    return data;
                });

            }
        };
    };
})();
