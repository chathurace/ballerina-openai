import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(string apiKey, ConnectionConfig config =  {}, string serviceUrl = "https://api.openai.com/v1") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        httpClientConfig.auth = {token: apiKey};
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        
        return;
    }
    #
    # + return - OK 
    resource isolated function get models() returns Models|error {
        string resourcePath = string `/models`;
        Models response = check self.clientEp->get(resourcePath);
        return response;
    }
    #
    # + return - OK 
    resource isolated function get models/[string model]() returns Model|error {
        string resourcePath = string `/models/${getEncodedUri(model)}`;
        Model response = check self.clientEp->get(resourcePath);
        return response;
    }
    #
    # + return - OK 
    resource isolated function post completions(CompletionsRequest payload) returns CompletionsResponse|error {
        string resourcePath = string `/completions`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        CompletionsResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    #
    # + return - OK 
    resource isolated function post edits(EditsRequest payload) returns EditsResponse|error {
        string resourcePath = string `/edits`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        EditsResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    #
    # + return - OK 
    resource isolated function post images/generations(ImageGenerationRequest payload) returns ImageGenerationResponse|error {
        string resourcePath = string `/images/generations`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ImageGenerationResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
}
