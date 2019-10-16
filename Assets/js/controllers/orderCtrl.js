(function () {
    'use strict';
    app.controller('orderCtrl', orderCtrl);
    orderCtrl.$inject = ["$scope", "orderData", "$rootScope", "$timeout"];
    function orderCtrl($scope, orderData, $rootScope, $timeout) {
        $scope.isAuthorized = false;
        $scope.endUserCompany = {};
        $scope.totalUserSubscriptions = -1;
        $scope.showTableHeading = false;
        $scope.userMappingExists = true;

        $scope.showEndUserPopup = function () {
            $("#endUserPopup").modal();
            $scope.isSuccess = false;

        };
        $scope.updateOrderQuantity = function (orderLine, updateType) {
            if (updateType > 0) {
                orderLine.quantity = parseInt(orderLine.quantity) + 1;
            }
            else if (orderLine.quantity > 0)
                orderLine.quantity = parseInt(orderLine.quantity) - 1;
        };
        $scope.confirmOrderQuantityUpdate = function (orderNumber, isReseller, orderLine, addOn) {
            if (orderLine.lineStatus != "active") {
                $("#NotActiveSubscription").modal();
                $scope.NotActiveSubscriptionMessage = "Your Subscription is not Active, Please contact your Administrator.";
            }
            else {
                var quantity = 0, sku = '', type = '', originalQuantity = '';
                if (isReseller || addOn) {
                    $scope.isSuccess = false;
                    $scope.updateOrderLine = orderLine;
                    $scope.updateAddOn = addOn;
                    quantity = 0, sku = '', type = '', originalQuantity = '';
                    if (addOn) {
                        type = "addOn";
                        quantity = addOn.quantity;
                        sku = addOn.sku;
                        originalQuantity = addOn.originalQuantity;
                    }
                    else {
                        quantity = orderLine.quantity;
                        sku = orderLine.sku;
                        originalQuantity = orderLine.originalQuantity;
                    }
                    if (addOn) {
                        $("#confirmationAddOnPopup").modal();
                    }
                    else {
                        $scope.popupTitle = 'Update Order Quantity';
                        $("#confirmationPopup").modal();
                    }
                    $scope.message = "Are you sure you want to change order" + type + " quantity of SKU " + sku + " from " + originalQuantity + " to " + quantity + " ?";
                }
                else //if not reseller than calculate timestamp and check for seat limit
                {
                    $scope.isSuccess = false;
                    $scope.updateOrderLine = orderLine;
                    //$scope.updateAddOn = addOn;
                    quantity = 0, sku = '', type = '', originalQuantity = '';
                    quantity = orderLine.quantity;
                    sku = orderLine.sku;
                    originalQuantity = orderLine.originalQuantity;
                    $scope.orderNumber = orderNumber;
                    $scope.popupTitle = 'Update Quantity';
                    $("#confirmationPopupForEndUser").modal();
                    $scope.confirmationPopupMessageForEndUser = "Are you sure you want to change order" + type + " quantity of SKU " + sku + " from " + originalQuantity + " to " + quantity + " ?";
                    //$scope.isUserAuthorizeToIncreaseSeat(orderLine, orderNumber);
                }
                $scope.orderLineToUpdate = { sku: orderLine.sku, skuName: orderLine.skuName, originalQuantity: orderLine.originalQuantity, quantity: orderLine.quantity, seatCounter: orderLine.seatCounter};
            }
        };

        $scope.setVariables = function () {
            $scope.logHistory = true;
            $scope.Orderline = false;
            $scope.showDownload = true;
            $scope.more = false;
        };

        $scope.saveOrderQuantity = function (order, isReseller) {
            if (isReseller) {
                var token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
                var modifyorder = new FormData();
                modifyorder.append("companyName", order.company.companyName),
                    modifyorder.append("endUserEmail", order.endUserEmail),
                    modifyorder.append("endUserName", order.endUserName),
                    modifyorder.append("action", "units"),
                    modifyorder.append("orderNumber", order.orderNumber),
                    modifyorder.append("sku", $scope.orderLineToUpdate.sku),
                    modifyorder.append("skuName", $scope.orderLineToUpdate.skuName),
                    modifyorder.append("originalQuantity", $scope.orderLineToUpdate.originalQuantity),
                    modifyorder.append("newQuantity", $scope.orderLineToUpdate.quantity),
                    modifyorder.append("metaData.firstName", $scope.user.firstName),
                    modifyorder.append("metaData.lastName", $scope.user.lastName),
                    modifyorder.append("metaData.isEndCustomer", $scope.user.isEndCustomer),
                    modifyorder.append('__RequestVerificationToken', token);

                //make order modification call
                orderData.modifyOrderDetail(modifyorder).then(function (resp) {
                    if (resp.data.isValid) {
                        $scope.popupTitle = 'Quantity Updated';
                        $scope.message = "Your request has been placed successfully. Please wait a few seconds for quantity update.";
                        $scope.orderLineToUpdate.origianlQuantity = $scope.orderLineToUpdate.quantity;
                        $timeout(function () {
                            $scope.refreshOrderDetail();
                        }, 13000);
                    }
                    else {
                        if (resp.data.message == 'Agreement is not present please sign the agreement and provide the details.') {
                            $scope.message = "Seat Change was not possible. Microsoft Customer Agreement must first be accepted.";
                        } else {
                            $scope.message = "Something went wrong. Try Again.";
                        }

                    }
                    $scope.isSuccess = true;
                })
                    .catch(function () {

                    });
            }
            else {

                orderData.isUserAuthorizeToIncreaseSeat($scope.orderLineToUpdate, $scope.orderNumber, $scope.orderLineToUpdate.originalQuantity).then(function (resp) {
                    if (resp.data.toLowerCase() == "true" || $scope.orderLineToUpdate.quantity < $scope.orderLineToUpdate.originalQuantity) {
                        var token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
                        var modifyorder = new FormData();
                        modifyorder.append("companyName", order.company.companyName),
                            modifyorder.append("endUserEmail", order.endUserEmail),
                            modifyorder.append("endUserName", order.endUserName),
                            modifyorder.append("action", "units"),
                            modifyorder.append("orderNumber", order.orderNumber),
                            modifyorder.append("sku", $scope.orderLineToUpdate.sku),
                            modifyorder.append("skuName", $scope.orderLineToUpdate.skuName),
                            modifyorder.append("originalQuantity", $scope.orderLineToUpdate.originalQuantity),
                            modifyorder.append("newQuantity", $scope.orderLineToUpdate.quantity),
                            modifyorder.append("metaData.firstName", $scope.user.firstName),
                            modifyorder.append("metaData.lastName", $scope.user.lastName),
                            modifyorder.append("metaData.isEndCustomer", $scope.user.isEndCustomer),
                            modifyorder.append('__RequestVerificationToken', token);

                        //make order modification call
                        orderData.modifyOrderDetail(modifyorder).then(function (resp) {
                            if (resp.data.isValid) {
                                $scope.popupTitle = 'Quantity Updated';
                                $scope.confirmationPopupMessageForEndUser = "Your request has been placed successfully. Please wait a few seconds for quantity update.";
                                $scope.orderLineToUpdate.origianlQuantity = $scope.orderLineToUpdate.quantity;
                                if ($scope.orderLineToUpdate.quantity > $scope.orderLineToUpdate.originalQuantity) {
                                    orderData.updateSeatCountForDay($scope.orderLineToUpdate, $scope.orderNumber, $scope.orderLineToUpdate.originalQuantity).then(function (resp) {
                                    });
                                }
                                $timeout(function () {
                                    $scope.refreshOrderDetail();
                                }, 8000);

                            }
                            else {
                                $scope.message = "Something went wrong. Try Again.";
                            }
                            $scope.isSuccess = true;
                        })
                            .catch(function () {

                            });
                    }
                    else {
                        // $("#seatExhaustedLimit").modal();
                        //$scope.seatExhaustedLimitMessage = "You have reached the maximum amount of seats that can be increased per day. Wait for 24 hours to purchase more or contact us manual purchase. ";
                        $scope.popupTitle = 'Seat Limit : ';
                        //$("#confirmationPopupForEndUser").modal();
                        $scope.confirmationPopupMessageForEndUser = "You have reached the maximum amount of seats that can be increased per day. Wait for 24 hours to purchase more or contact us manual purchase. ";
                        $scope.isSuccess = true;
                        $timeout(function () {
                            $scope.refreshOrderDetail();
                        }, 8000);
                    }

                }).catch(function (resp) {

                });

            }

        };
        $scope.updateAddOnQuantity = function (addOn, updateType) {
            if (updateType > 0) {
                addOn.quantity = parseInt(addOn.quantity) + 1;
            }
            else if (addOn.quantity > 0)
                addOn.quantity = parseInt(addOn.quantity) - 1;
        };
        $scope.saveAddOnQuantity = function (order) {

            var orderLine = $scope.updateOrderLine;
            var addOn = $scope.updateAddOn;
            var modifyAddons = {};
            //$scope.model.modifyAddOnsDetail.modifyAddons = {};
            //$scope.model.modifyAddOnsDetail.modifyAddons.orderNumber = order.orderNumber;
            //$scope.model.modifyAddOnsDetail.modifyAddons.endUserEmail = order.endUserEmail;
            //$scope.model.modifyAddOnsDetail.modifyAddons.endUserName = order.endUserName;
            //$scope.model.modifyAddOnsDetail.modifyAddons.baseSubscription = orderLine.sku;
            //$scope.model.modifyAddOnsDetail.modifyAddons.addons = [];
            //$scope.model.modifyAddOnsDetail.modifyAddons.addons.push({
            //    action: "units",
            //    addOnSku: addOn.sku,
            //    newQuantity: addOn.quantity,
            //    originalQuantity: addOn.originalQuantity,
            //    skuName: addOn.skuName
            //});
            //$scope.model.modifyAddOnsDetail.modifyAddons.metaData = {
            //    firstName: $scope.user.firstName,
            //    lastName: $scope.user.lastName,
            //    isEndCustomer: $scope.user.isEndCustomer
            //};

            var token = angular.element('input[name="__RequestVerificationToken"]').attr('value');
            var modifyAddOnsDetail = new FormData();
            modifyAddOnsDetail.append("modifyAddons.companyName", order.company.companyName),
                modifyAddOnsDetail.append("modifyAddons.orderNumber", order.orderNumber),
                modifyAddOnsDetail.append("modifyAddons.endUserEmail", order.endUserEmail),
                modifyAddOnsDetail.append("modifyAddons.endUserName", order.endUserName),
                modifyAddOnsDetail.append("modifyAddons.orderNumber", order.orderNumber),
                modifyAddOnsDetail.append("modifyAddons.baseSubscription", orderLine.sku),
                modifyAddOnsDetail.append("modifyAddons.addon.action", "units"),
                modifyAddOnsDetail.append("modifyAddons.addon.addOnSku", addOn.sku),
                modifyAddOnsDetail.append("modifyAddons.addon.newQuantity", addOn.quantity),
                modifyAddOnsDetail.append("modifyAddons.addon.originalQuantity", addOn.originalQuantity),
                modifyAddOnsDetail.append("modifyAddons.addon.skuName", addOn.skuName),
                modifyAddOnsDetail.append("modifyAddons.metaData.firstName", $scope.user.firstName),
                modifyAddOnsDetail.append("modifyAddons.metaData.lastName", $scope.user.lastName),
                modifyAddOnsDetail.append("modifyAddons.metaData.isEndCustomer", $scope.user.isEndCustomer),
                modifyAddOnsDetail.append('__RequestVerificationToken', token);



            //make order addOn modification call
            orderData.modifyOrderAddOns(modifyAddOnsDetail).then(function (resp) {
                if (resp.data.isValid) {
                    $scope.message = "Your request has been placed successfully. Please wait a few seconds for quantity update.";
                    $scope.updateAddOn.origianlQuantity = $scope.updateAddOn.quantity;
                    $timeout(function () {
                        $scope.refreshOrderDetail();
                    }, 13000);
                }
                else {
                    $scope.message = "Something went wrong. Try Again.";
                }
                $scope.isSuccess = true;
            })
                .catch(function () {

                });
        };

        $scope.getOrders = function () {
            $rootScope.hideLoader = true;
            orderData.getOrders($scope.model.filter).then(function (resp) {
                $scope.model.orders = resp.data.orders;
                $scope.model.filter = resp.data.filter;
                $scope.isSuccess = true;
                $scope.initializingSalesOrders = false;
            })
                .catch(function () {
                });
        };
        $scope.initSalesOrder = function () {
            $scope.initializingSalesOrders = true;
            //$scope.getOrders();
            $scope.updateProductCall();
        };

        $scope.initOrderDetail = function (orderNo, userName, userEmail, isReseller) {
            $scope.isAnnualSubscription(orderNo.orderDetail);
            $scope.refreshOrderDetail();
            $scope.updateProductCall();
            $scope.user = { firstName: userName, lastName: userEmail, isEndCustomer: isReseller };
        };

        $scope.refreshOrderDetail = function () {
            $scope.refreshingOrderDetail = true;
            orderData.refereshOrderDetail($scope.model.orderDetail.orderNumber).then(function (resp) {
                $scope.model.orderDetail = resp.data.orderDetail;
                $scope.isSuccess = true;
                $scope.refreshingOrderDetail = false;
                angular.forEach($scope.model.orderDetail.lines, function (line) {
                    var index;
                    //var index = $scope.lines.findIndex(i => i.sku == line.sku);
                    angular.forEach($scope.lines, function (item, i) {
                        if (item.sku == line.sku) {
                            index = i;
                        }
                    });
                    if (index >= 0) {
                        line.unitPrice = $scope.lines[index].unitPrice;
                        line.total = $scope.lines[index].unitPrice * line.quantity;
                        line.salesPrice = $scope.lines[index].salesPrice;
                        line.totalSalesPriceEndUser = $scope.lines[index].salesPrice * line.quantity;
                        line.taxStatus = $scope.lines[index].taxStatus;
                        line.seatLimit = $scope.lines[index].seatLimit;
                        line.seatLimitStartTime = $scope.lines[index].seatLimitStartTime;
                        line.seatLimitEndTime = $scope.lines[index].seatLimitEndTime;
                        line.seatCounter = $scope.lines[index].seatCounter;
                    }
                });
                angular.forEach($scope.model.orderDetail.lines, function (line) {
                    if (line.lineStatus != 'active') {
                        line.activationStatus = false;
                    }
                    else {
                        line.activationStatus = true;
                    }

                    angular.forEach($scope.model.orderDetail.lines, function (line) {
                        angular.forEach($scope.UrlDetails, function (Urlline) {
                            if (line.skuName == Urlline.skuName || line.manufacturerPartNumber == Urlline.manufacturingPartNumber) {
                                line.imageUrl = Urlline.imageUrl;
                            }
                        });
                    });
                });
            })
                .catch(function () {

                });
        };
        $scope.updateProductCall = function () {
            $rootScope.hideLoader = true;
            orderData.updateProductInfo().then(function (resp) {
            })
                .catch(function () {
                });
        };
        $scope.hideSearchBar = function () {
            $('#search-xs').removeClass('in');
        };

        $scope.companies = [];
        $scope.companyList = function (model) {
            for (var i = 0; i < model.orders.length; i++) {
                $scope.companies.push(model.orders[i].company.companyName);
            }
        };
        $scope.getUserSubscriptions = function (endCustomerId) {

            $scope.model.filter.endCustomerId = $scope.company.endCustomerId;
            $scope.userAuthorized = true;
            if ($scope.model.filter.endCustomerId == null) {
                $scope.model.filter.endCustomerId = endCustomerId;
            }
            if ($scope.model.filter.endCustomerId == null)
                return false;
            $scope.totalUserSubscriptions = -1;
            $scope.model.filter.doRefresh = false;
            if ($scope.model.filter.endCustomerId != $scope.model.endCustomerId) {
                $scope.model.filter.doRefresh = true;
            }
            $scope.company.endCustomerId = $scope.model.filter.endCustomerId;
            orderData.getUserSubscriptions($scope.model.filter).then(function (resp) {
                $scope.model.filter.companyName = resp.data.filter.companyName;
                $scope.model.filter.endCustomerId = resp.data.endCustomerId;

                $scope.totalUserSubscriptions = 0;
                $scope.model.endCustomerId = resp.data.filter.endCustomerId;
                if (resp.data.isValid == false && resp.data.message == "End user mapping does not exist") {
                    $scope.userNotMapped = true;
                    $scope.userAuthorized = false;
                }
                else {
                    $scope.userAuthorized = true;
                    $scope.model.subscriptionList = resp.data.subscriptionList;
                    $scope.userNotMapped = false;
                    if (resp.data.subscriptionList.length > 0) {
                        $scope.totalUserSubscriptions = resp.data.subscriptionList[0].totalrecords;
                    }
                }
                $scope.showTableHeading = true;
            })
                .catch(function () {
                });
        };

        $scope.initParametersOnLoad = function () {
            orderData.getEndUserCompanies().then(function (resp) {
                if (resp.data.length == 0) {
                    $scope.userMappingExists = false;
                }
                else {
                    $scope.endUserCompany = resp.data;
                    $scope.userMappingExists = true;
                }
            });

            $timeout(function () { $scope.loadSubscriptionOnLoad(); }, 300);
        };

        $scope.loadSubscriptionOnLoad = function () {
            if ($scope.model.filter.endCustomerIdOptional != null) {
                $scope.model.filter.endCustomerId = $scope.model.filter.endCustomerIdOptional;
                $scope.getUserSubscriptions($scope.model.filter.endCustomerId);
            }
        };

        $scope.setData = function (orderNumber) {
            $scope.logHistory = true;
            $scope.Orderline = false;
            window.location.href = "/Order/DownloadSubscriptionHistory/" + orderNumber;
        };

        $scope.showOrderDetail = function () {
            $scope.logHistory = false;
            $scope.showDownload = false;
            $scope.showMore = true;
            angular.forEach($scope.model.orderDetail.lines, function (line) {
                line.itemLimit = 3;
                line.showMore = true;
                angular.forEach(line.addOns, function (addOn) {
                    addOn.itemLimitAddOn = 3;
                    addOn.showMoreAddOn = true;
                })
            });
            $scope.showMore = true;

        };

        $scope.viewLogHistory = function () {
            $scope.logHistory = true;
            $scope.Orderline = false;
            $scope.showDownload = true;
            $scope.showMore = true;
        };

        $scope.isAnnualSubscription = function (orderDetail) {

            if (orderDetail.lines.length > 0) {
                var manufacturerNo = orderDetail.lines[0].manufacturerPartNumber;
                if (manufacturerNo[manufacturerNo.length - 1].toLowerCase() == "x") {
                    $scope.isAnnual = true;
                }
                else {
                    $scope.isAnnual = false;
                }

            }
        };
        $scope.manageOrderStatus = function (status, sku, endUserName, orderNumber) {
            $scope.activationStatus = status;
            $scope.orderNo = orderNumber;
            $scope.SKU = sku;
            $scope.endUserName = endUserName;
            $("#orderActivationStatusModal").modal();
            $scope.request = true;
            if (status) {
                $scope.manageOrderStatusTitle = "Subscription Status :";
                $scope.manageOrderStatusMessage = "Are you sure you want to activate this subscription?";
            }
            else {
                $scope.manageOrderStatusTitle = "Order Subscription :";
                $scope.manageOrderStatusMessage = "This will suspend the existing subscription, Are you sure?";
            }

        };

        $scope.cancelChangingOrderStatus = function () {
            angular.forEach($scope.model.orderDetail.lines, function (line) {
                if (line.sku == $scope.SKU && $scope.model.orderDetail.orderNumber == $scope.orderNo) {
                    line.activationStatus = !$scope.activationStatus;
                }

            });
        };
        $scope.setOrderStatus = function () {
            angular.forEach($scope.model.orderDetail.lines, function (line) {
                if (line.lineStatus != 'active') {
                    line.activationStatus = false;
                }
                else {
                    line.activationStatus = true;
                }
            });
        };

        $scope.changingOrderStatus = function () {
            var activeSubscription = {};
            activeSubscription.orderNumber = $scope.orderNo;
            activeSubscription.sku = $scope.SKU;
            activeSubscription.activationStatus = $scope.activationStatus;
            activeSubscription.endUserName = $scope.endUserName;

            orderData.changingOrderStatus(activeSubscription).then(function (response) {
                var data = response.data;
                $("#orderActivationStatusModal").modal();
                $scope.request = false;
                $scope.manageOrderStatusTitle = "Subscription Response:";
                if (data.isValid) {
                    if (activeSubscription.activationStatus == true) {
                        $scope.manageOrderStatusMessage = "Your request for activate subscription is currently in process. Thank you, your changes have been saved";
                    }
                    else {
                        $scope.manageOrderStatusMessage = "Your request for Suspend subscription is currently in process. Thank you, your changes have been saved";
                    }

                }
                else {
                    $scope.manageOrderStatusMessage = data.message;
                }
            });
            $timeout(function () {
                $scope.refreshOrderDetail();
            }, 13000);
        };

        $scope.returnPostOrder = function (orderDetail) {
            var postOrder = { orderNumber: orderDetail.orderNumber };
            postOrder.lines = [];
            angular.forEach($scope.model.orderDetail.lines, function (line) {
                var lineToAdd = { sku: line.sku, skuName: line.skuName, manufacturerPartNumber: line.manufacturerPartNumber };
                postOrder.lines.push(lineToAdd);
            });
            return postOrder;
        };

        $scope.initUrlDetails = function (orderDetail) {
            if (orderDetail != null) {
                var postOrder = $scope.returnPostOrder(orderDetail);
                orderData.initUrlDetails(postOrder).then(function (resp) {
                    $scope.UrlDetails = resp.data;

                    angular.forEach($scope.model.orderDetail.lines, function (line) {
                        angular.forEach($scope.UrlDetails, function (Urlline) {
                            if (line.skuName == Urlline.skuName || line.manufacturerPartNumber == Urlline.manufacturingPartNumber) {
                                line.imageUrl = Urlline.imageUrl;
                            }
                        });
                    });
                });
            }
        };

        $scope.initUnitPrice = function (orderDetail) {
            if (orderDetail != null) {
                var postOrder = $scope.returnPostOrder(orderDetail);
                orderData.initUnitPrice(postOrder).then(function (resp) {
                    $scope.lines = resp.data;

                    angular.forEach($scope.model.orderDetail.lines, function (line) {
                        var index;

                        angular.forEach($scope.lines, function (item, i) {
                            if (item.sku == line.sku) {
                                index = i;
                            }
                        });
                        if (index >= 0) {
                            line.unitPrice = $scope.lines[index].unitPrice;
                            line.total = $scope.lines[index].unitPrice * line.quantity;
                            line.salesPrice = $scope.lines[index].salesPrice;
                            line.totalSalesPriceEndUser = $scope.lines[index].salesPrice * line.quantity;
                            line.taxStatus = $scope.lines[index].taxStatus;
                            line.seatLimit = $scope.lines[index].seatLimit;
                            line.seatLimitStartTime = $scope.lines[index].seatLimitStartTime;
                            line.seatLimitEndTime = $scope.lines[index].seatLimitEndTime;
                            line.seatCounter = $scope.lines[index].seatCounter;


                        }
                    });

                }).catch(function () {

                });
            }
        };

        $scope.checkQuanityIfNull = function () {
            angular.forEach($scope.model.orderDetail.lines, function (line) {
                if (line.quantity == '') {
                    line.quantity = 0;
                }
            });
        };

        $scope.getPaginatedSubscriptions = function () {
            $scope.model.filter.doRefresh = false;
            orderData.getUserSubscriptions($scope.model.filter).then(function (resp) {
                if (resp.data.isValid == false && resp.data.message == "End user mapping does not exist") {
                    $scope.userNotMapped = true;
                    $scope.userAuthorized = false;
                }
                else {
                    if (resp.data.subscriptionList.length > 0) {
                        $scope.model.subscriptionList = resp.data.subscriptionList;
                        $scope.userAuthorized = true;
                    }

                    else {
                        $scope.userAuthorized = false;
                        $scope.userNotMapped = false;
                    }
                }

            })

                .catch(function () {
                });

        };

    }
})();

