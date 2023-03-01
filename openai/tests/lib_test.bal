import ballerina/io;
import ballerina/test;

@test:BeforeSuite
function beforeSuiteFunc() {
    io:println("Starting the OpenAI API Client Test Suite");
}

@test:Config {}
function testCompletions() returns error? {
    
    // Client openai = checkpanic new (apikey);
    // CompletionsRequest request = {
    //     model: "text-davinci-003",
    //     prompt: "best way to test openai api client in ballerina",
    //     max_tokens: 5,
    //     temperature: 0.9,
    //     top_p: 1,
    //     n: 1,
    //     'stream: false};
    // CompletionsResponse res = check openai->/completions.post(request);

    // io:println("Suggestion: " + res.choices[0].text);
}

@test:Config {}
function testImageGenerations() returns error? {
    
    // Client openai = checkpanic new (apikey);
    // ImageGenerationRequest req = {prompt: "backward view of a ballerina sitting on the floor acylic painting"};
    // ImageGenerationResponse res = check openai->/images/generations.post(req);

    // io:println(res.data[0].url);
}

@test:Config {}
function testModels() returns error? {
    
    // Client openai = checkpanic new (apikey);
    // Models models = check openai->/models;

    // io:println(models);
}

@test:AfterSuite
function afterSuiteFunc() {
    io:println("Completed the OpenAI API Client Test Suite");
}
