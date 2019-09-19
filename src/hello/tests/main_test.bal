import ballerina/test;
import ballerina/http;
import ballerina/io;

@test:Config {}
function testFunction() {
    http:Client clientEndpoint = new("http://localhost:9090/hello");
    var arg = "ApacheCon";
    var response = clientEndpoint->post("/sayHello", arg);
    
    if (response is http:Response) {
        var payload = response.getTextPayload();
        var testText = "Hello, " + arg + "!";
        test:assertEquals(testText, payload);
        if (payload is string) {
            io:println(payload);
        } else {
            io:println(payload.detail());
        }
    } else {
        io:println(response.detail());
    }
}