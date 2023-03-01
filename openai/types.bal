import ballerina/http;
import ballerina/constraint;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

public type EditsRequest record {
    # ID of the model to use. You can use the text-davinci-edit-001 or code-davinci-edit-001 model with this endpoint.
    string model;
    # The input text to use as a starting point for the edit.
    string input = "";
    # The instruction that tells the model how to edit the prompt.
    string instruction;
    # How many edits to generate for the input and instruction.
    int n = 1;
    # What sampling temperature to use, between 0 and 2.
    decimal temperature = 1;
    # An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
    decimal top_p = 1;
};

public type CompletionsResponse_usage record {
    int prompt_tokens;
    int completion_tokens;
    int total_tokens;
};

public type ImageGenerationRequest record {
    # A text description of the desired image(s). The maximum length is 1000 characters.
    @constraint:String {maxLength: 1000, minLength: 1}
    string prompt;
    # The number of images to generate. Must be between 1 and 10.
    @constraint:Int {minValue: 1, maxValue: 10}
    int n = 1;
    # The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    string size = "1024x1024";
    # The format in which the generated images are returned. Must be one of url or b64_json.
    string response_format = "url";
    # A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    string user?;
};

public type CompletionsResponse record {
    string id;
    string 'object;
    int created;
    string model;
    CompletionsResponse_choices[] choices;
    CompletionsResponse_usage usage;
};

public type ImageGenerationResponse record {
    # Unix timestamp of when the image request was created
    int created;
    # An array of objects containing URLs to the generated images
    @constraint:Array {minLength: 1}
    ImageGenerationResponse_data[] data;
};

public type ImageGenerationResponse_data record {
    # The URL of a generated image
    string url?;
};

public type EditsResponse record {
    # Indicates that this is an edit object.
    string 'object?;
    # Unix timestamp indicating when the edit was created.
    int created?;
    # An array of edited text choices.
    EditsResponse_choices[] choices?;
    # Object containing usage statistics.
    EditsResponse_usage usage?;
};

public type CompletionsRequest record {
    string model;
    string prompt?;
    string suffix?;
    int max_tokens?;
    decimal temperature?;
    decimal top_p?;
    int n?;
    boolean 'stream?;
    int logprobs?;
    boolean echo?;
    string stop?;
    decimal presence_penalty?;
    decimal frequency_penalty?;
    int best_of?;
    string user?;
};

public type Model record {
    string id?;
    string 'object?;
    string owned_by?;
};

# Object containing usage statistics.
public type EditsResponse_usage record {
    # The number of tokens in the prompt.
    int prompt_tokens?;
    # The number of tokens in the completion.
    int completion_tokens?;
    # The total number of tokens used.
    int total_tokens?;
};

public type Models record {
    Model[] data?;
};

public type CompletionsResponse_choices record {
    string text;
    int index;
    string? logprobs;
    string finish_reason;
};

public type EditsResponse_choices record {
    # The edited text.
    string text?;
    # The index of the choice.
    int index?;
};
