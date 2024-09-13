# Authorization

The jember.ai APIs use OAuth2 for authorization. The OAuth2 protocol is a standard protocol that allows external applications
to request access to resources. 

The OAuth2 flow used by jember.ai is the client credentials flow. This flow is used when the application is acting on its 
own behalf. To obtain an access token, the client sends a POST request to the token endpoint with the client ID and client
secret in the Authorization header. The client ID and client secret are base64 encoded.

The authorization server will return a JWT token in the response body. The token will contain the following fields:
  * access_token: The JWT token
  * token_type: The type of token
  * expires_in: The time in seconds until the token expires
  * scope: The scope of the token

To use the JWT token, the client must include the token in the Authorization header of the request. The token should be
prefixed with the token type. For example, `Bearer <token>`.

## Obtaining a Token

The 