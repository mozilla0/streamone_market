(function () {
    'use strict'; 

    window.app = angular.module('app', ['lazyLoader', 'customPagination', 'typeahead']);
    window.app.config(function ($httpProvider) {
        $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

        $httpProvider.interceptors.push(function ($q) {
            return {
                request: function (config) {
                    return config || $q.when(config);
                },
                response: function (response) {
                    return response;
                },
                responseError: function (response) {

                    var responseInfo = {
                        status: response.status,
                        statusText: response.statusText,
                        headers: response.headers && response.headers(),
                        data: response.data,
                        config: response.config
                    };

                    if (response.status === 404) {
                        window.location.href = "/Error/NotFound?message=" + response.statusText;
                    }
                    if (response.status === 500) {
                        window.location.href = "/Error/ServerError?message=" + response.statusText;
                    }
                    if (response.status === 10) {
                        window.location.href = "/Error/StreamOneCodeError?message=" + response.statusText;
                    }
                    return $q.reject(response);
                }
            };
        });
    });
})();

