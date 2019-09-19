import ballerina/http;
import ballerina/log;

// Exercise this service using the following:
// $ curl http://localhost:9090/hello/sayHello -d ApacheCon
// 
@http:ServiceConfig {}
service hello on new http:Listener(9090) {

    @http:ResourceConfig {
        methods: ["POST"],
        body: "name"
    }
    resource function sayHello(http:Caller caller, http:Request req, string name) {
        http:Response response = new();
        var payload = "Hello, " + name + "!";
        response.setPayload(payload);
        var result = caller->respond(response);

        if (result is error) {
            log:printError("An error occurred", result);
        } else {
            log:printInfo("Success!");
        }
    }
}
