import ballerina/http;
import ballerina/io;
import ballerina/test;

@test:Config {}
function testBindJsonPerson() {
    http:Client clientEndpoint = new("http://localhost:9090/PersonService");

    var jsonData = "{ Name: 'Bruce Snyder', Age: 48, FavoriteBeers: {1: 'Belgian', 2: 'IPA', 3: 'Sour' }}";
    var response = clientEndpoint->post("/bindJson", jsonData);
    
    if (response is http:Response) {
        var payload = response.getTextPayload();
        if (payload is string) {
            io:println(payload);
        } else {
            io:println(payload.detail());
        }
    } else {
        io:println(response.detail());
    }
}