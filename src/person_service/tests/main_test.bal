import ballerina/http;
import ballerina/io;
import ballerina/test;

@test:Config {}
function testBindJsonPerson() {
    http:Client clientEndpoint = new("http://localhost:9090/PersonService");

    json jsonData = { name: "Bruce Snyder", age: 48, favoriteBeers: {"1": "Belgian", "2": "IPA", "3": "Sour" }};
    var response = clientEndpoint->post("/bindJsonPerson", jsonData);
    
    if (response is http:Response) {
        var payload = response.getJsonPayload();
        test:assertEquals(payload, jsonData);

        if (payload is json) {
            io:println(payload);
        } else {
            io:println(payload.detail());
        }
    } else {
        io:println(response.detail());
    }
}
