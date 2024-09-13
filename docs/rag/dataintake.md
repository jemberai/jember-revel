# Data Intake
Use the Data Intake API to load data into Jmeber AI. The Data Intake API follows the CloudEvents specification.
By using this specification, you can send data to Jember AI in nearly any format. Jember AI supports most popular 
mime types, including JSON, XML, and CSV.

The uploaded data is encryupted and perstited to a Postgres database. 

# Embedding Process
Once data is uploaded, it is processed asycronously into embeddings which are persisted to the vector store. Only the embeddings are saved 
in the vector store. Embeddings can not be reversed to the original value. 

The embedding process does involve breaking the original document into chunks. The chunks are sent to the configured LLM to 
obtain the embedding. The embedding is stored to the vector store, which returns an Id for the chunk value. The Id and chunk
value are persisted to the Postgres database. (The chunk value is encryupted at rest)

## What are CloudEvents?
CloudEvents is a specification for describing event data in a common way. CloudEvents seeks to dramatically simplify 
event declaration and delivery across services, platforms, and beyond!

The CloudEvents working group has received a large amount of industry interest, ranging from major cloud providers to 
popular SaaS companies. The specification is now under the Cloud Native Computing Foundation.

Through the use of CloudEvents, the Data Intake API can accept events from a variety of sources. The API 
will accept a CloudEvent payload in either JSON or binary format. The CloudEvent payload must contain the
following attributes:

  * specversion: The version of the CloudEvents specification which the event uses.
  * type: Describes the type of event related to the originating occurrence.
  * source: Identifies the context in which an event happened.
  * id: Identifies the event.
  * time: Timestamp of when the occurrence happened.
  * datacontenttype: Content type of the data value. This is a MIME type.
  * data: The event payload.

The CloudEvent payload can be text, JSON, XML, CSV, PDF, or any other format. The payload can also be 
binary data supporting files such as images and audio.

### Example JSON Payload
Below is an example of a CloudEvent JSON payload. In this example you can see the CloudEvent standard attributes, 
as well as some custom attributes that are specific to the `com.example.someevent` event type. The data element
can be any JSON object.

  ```json
  {
    "specversion" : "1.0", 
    "type" : "com.example.someevent",
    "source" : "/mycontext",
    "subject": null,
    "id" : "C234-1234-1234",
    "time" : "2018-04-05T17:31:00Z",
    "comexampleextension1" : "value",
    "comexampleothervalue" : 5,
    "datacontenttype" : "application/json",
    "data" : {
        "appinfoA" : "abc",
        "appinfoB" : 123,
        "appinfoC" : true
    }
  }
  ```
### Example Payload Specifying the CloudEvent Attributes in Header Values

    ```
    ce-specversion: 1.0
    ce-type: com.example.someevent
    ce-source: /mycontext
    ce-id: C234-1234-1234
    ce-time: 2018-04-05T17:31:00Z
    ce-comexampleextension1: value
    ce-comexampleothervalue: 5
    content-type: application/json

    {
      "appinfoA" : "abc",
      "appinfoB" : 123,
      "appinfoC" : true
    }
    ```
### Example with Binary Payload
    ```json
    {
    "specversion" : "1.0",
    "type" : "com.example.someevent",
    "source" : "/mycontext",
    "id" : "A234-1234-1234",
    "time" : "2018-04-05T17:31:00Z",
    "comexampleextension1" : "value",
    "comexampleothervalue" : 5,
    "datacontenttype" : "application/vnd.apache.thrift.binary",
    "data_base64" : "... base64 encoded string ..."
    } 
  ```