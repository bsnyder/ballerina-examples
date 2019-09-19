import ballerina/http;
import ballerina/log;

type Person record {
    string name;
    int age;
    map<json> favoriteBeers;
};

// Exercise this service using the following:
// $ curl http://localhost:9090/PersonService/bindJson -d '{ "Name": "Bruce Snyder", "Age": 48, "FavoriteBeers": {"1": "Belgian", "2": "IPA", "3": "Sour" }}' -H "Content-Type:application/json"
// 
@http:ServiceConfig {}
service PersonService on new http:Listener(9090) {

    @http:ResourceConfig {
        methods: ["POST"],
        body: "person",
        consumes: ["application/json"]
    }
    resource function bindJsonPerson(http:Caller caller, http:Request req, Person person) {
        http:Response response = new();
        response.setPayload({name: <@untainted> person.name,
                age: <@untainted> person.age,
                favoriteBeers: <@untainted> person.favoriteBeers});
        var result = caller->respond(response);
        if (result is error) {
            log:printError("An error occurred", result);
        } else {
            log:printInfo("Success!");
        }
    }
}
