/**
 * Created with IntelliJ IDEA.
 * User: gbougeard
 * Date: 17/11/12
 * Time: 01:22
 * To change this template use File | Settings | File Templates.
 */
function PicklistCtrl($scope, $http) {
    $scope.url = '/comments/'; // The url of our search

    $scope.src = [];
    $scope.trg = [];



    $scope.loadData = function(id){
        $scope.loadSrc(id);
        $scope.loadTrg(id);
    };

    // The function that will be executed on button click (ng-click="search()")
    $scope.loadSrc = function (id) {

        console.log("loadSrc", id);

        $scope.url = '/steps.json/src?id='+id;

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        $http.get($scope.url, { "data": $scope.keywords}).
            success(function (data, status) {
                $scope.status = status;
                $scope.src = data;
            })
            .
            error(function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
            });
    };

    // The function that will be executed on button click (ng-click="search()")
    $scope.loadTrg = function (id) {

        console.log("loadTrg", id);

        $scope.url = '/steps.json/trg?id='+id;

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        $http.get($scope.url, { "data": $scope.keywords}).
            success(function (data, status) {
                $scope.status = status;
                $scope.trg = data;
            })
            .
            error(function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
            });
    };

    // The function that will be executed on button click (ng-click="search()")
    $scope.stepSucceed = function (step) {
        console.log("stepSucceed");
        console.log(step);
        var url = '/testStep/ok/';
        step.status = "OK";

        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        $http.post(url, step).
            success(function (data, status) {
                $scope.status = status;

            })
            .
            error(function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
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

    $scope.up = function () {
        console.log("up", $("#trg"), $scope.srcSelected, $scope.trgSelected);

    };
    $scope.down = function () {
        console.log("down", $("#trg"), $scope.srcSelected, $scope.trgSelected);
    };
    $scope.add = function () {
        console.log("add", $("#src"), $scope.srcSelected, $scope.trgSelected);
        $scope.trg.push($scope.srcSelected);
    };
    $scope.remove = function () {
        console.log("remove", $scope.src, $scope.trgSelected);
        $scope.src.push($scope.trgSelected);
        console.log("remove after", $scope.src, $scope.trgSelected);
    };

    // The function that will be executed on button click (ng-click="search()")
    $scope.stepFailed = function () {


        url = '/testStep/ko/';
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

        $scope.failingStep = false;
    };

    // The function that will be executed on button click (ng-click="search()")
    $scope.saveComment = function (comment) {

        console.log("saveComment", comment);
        comment.texte= $("#texte").val();
        // Display views
        comment.testStepId = $scope.stepId;

        var url = '/comments/new';
        // Create the http post request
        // the data holds the keywords
        // The request is a JSON request.
        $http.post(url, comment).
            success(function (data, status) {
                $scope.status = status;
                $scope.data = data;

                if ($scope.failingStep) {
                    url = '/testStep/ko/';
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

                    $scope.failingStep = false;
                }

            })
            .
            error(function (data, status) {
                $scope.data = data || "Request failed";
                $scope.status = status;
            });


    };

}