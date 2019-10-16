(function () {

    'use strict';
    app.controller('globalCtrl', globalCtrl);
    globalCtrl.$inject = ["$scope", "$filter", "globalData"];
    function globalCtrl($scope, $filter, globalData) {
        $scope.validateForm = function (obj, formName) {
            $("form[name='" + formName + "'] input,select").each(function () {
                var input = $(this);
                input.removeClass('invalid-input');
                input.next("span").remove();

                $.each(obj, function (index, e) {
                    if (e.Key.toLowerCase() == (input.attr("name") ? input.attr("name").toLowerCase() : "")) {
                        input.addClass('invalid-input');
                        input.after("<span class='invalid-text'>" + e.Value + "</span>");
                    }
                });
            });
        };
        $scope.post = function (path, params, method) {
            method = method || "post"; // Set method to post by default if not specified.

            // The rest of this code assumes you are not using a library.
            // It can be made less wordy if you use one.
            var form = document.createElement("form");
            form.setAttribute("method", method);
            form.setAttribute("action", path);

            for (var key in params) {
                if (params.hasOwnProperty(key)) {
                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", key);
                    hiddenField.setAttribute("value", params[key]);

                    form.appendChild(hiddenField);
                }
            }

            document.body.appendChild(form);
            form.submit();
        };
        $scope.getStringFormattedDate = function (date, format) {
            return new Date(date).getFullYear() < 1970 ? "" : $filter('date')(date, format);
        };
        $scope.showSiteTermsAndConditions = function () {
            if (!$scope.siteTermsAndConditions) {
                globalData.getSiteTermsAndConditions().then(function (resp) {
                    $scope.siteTermsAndConditions = resp.data;
                })
               .catch(function () {

               });
            }
            $("#termsAndConditionsPopup").modal();
        };
    };

})();