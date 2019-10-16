(function () {
    'use strict';
    app.controller('companyCtrl', companyCtrl);
    companyCtrl.$inject = ["$scope", "companyData", "$rootScope", "$timeout"];
    function companyCtrl($scope, companyData, $rootScope, $timeout) {

        $scope.checkedUsers = [];
        $scope.toBeMapped = [];
        $scope.toBeUnMapped = [];
        $scope.selectedSubscriptionForMarkUp = {};
        $scope.showTableHeading = false;
        $scope.company = null;
        $scope.subsCompanyId = null;
        $scope.subsEndCustomerId = null;
        $scope.saveCompanyLevelMarkUpMessage = "Are you sure you want to perform this update?";
        $scope.saveMarkUpType = 1;
        $scope.removeMarkupModel = { company: null };
        $scope.patternPercentage = "^([1-9]([0-9])?|0)(\.[0-9]{1,2})?$";

        $scope.showEndUserPopup = function () {
            $scope.model.user = { email: '' };
            $("#endUserPopup").modal();
            $scope.isSuccess = false;
            $scope.message = '';
            $scope.addEditUserHeader = 'Add App User';

        };

        $scope.addEndUserMapping = function (model) {
            var user = model.user;
            var companyName = user.companyName || $scope.model.user.selectedCompany.companyName;
            var companyId = user.selectedCompany ? user.selectedCompany.companyId : null;
            var createdBy = user.createdBy ? user.createdBy : null;
            var created = user.created ? user.created : null;
            var id = user.id ? user.id : null;

            user.token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
            var companyUser = new FormData();
            companyUser.append("companyName", companyName);
            companyUser.append("email", user.email);
            companyUser.append("name", user.name);
            companyUser.append("companyId", companyId);
            companyUser.append("id", id);
            companyUser.append("createdBy", createdBy);
            companyUser.append("created", created);
            companyUser.append("companyId", companyId);
            //companyUser.append("companyName", user.selectedCompany.companyName);
            companyUser.append('__RequestVerificationToken', user.token);

            companyData.addEndUserMapping(companyUser).then(function (resp) {
                if (resp.data.isValid) {
                    $scope.message = "User Saved Successfully";
                    $scope.isSuccess = true;
                    $scope.getCompanyEndUsers($scope.model.filter);
                } else $scope.message = resp.data.message;
            })
                .catch(function () {

                });
        };
        $scope.editSalesOrderMapping = function (companyOrder) {
            if (companyOrder != null) {
                $scope.editCompanyOrder = true;
                companyOrder.companyId = companyOrder.companyId.toString();
                $scope.model.companyOrder.companyName = companyOrder.companyName;
                $scope.model.selectedCompany = { companyId: companyOrder.companyId, companyName: companyOrder.companyName };
                $scope.headerText = "Edit Sales Order";
            }
            else {
                $scope.editCompanyOrder = false;
                $scope.headerText = "Add Sales Order";
            }
            $scope.model.companyOrder = angular.extend({}, companyOrder);
            $("#salesOrderMappingPopup").modal();
            $scope.isSuccess = false;
            $scope.message = null;
            $scope.errorMessage = null;
        };
        $scope.upsertCompanyOrderMapping = function (model) {
            //var companyOrder = { companyId: model.companyOrder.companyId, salesOrderIdCSV: model.companyOrder.salesOrderIdCSV, salesOrderId: model.companyOrder.salesOrderId, recordId: model.companyOrder.recordId };
            var companyOrder = {};
            angular.extend(companyOrder, model.companyOrder);
            companyOrder.companyId = model.selectedCompany.companyId;
            companyOrder.token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
            var companyForm = new FormData();

            companyForm.append("companyId", companyOrder.companyId);
            companyForm.append('companyName', companyOrder.companyName);
            companyForm.append('salesOrderIdCSV', companyOrder.salesOrderIdCSV);
            companyForm.append('__RequestVerificationToken', companyOrder.token);
            companyData.upsertCompanyOrderMapping(companyForm).then(function (resp) {
                if (resp.data.isValid) {
                    $scope.message = resp.data.message;
                    $scope.errorMessage = (resp.data.errorMessage || "").split('#');
                    $scope.isSuccess = true;
                    $scope.getCompanyOrders($scope.model.filter);
                }
                else {
                    $scope.message = resp.data.message;
                    $scope.isSuccess = false;
                }

            })
                .catch(function () {

                });
        };
        $scope.getCompanyEndUsers = function (item) {
            if (item) {

                $scope.model.filter.companyId = item.companyId;
                $scope.model.filter.companyName = item.companyName;
                $scope.model.filter.email = item.email
            } else {
                if (item == undefined) {
                    $scope.model.filter.selectedCompany = null;
                }

                $scope.model.filter.companyId = $scope.model.filter.selectedCompany ? $scope.model.filter.selectedCompany.companyId : 0;
                $scope.model.filter.companyName = $scope.model.filter.selectedCompany ? $scope.model.filter.selectedCompany.companyName : null;
                $scope.model.filter.email = $scope.model.filter.selectedEmail ? $scope.model.filter.selectedEmail.email : null;
            }
            companyData.getCompanyEndUsers($scope.model.filter).then(function (resp) {
                if (resp && resp.data) {
                    $scope.model.endUsers = resp.data;
                    $scope.model.filter.totalRecords = resp.data.length > 0 ? resp.data[0].totalRecords : 0;
                }
            })
                .catch(function () {

                });
        };
        $scope.getCompanyOrders = function (filter) {
            companyData.getCompanyOrders(filter).then(function (resp) {
                $scope.model.companyOrders = resp.data;
                for (var i = 0; i < $scope.model.companyOrders.length; i++) {
                    if ($scope.checkedUsers != null) {
                        for (var j = 0; j < $scope.checkedUsers.length; j++) {
                            if ($scope.checkedUsers[j] == $scope.model.companyOrders[i].recordId)
                                $scope.model.companyOrders[i].checked = true;
                        }
                    }

                }
            })
                .catch(function () {

                });
        };
        $scope.getSalesOrderIdListFromCSV = function (salesOrderIdCSV) {
            var soIds = [];
            soIds = salesOrderIdCSV > '' ? salesOrderIdCSV.split(',') : [];
            return soIds;
        };
        $scope.filterCompanyOrders = function (item) {

            if (item)
                $scope.model.filter.companyId = item.companyId;
            else {


                if (item == undefined) {
                    $scope.model.selectedCompany = null;
                }
                $scope.model.filter.companyId = $scope.model.selectedCompany ? $scope.model.selectedCompany.companyId : 0;
            }
            $rootScope.hideLoader = true;

            $scope.getCompanyOrders($scope.model.filter);
        };
        $scope.editEndUser = function (user) {
            $scope.model.user = {};
            $scope.message = '';
            $scope.addEditUserHeader = 'Edit User : ' + user.name;
            angular.extend($scope.model.user, user);
            $("#endUserPopup").modal();
            $scope.isSuccess = false;
        };

        //POP-UP TO DELETE ENDUSER
        $scope.showDeleteEndUserPopup = function (user) {
            $scope.checkedUsers.push(user.id);
            $scope.model.user = user;
            $scope.isSuccess = false;
            $scope.message = "Are you sure you want to delete the user " + user.name + " ?";
            $("#deleteEndUserPopup").modal();
        };
        $scope.showMultipleDeleteEndUserPopup = function () {

            angular.forEach($scope.model.endUsers, function (user, index) {
                if (user.checked == true) {
                    $scope.checkedUsers.push(user.id);
                }
            });

            $scope.isSuccess = false;
            $scope.message = "Are you sure you want to delete the users ?";
            $("#deleteMultipleEndUserPopup").modal();
        };
        // END OF POP-UP TO DELETE ENDUSER


        //POP-UP TO DELETE COMPANY ORDER MAPPING
        $scope.showDeleteCompanyOrderMappingPopup = function (companyOrder) {
            $scope.checkedUsers.push(companyOrder.recordId);
            //$scope.model.companyOrder = companyOrder;
            $scope.message = "Are you sure you want to delete sales order mapping for order " + companyOrder.salesOrderId;
            $scope.isSuccess = false;
            $('#deleteCompanyOrderPopup').modal();

        };
        $scope.showMultipleDeleteCompanyOrderMappingPopup = function () {

            //angular.forEach($scope.model.companyOrders, function (order, index) {
            //    if (order.checked == true) {
            //        $scope.checkedUsers.push(order.recordId);
            //    }
            //})

            $scope.message = "Are you sure you want to delete sales order mapping for selected orders ";
            $scope.isSuccess = false;
            $('#deleteMultipleCompanyOrderPopup').modal();
        };
        //END OF POP-UP TO DELETE COMPANY ORDER MAPPING

        //DELETING end-user mapping
        $scope.deleteEndUserMapping = function () {
            var token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
            var Ids = '';
            angular.forEach($scope.checkedUsers, function (user, index) {
                Ids = Ids + user + ',';
            });
            var deleteUser = new FormData();
            deleteUser.append("CustomerId", Ids);
            deleteUser.append("__RequestVerificationToken", token);
            companyData.deleteEndUserMapping(deleteUser).then(function (resp) {
                if (resp.data.isValid) {
                    $scope.message = "Customer User successfully deleted";  //resp.data.message;
                    $scope.isSuccess = true;
                    $scope.getCompanyEndUsers($scope.model.filter);
                    $scope.isVisible = true;
                    $scope.showSingleDelete = false;

                }
            })
                .catch(function () {

                });
        };

        //DELETING company(sales) order mapping
        $scope.deleteCompanyOrderMapping = function () {
            var token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
            var Ids = '';
            angular.forEach($scope.toBeUnMapped, function (user, index) {
                Ids = Ids + user + ',';
            });
            var deleteMapping = new FormData();
            deleteMapping.append("recordIds", Ids);
            deleteMapping.append("__RequestVerificationToken", token);
            companyData.deleteCompanyOrderMapping(deleteMapping).then(function (resp) {
                if (resp.data.isValid) {
                    $scope.message = resp.data.message;
                    $scope.isSuccess = true;
                    $scope.getCompanyOrders($scope.model.filter);
                    $scope.isVisible = true;
                    $scope.showSingleDelete = false;
                }
            })
                .catch(function () {

                });
        };

        $scope.getPaginatedUsers = function () {
            $scope.getCompanyEndUsers($scope.model.filter);
        };


        $scope.clearOrderSearch = function () {
            $scope.model.filter.salesOrderIds = null;
            $scope.model.selectedCompany = null;
            $scope.model.companyName = null;
            $scope.model.filter.selectedCompany = null;
            $scope.filterCompanyOrders();
        };

        $scope.clearCompanySearch = function () {
            $scope.model.filter.selectedCompany = null;
            $scope.getCompanyEndUsers();
        };

        $scope.hideSearchBar = function () {
            $('#search-xs').removeClass('in');
        };

        $scope.hideEditForEndUser = function (checked) {
            var itemSelected = false;
            angular.forEach($scope.model.endUsers, function (user, index) {
                if (user.checked == true) {
                    itemSelected = true;
                }
            });
            if (itemSelected) {
                $scope.isVisible = false;
                $scope.showSingleDelete = true;
            }
            else {
                $scope.isVisible = true;
                $scope.showSingleDelete = false;
            }
        };

        $scope.hideEditForSalesOrder = function () {
            $scope.selectedUser;
            var itemSelected = false;
            angular.forEach($scope.model.companyOrders, function (user, index) {
                if (user.checked == true) {
                    if (!$scope.checkedUsers.includes(user.recordId)) {
                        $scope.checkedUsers.push(user.recordId);

                    }
                    itemSelected = true;
                }
                else {
                    if ($scope.checkedUsers.includes(user.recordId)) {
                        index = $scope.checkedUsers.indexOf(user.recordId);
                        if (index >= 0) {
                            $scope.checkedUsers.splice(index, 1);
                        }
                    }

                }
            });
            if (itemSelected == true || $scope.checkedUsers.length != 0) {
                $scope.isVisible = false;
                $scope.showSingleDelete = true;
            }
            else {
                $scope.isVisible = true;
                $scope.showSingleDelete = false;
            }
        };

        $scope.refreshCompanies = function () {
            companyData.refreshCompanies().then(function (resp) {
                if (resp.data.isValid) {
                    $scope.model.companies = resp.data.data;
                    $scope.refreshCompanyModalTitle = "Refresh Companies";
                    //if (resp.data.message == "EmptyCustomers") {
                    $scope.refreshCompanyModalMessage = "Company list has been successfully update. If you cannot find a particular company listed, please reach out to support.";
                    //}
                    //else {
                    //    $scope.refreshCompanyModalMessage = "Companies Refreshed Successfully";
                    //}
                    $('#initRefreshCompanyModal').modal('show');
                }
            })
                .catch(function () {

                });
        };

        $scope.getPaginatedSubscriptions = function () {
            //if ($scope.model.filter.companyId == null && $scope.subsCompanyId != null)
            //    $scope.model.filter.companyId = $scope.subsCompanyId.toString();
            if ($scope.model.filter.endCustomerId == null && $scope.subsEndCustomerId != null)
                $scope.model.filter.endCustomerId = $scope.subsEndCustomerId;
            if ($scope.model.filter.endCustomerId == "")
                return;
            $scope.model.filter.doRefresh = false;
            if ($scope.model.filter.endCustomerId != $scope.model.endCustomerId) {
                $scope.model.filter.doRefresh = true;
            }
            companyData.getPaginatedSubscriptions($scope.model.filter).then(function (resp) {
                //$scope.company = $scope.model.filter.companyName;
                $scope.model.subscriptionList = resp.data.subscriptionList;
                $scope.model.filter.companyName = resp.data.filter.companyName;
                $scope.model.endCustomerId = resp.data.filter.endCustomerId;
                $scope.showTableHeading = true;
                $scope.model.subscriptionList.length = resp.data.subscriptionList.length;
                if ($scope.model.subscriptionList.length > 0) {
                    $scope.showMobileView = true;
                }

            })

                .catch(function () {
                });

        };

        $scope.mapAllOrders = function (mappingType) {

            //if ($scope.model.filter.companyId == null && $scope.subsCompanyId != null)
            //    $scope.model.filter.companyId = $scope.subsCompanyId.toString();
            if ($scope.model.filter.endCustomerId == null && $scope.subsEndCustomerId != null)
                $scope.model.filter.endCustomerId = $scope.subsEndCustomerId;
            if ($scope.model.filter.endCustomerId == "")
                return;
            var endCustomerId = $scope.model.filter.endCustomerId;
            //var companyName = $scope.model.filter.companyName;
            companyData.saveAllCompanyMapping(endCustomerId, mappingType).then(function (resp) {
                if (resp.data.isValid) {
                    $('#successModal').modal('show');
                    $scope.successModalMessage = resp.data.message;
                    $scope.toBeMapped = [];
                    $scope.toBeUnMapped = [];
                    $scope.getPaginatedSubscriptions();
                }
                else {
                    $('#successModal').modal('show');
                    $scope.successModalMessage = resp.data.message;

                }

            }).catch(function () {

            });

        }

        $scope.SaveMapping = function () {

            var subscriptions = $scope.model.subscriptionList;
            angular.forEach($scope.model.subscriptionList, function (subscription, index) {
                if (subscription.mapping == true) {
                    if (!$scope.toBeMapped.indexOf(subscription.orderNumber && subscription.sku) !== -1) {
                        $scope.toBeMapped.push({ orderNumber: subscription.orderNumber, sku: subscription.sku, endCustomerId: $scope.model.filter.endCustomerId });
                        $('#successModal').modal('show');
                    }

                }

                if (subscription.changedStatus) {
                    if (!$scope.toBeUnMapped.indexOf(subscription.orderNumber && subscription.sku) !== -1) {
                        $scope.toBeUnMapped.push({ orderNumber: subscription.orderNumber, sku: subscription.sku, endCustomerId: $scope.model.filter.endCustomerId });
                        subscription.changedStatus = false;

                    }

                }
            });
            companyData.saveMapping($scope.toBeUnMapped, $scope.toBeMapped).then(function (resp) {
                if (resp.data.isValid) {
                    $('#successModal').modal('show');
                    $scope.successModalMessage = resp.data.message;
                    $scope.toBeMapped = [];
                    $scope.toBeUnMapped = [];
                    $scope.getPaginatedSubscriptions();
                    $scope.checked = false;
                }
                else {
                    $('#successModal').modal('show');
                    $scope.successModalMessage = resp.data.message;

                }

            }).catch(function () {

            });
        };

        $scope.initSubscriptionDetail = function () {
            $("#initSubscriptionDetailModal").modal('hide');
            companyData.updateSubscriptionDetail().then(function (resp) {
                var response = resp.data;
                if (response.isValid == true) {
                    $("#initSubscriptionDetailModal").modal();
                    $scope.SubscriptionDetailModalTitle = "Subscriptions Status:  ";
                    $scope.SubscriptionDetailModalMessage = "Your Subscriptions List has been succesfully updated from StreamOne"
                    $scope.initSubscriptionSuccess = true;
                    $scope.getPaginatedSubscriptions();
                }
                else {
                    $("#initSubscriptionDetailModal").modal();
                    $scope.SubscriptionDetailModalTitle = "Subscriptions Status:  ";
                    $scope.SubscriptionDetailModalMessage = response.message;
                    $scope.initSubscriptionSuccess = true;
                }
            })
                .catch(function () {

                });
        };

        $scope.initMapping = function () {
            $scope.subsCompanyId = $scope.model.filter.companyId;
            $scope.subsEndCustomerId = $scope.model.filter.endCustomerId;
            angular.forEach($scope.model.subscriptionList, function (item) {
                item.mapping = false;
            });
        };

        $scope.getFirstTimeSubscriptions = function () {
            if ($scope.model.filter.endCustomerId == null)
                return false;

            $scope.subsCompanyId = $scope.model.filter.companyId;
            $scope.subsEndCustomerId = $scope.model.filter.endCustomerId;
            $scope.model.endCustomerId = $scope.model.filter.endCustomerId;
            //check if database is empty only then call get all subscriptions
            companyData.checkDatabase().then(function (resp) {
                var response = resp.data;
                if (response == "True") {
                    $scope.initSubscriptionDetail();
                }
            })
                .catch(function () {

                });
        };

        $scope.initParametersOnLoad = function () {
            $timeout(function () { $scope.loadSubscriptionOnLoad(); }, 300);
        };

        $scope.loadSubscriptionOnLoad = function () {
            if ($scope.model.filter.endCustomerIdOptional != null) {
                $scope.model.filter.endCustomerId = $scope.model.filter.endCustomerIdOptional;
                $scope.getPaginatedSubscriptions();
            }
        };

        $scope.showSaveMarkupModal = function () {
            $scope.saveMarkUpType = 1;
            $("#saveCompanyLevelMarkUp").modal();
        };

        $scope.showRemoveMarkupModal = function () {
            $scope.saveMarkUpType = 0;
            $("#saveCompanyLevelMarkUp").modal();
        };

        $scope.saveMarkup = function (markup, company, saveMarkUpType) {
            if (saveMarkUpType == 1) {
                markup.company = company;
                markup.endCustomerId = $scope.model.filter.endCustomerId;
                companyData.saveMarkup(markup).then(function (resp) {
                    if (resp) {
                        $scope.CompanyLevelMarkUpSuccessMessage = "Changes updated Successfully"
                    }
                    else {
                        $scope.CompanyLevelMarkUpSuccessMessage = "Changes updation failed"
                    }
                    $("#CompanyLevelMarkUpSuccess").modal();
                    $scope.getPaginatedSubscriptions();
                    $scope.selectedSubscriptionForMarkUp = {};
                })
                    .catch(function () {
                    });
            }
            if (saveMarkUpType == 0) {
                if (markup == null) { markup = $scope.removeMarkupModel; }
                markup.company = company;
                markup.endCustomerId = $scope.model.filter.endCustomerId;
                companyData.removeMarkup(markup).then(function (resp) {
                    if (resp) {
                        $scope.CompanyLevelMarkUpSuccessMessage = "Changes updated Successfully"
                    }
                    else {
                        $scope.CompanyLevelMarkUpSuccessMessage = "Changes updation failed"
                    }
                    $("#CompanyLevelMarkUpSuccess").modal();
                    $scope.getPaginatedSubscriptions();
                    $scope.selectedSubscriptionForMarkUp = {};
                })
                    .catch(function () {
                    });
            }
        };

        //$scope.enableSaveButton = function (subscription) {
        //    if ((subscription.seatLimit == null && (isNaN(parseFloat(subscription.markUpPercentage)) || subscription.taxStatus == null)) ||
        //        (subscription.seatLimit != null && ((isNaN(parseFloat(subscription.markUpPercentage)) && subscription.taxStatus != null) || (!isNaN(parseFloat(subscription.markUpPercentage)) && subscription.taxStatus == null)))) {
        //        $scope.showEdit = true;
        //    }

        //    else {
        //        $scope.showEdit = false;
        //    }
        //}
        $scope.checkCompanyTable = function () {
            companyData.checkCompanyTable().then(function (resp) {
                var response = resp.data;
                if (response == "True") {
                    $scope.refreshCompanies();
                }
            }).catch(function () {

            })
        }
        $scope.saveSelectedData = function (subscription) {
            if ((subscription.seatLimit == null && (isNaN(parseFloat(subscription.markUpPercentage)) || subscription.taxStatus == null)) ||
                (subscription.seatLimit != null && ((isNaN(parseFloat(subscription.markUpPercentage)) && subscription.taxStatus != null) || (!isNaN(parseFloat(subscription.markUpPercentage)) && subscription.taxStatus == null)))) {
                $scope.showEdit = true;
            }
            else {
                $scope.showEdit = false;
            }
            $scope.oldData = angular.copy(subscription);
            angular.forEach($scope.model.subscriptionList, function (subscriptions, index) {
                if (subscriptions.subscriptionId != subscription.subscriptionId) {
                    subscriptions.disableOtherEdits = false;
                }
            });
        }

        $scope.getOldData = function (subscription) {
            angular.forEach($scope.model.subscriptionList, function (subscriptions, index) {
                subscriptions.disableOtherEdits = true;

            });

            if (subscription.subscriptionId == $scope.oldData.subscriptionId) {
                subscription.markUpPercentage = $scope.oldData.markUpPercentage;
                subscription.salesPrice = $scope.oldData.salesPrice;
                subscription.seatLimit = $scope.oldData.seatLimit;
                subscription.taxStatus = $scope.oldData.taxStatus;
            }
        }


        $scope.SubscriptionDetailModal = function () {
            $scope.SubscriptionDetailModalTitle = "Get Subscriptions :  ";
            $scope.SubscriptionDetailModalMessage = "Are you sure you want to update your Subscriptions List from StreamOne? Do you have new subscriptions in StreamOne that don't show up in the App? The process can take minutes depending on the number of your subscriptions you manage. Please confirm before proceeding."
            $("#initSubscriptionDetailModal").modal();

            //$scope.initSubscriptionSuccess = true;
        }
        $scope.synchronizeSeatLimit = function (subscriptions) {
            if ((subscriptions.seatLimit == null && (isNaN(parseFloat(subscriptions.markUpPercentage)) || subscriptions.taxStatus == null)) ||
                (subscriptions.seatLimit != null && ((isNaN(parseFloat(subscriptions.markUpPercentage)) && subscriptions.taxStatus != null) || (!isNaN(parseFloat(subscriptions.markUpPercentage)) && subscriptions.taxStatus == null)))) {
                $scope.showEdit = true;
            }

            else {
                $scope.showEdit = false;
            }
        }

        $scope.selectAll = function (checkStatus) {
            if (checkStatus) {
                $scope.checked = true;
                angular.forEach($scope.model.subscriptionList, function (subscription) {
                    if (subscription.mappingStatus != "MAPPED" && checkStatus) {
                        subscription.changedStatus = true;
                        subscription.mapping = true;
                    }
                    subscription.mappingStatus = "NOTMAPPED";
                });
            }
            else {
                $scope.checked = false;
                angular.forEach($scope.model.subscriptionList, function (subscription) {
                    subscription.mappingStatus = "NOTMAPPED";
                    subscription.changedStatus = true;
                });
            }

        }
        $scope.synchronizeMarkUp = function (dynamic, subscriptions, flag) {
            var currentObj;
            // var currentObj = $scope.model.subscriptionList.find(i => i.subscriptionId == subscriptions.subscriptionId);
            angular.forEach($scope.model.subscriptionList, function (subscription, index) {
                if (subscription.subscriptionId == subscriptions.subscriptionId) {
                    currentObj = subscriptions;
                }
            });

            if (flag == 0) //flag is zero, means MarkUp Percentage is recieved and calculate salesprice
            {
                // currentObj.markUpPercentage = parseFloat(dynamic.toFixed(2));
                currentObj.markUpPercentage = Math.round(dynamic * Math.pow(10, 2)) / Math.pow(10, 2);
                var salesprice = parseFloat(subscriptions.unitPrice) + ((dynamic / 100) * (parseFloat(subscriptions.unitPrice)));
                salesprice = Math.round(salesprice * Math.pow(10, 2)) / Math.pow(10, 2);
                angular.forEach($scope.model.subscriptionList, function (subscription, index) {
                    if (subscription.subscriptionId == subscriptions.subscriptionId) {
                        subscription.salesPrice = salesprice;
                    }
                });

            }
            else //flag is 1, means salesprice  is recieved and calculate Markup Percentage
            {
                // currentObj.salesPrice = parseFloat(dynamic.toFixed(2));
                currentObj.salesPrice = Math.round(dynamic * Math.pow(10, 2)) / Math.pow(10, 2);
                var markUp = ((dynamic - parseFloat(subscriptions.unitPrice)) / parseFloat(subscriptions.unitPrice)) * 100;
                markUp = Math.round(markUp * Math.pow(10, 2)) / Math.pow(10, 2);
                angular.forEach($scope.model.subscriptionList, function (subscription, index) {
                    if (subscription.subscriptionId == subscriptions.subscriptionId) {
                        subscription.markUpPercentage = markUp;
                    }
                });
            }
        }
    }



})();