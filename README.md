## Module Overview

OpenAI client for Ballerina

## Compatibility

|                                   | Version               |
|:---------------------------------:|:---------------------:|
| Ballerina Language                | 2201.2.3              |
| Java Development Kit (JDK)        | 11                    |

## Example

Below example shows the usage of OpenAI client for completions:

```ballerina

import ballerina/io;
import chathurace/openai;

configurable string apikey = ?;

public function main() returns error? {

    openai:Client c = check new (apikey);
    openai:CompletionsRequest req = {
        model: "text-davinci-003",
        prompt: "Explain quantum mechanics to a 5 year old."
    };

    openai:CompletionsResponse resp = check c->/completions.post(req);
    io:println(resp.choices[0].text);
}

```

