/**
 * Created with IntelliJ IDEA.
 * User: gbougeard
 * Date: 17/11/12
 * Time: 01:22
 * To change this template use File | Settings | File Templates.
 */
function CampaignCtrl($scope, $http) {

    // The function that will be executed on button click (ng-click="search()")
    $scope.displayComments = function (step) {

        console.log("displayComments", step.id);
        $scope.step = step;
        $scope.stepId = step.id;

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        jsRoutes.controllers.Comments.view(step.id).ajax({
            data: {data: $scope.keywords},
            success: function (data, status) {
                $scope.status = status;
                $scope.data = data;
                $scope.comments = data; // Show result from server in our <pre></pre> element

                $('#myModal').modal({
                    keyboard: false
                });
                $scope.$digest();
            },
            error: function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
                $scope.$digest();
            }
        });
    };

//    $scope.urlSteps = '/campaigns/scenario/'; // The url of our search
    // The function that will be executed on button click (ng-click="search()")
    $scope.loadSteps = function (idC, idS) {

        var url = '/campaigns/' + idC + '/scenario/' + idS;

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        jsRoutes.controllers.Campaigns.stepsByCampaignScenario(idC, idS).ajax({
            success: function (data, status) {
                $scope.status = status;
                $scope.data = data;
                $scope.steps = data; // Show result from server in our <pre></pre> element
                $scope.$digest();
            },
            error: function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
                $scope.$digest();
            }
        });
    };

// The function that will be executed on button click (ng-click="search()")
    $scope.stepSucceed = function (step) {
        console.log("stepSucceed");
        console.log(step);
        step.status = "OK";

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        jsRoutes.controllers.Campaigns.stepSucceed().ajax({
            data:  JSON.stringify(step),
            contentType: "application/json",
            dataType: "json",
            success: function (data, status) {
                $scope.status = status;
                $scope.$digest();
            },
            error: function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
                $scope.$digest();
            }
        });
    };

// The function that will be executed on button click (ng-click="search()")
    $scope.failStep = function (step) {

        $scope.dlgTitle = "Step failed!";
        $scope.dlgSubTitle = "what happened?";
        $scope.step = step;
        $scope.failingStep = true;

        $scope.step = step;
        $scope.stepId = step.id;
        $('#dlgComment').modal({
            keyboard: false
        })

    };
// The function that will be executed on button click (ng-click="search()")
    $scope.newComment = function () {
        console.log("newComment", $scope.step);
//        $scope.step = step;
        $scope.dlgTitle = "New Comment";
        $scope.dlgSubTitle = "Something to say?";

        $('#dlgComment').modal({
            keyboard: false
        })

    };

// The function that will be executed on button click (ng-click="search()")
    $scope.stepFailed = function () {

        $scope.step.status = "KO";

        jsRoutes.controllers.Campaigns.stepFailed.ajax({
            data:  JSON.stringify(step),
            contentType: "application/json",
            dataType: "json",
            success: function (data, status) {
                $scope.status = status;
                $scope.$digest();
            },
            error: function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
                $scope.$digest();
            }
        });

        $scope.failingStep = false;
    };

// The function that will be executed on button click (ng-click="search()")
    $scope.saveComment = function (comment) {

        console.log("saveComment", comment);
        comment.texte = $("#texte").val();
        // Display views
        comment.testStepId = $scope.stepId;

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        jsRoutes.controllers.Comments.save().ajax({

            data:  JSON.stringify(comment),
            contentType: "application/json",
            dataType: "json",
            success: function (data, status) {
                $scope.status = status;
                $scope.data = data;

                if ($scope.failingStep) {
                    $scope.stepFailed();
                    /*  url = '/testStep/ko/';
                      $scope.step.status = "KO";
                      // Create the http post request
                      // the data holds the keywords
                      // The request is a JSON request.
                      $http.post(url, $scope.step).
                          success(function (data, status) {
                              $scope.status = status;
                              $scope.data = data;

                          })
                          .
                          error(function (data, status) {
                              $scope.data = data || "Request failed";
                              $scope.status = status;
                          });

                      $scope.failingStep = false;*/
                }

            },
            error: function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
            }
        });

    };

}