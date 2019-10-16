(function () {
    angular.module('typeahead', []).directive('typeahead', ['$rootScope', function () {
        return {
            restrict: 'A',
            replace: true,
            scope: {
                data: '=data',
                $modelText: '=modelText',
                noofsuggestions: '=noOfSuggestions',
                $required: '@requiredField',
                $disabled: '=isDisabled',
                model: '=model',
                textfieldname: '@textFieldName',
                textplaceholder: '@textPlaceholder',
                onchangemethod: '=onChangeMethod'
            },
            template: '<div  style="position:relative" ng-cloak ng-mouseenter="isMouseOnTypeahead = true" ng-mouseleave="isMouseOnTypeahead = false">\
                           <input type="text" id="x-typeahead-1" class="form-control " ng-required="required" \
                            placeholder="{{textplaceholder}}" name="typeahead"  autocomplete ="off"  \
                            ng-model= "$modelText"  ng-change= "onchange()"  ng-disabled ="disabled"     ng-blur="onblur()" /> \
                            <ul ng-show= "showSuggestions"  class="custom-dropdown"> \
                            <li ng-repeat="d in data | orderBy | filter: $modelText | limitTo: noofsuggestions  track by $index" \
                            ng-click="selectSuggestion(d); showSuggestions= false;model = d;">{{ textfieldname ? d[textfieldname] : d}}</li>\
                        <ul>\
                      </div>',
            link: function (scope) {
            },
            controller: 'typeaheadCtrl'
        }
    }]);

    angular.module('typeahead').controller('typeaheadCtrl', ['$scope', '$element', '$attrs', '$transclude', '$http', '$rootScope', function ($scope, $element, $attrs, $transclude, $http, $rootScope) {
        $scope.required = $scope.$required;
        $scope.disabled = $scope.$disabled;
        $scope.noofsuggestions = isNaN($scope.noofsuggestions) ? 5 : parseInt($scope.noofsuggestions);
        $scope.showSuggestions = false;
        $scope.onblur = function () {

            if ($scope.isMouseOnTypeahead) {
                $scope.showSuggestions = true;
            }
            else {
                $scope.showSuggestions = false;
                if (!$scope.model) {
                    $scope.$modelText = null;
                   // $scope.onSelectMethod($scope.methodParam1, $scope.model);
                }
            }
        };
        $scope.onchange = function () {
           
            $scope.showSuggestions = true;
            $scope.model = null;
            if ($scope.$modelText == undefined || $scope.$modelText == null || $scope.$modelText == '')
            {
                $scope.$modelText = null;
                $scope.onchangemethod();
                $scope.showSuggestions = false;
             
            }
            
        };
        $scope.selectSuggestion = function (item) {
            $scope.showSuggestions = false;
                $scope.model = item;
                $scope.$modelText = item[$scope.textfieldname];
                $scope.onchangemethod(item);
            //$scope.onSelectMethod($scope.methodParam1, $scope.model);
        };
    }]);

})();