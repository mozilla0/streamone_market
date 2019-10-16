(function () {
    angular.module('customPagination', []).directive('paging', ['$rootScope', function () {
        return {
            restrict: 'A',
            replace: true,
            scope: {
                data: '=list',
                url: '@url',
                postObj: '=objecttopost',
                responsein: '=getdatain',
                totalRecords: '=totalrecords',
                pageSize$: '=pagesize',
                updateMethod: '=updatemethod',
                pageNo$: '=pageno',
                isFixedPageSize: '=isfixedpagesize'
            },
            template: '<div  class="col-xs-12 form-inline" ng-cloak>\
    <div ng-hide=" !totalRecords || totalRecords <= pageSize$" class="row form top-border-gray-1">\
        <div class="col-xs-3 col-md-3 no-padding">\
            <div class="form-group floating-label pagenumber">\
            <label class="control-label" for="groupbutton10">Go to page</label>\
                <div class="input-group-content" style="max-width: 90px;">\
                <div class="input-group add-on">\
                        <input style="height:30px;" class="form-control paging" id="groupbutton10" ng-keypress = "searchOnEnter($event)" type="text" ng-model="goToPage">\
                    <div class="input-group-btn">\
                        <button type="button" class="btn btn-sm ink-reaction bg-theme-color" ng-click="goToPageUpdate(goToPage);">Go</button>\
                    </div>\
                    </div>\
                </div>\
            </div>\
        </div>\
        <div class="col-xs-9 col-md-6 text-center margin-top-sm no-padding" style="top:22px;">\
            <button type="button" class="btn btn-sm ink-reaction bg-theme-color" ng-disabled ="pageNo==1" ng-click="updatePageNo(pageNo = 1);"><i class="fa fa-angle-double-left"></i></button>\
            <button type="button" class="btn btn-sm ink-reaction bg-theme-color" ng-disabled ="pageNo==1" ng-click="updatePageNo(getInt(pageNo) - 1);"><i class="fa fa-angle-left"></i></button>\
            <span class="form-group top-padding-5">Page <span ng-bind="pageNo"></span> of <span ng-bind="totalPages"></span></span>\
            <button type="button" class="btn btn-sm ink-reaction bg-theme-color" ng-disabled ="pageNo==totalPages" ng-click="updatePageNo(getInt(pageNo) + 1);"><i class="fa fa-angle-right"></i></button>\
            <button type="button" class="btn btn-sm ink-reaction bg-theme-color" ng-disabled ="pageNo==totalPages" ng-click="updatePageNo(totalPages);"><i class="fa fa-angle-double-right"></i></button>\
        </div>\
        <div  class="col-md-3 col-xs-12 text-right margin-top-sm">\
            <div ng-if="!isFixedPageSize" class="form-group">\
                <select class="input-sm col-xs-12 form-control" ng-model="pageSize" data-ng-change="updatePageNo(1);">\
                    <option ng-repeat="item in pageSizes" value="{{item}}"><span ng-cloak>{{item}}</span></option>\
                </select>\
            </div>\
            <label class="control-label top-padding-10">Total Records: <span class="text-bold" ng-bind="totalRecords"></span></label>\
        </div>\
    </div>\
   <div ng-if ="totalRecords <= pageSize$ && totalRecords >= 1" class="pull-right"><label class="control-label top-padding-10">Total Records: <span class="text-bold" ng-bind="totalRecords"></span></label></div>\
 <div ng-if ="totalRecords == 0 || !totalRecords" class="pull-left"><label class="text-muted top-padding-10">No Records Found</label></div>\
</div>',
            link: function (scope) {
            },
            controller: 'paginationController'
        }
    }]);

    angular.module('customPagination').controller('paginationController', ['$scope', '$element', '$attrs', '$transclude', '$http', '$rootScope', function ($scope, $element, $attrs, $transclude, $http, $rootScope) {
        $scope.isFixedPageSize = $scope.isFixedPageSize || true;
        $scope.pageSizes = [10, 20, 30, 40, 50, 100, 250, 500];
        $scope.isInitialized = false;
        //if ($scope.totalRecords <= $scope.pageSizes[0]) {
        //    return;
        //}
        $scope.totalRecords = isNaN(parseInt($scope.totalRecords)) ? 0 : parseInt($scope.totalRecords);
        $scope.pageNo = isNaN(parseInt($scope.pageNo$)) ? 1 : parseInt($scope.pageNo$);
        $scope.goToPage = 1;
        $scope.pageSize = isNaN($scope.pageSize$) ? "10" : $scope.pageSize$.toString();
        $scope.totalPages = isNaN(Math.ceil($scope.totalRecords / $scope.pageSize)) ? 1 : Math.ceil($scope.totalRecords / $scope.pageSize) == 0 ? 1 : Math.ceil($scope.totalRecords / $scope.pageSize);
        $scope.getInt = function (no) {
            return parseInt(no);
        }
        $scope.tempPageSize = $scope.pageSize;
        $scope.searchOnEnter = function (event) {
            if (event.which == 13) {
                $scope.goToPageUpdate();
            }
        }
        $scope.goToPageUpdate = function () {
            if ($scope.goToPage == $scope.pageNo)
                return;
            else
                $scope.updatePageNo($scope.goToPage);
        };

        $scope.updatePageNo = function (no) {
            if (no > 0 && no <= $scope.totalPages) {
                $scope.pageNo = isNaN(parseInt(no)) ? 1 : parseInt(no);
                $scope.goToPage = no;
                if ((parseInt($scope.pageNo) != parseInt($scope.totalPages)) || ((parseInt($scope.pageSize) <= parseInt($scope.tempPageSize)) && (parseInt($scope.pageSize) <= parseInt($scope.totalRecords)))) {
                    $scope.applyScope();
                }
                $scope.totalPages = isNaN(Math.ceil($scope.totalRecords / $scope.pageSize)) ? 1 : Math.ceil($scope.totalRecords / $scope.pageSize) == 0 ? 1 : Math.ceil($scope.totalRecords / $scope.pageSize);
                $scope.totalRecords = isNaN($scope.totalRecords) ? 0 : parseInt($scope.totalRecords);
                $scope.tempPageSize = $scope.pageSize;

            }
        };
        $scope.$watch('totalRecords', function () {
            if (Math.ceil($scope.totalRecords / $scope.pageSize) != $scope.totalPages) {
                $scope.totalPages = isNaN(Math.ceil($scope.totalRecords / $scope.pageSize)) ? 1 : Math.ceil($scope.totalRecords / $scope.pageSize) == 0 ? 1 : Math.ceil($scope.totalRecords / $scope.pageSize);
                $scope.pageNo = isNaN($scope.totalRecords) ? 1 : $scope.pageNo;
                $scope.pageNo = 1;
                $scope.goToPage = 1;
            }
        });
        $scope.applyScope = function () {
            $scope.isInitialized = true;
            if (!$scope.pageNo$) {// if no pagNo attribute, only call updatemethod
                return $scope.updateMethod($scope.pageSize, $scope.pageNo);
            }
            // updating these values will apply $watch and call update method accordingly
            $scope.pageNo$ = parseInt($scope.pageNo);
            $scope.pageSize$ = parseInt($scope.pageSize);
        };
        $scope.$watch('pageNo$', function () {
            if ($scope.pageNo$ && $scope.isInitialized) {
                return $scope.updateMethod($scope.pageSize$, $scope.pageNo$);
            }
        });
        $scope.$watch('pageSize$', function () {
            if ($scope.pageNo$ && $scope.isInitialized) {
                return $scope.updateMethod($scope.pageSize$, $scope.pageNo$);
            }
        });

    }]);

})();