---
title: Swagger / OpenAPI Specification (OAS)
---
# [Swagger](swagger.md) / OpenAPI Specification (OAS)

## Authentication

  - [Authentication \| Swagger](https://swagger.io/docs/specification/authentication/) #ril

      - OpenAPI uses the term SECURITY SCHEME for authentication AND authorization schemes.

        為什麼這裡會同時談及 authentication 與 authorization ??

        OpenAPI 3.0 lets you describe APIs protected using the following security schemes:

          - HTTP authentication schemes (they use the `Authorization` header):

              - Basic
              - Bearer
              - other HTTP schemes as defined by RFC 7235 and HTTP Authentication Scheme Registry

          - API keys in headers, query string or cookies

              - Cookie authentication

          - OAuth 2
          - OpenID Connect Discovery

      - Follow the links above for the guides on specific SECURITY TYPES, or continue reading to learn how to DESCRIBE SECURITY IN GENERAL.

  - [Authentication - OpenAPI 2 \| Swagger](https://swagger.io/docs/specification/2-0/authentication/) #ril

      - Swagger 2.0 lets you DEFINE the following AUTHENTICATION TYPES for an API:

          - Basic authentication
          - API key (as a header or a query string parameter)
          - OAuth 2 common flows (authorization code, implicit, resource owner password credentials, client credentials)

        Follow the links above for examples specific to these authentication types, or continue reading to learn how to describe authentication in general.

      - Authentication is described by using the `securityDefinitions` and `security` keywords. You use `securityDefinitions` to define all authentication types supported by the API, then use `security` to APPLY specific authentication types to the WHOLE API or INDIVIDUAL operations.

      - The `securityDefinitions` section is used to define all SECURITY SCHEMES (authentication types) supported by the API. It is a name->definition map that maps ARBITRARY NAMES to the security scheme definitions.

        Here, the API supports three security schemes named `BasicAuth`, `ApiKeyAuth` and `OAuth2`, and these names will be used to refer to these security schemes from elsewhere:

            securityDefinitions:
              BasicAuth:
                type: basic
              ApiKeyAuth:
                type: apiKey
                in: header
                name: X-API-Key
              OAuth2:
                type: oauth2
                flow: accessCode
                authorizationUrl: https://example.com/oauth/authorize
                tokenUrl: https://example.com/oauth/token
                scopes:
                  read: Grants read access
                  write: Grants write access
                  admin: Grants read and write access to administrative information

        注意 `BasicAuth`、`ApiKeyAuth`、`OAuth2` 都是自訂的名稱，透過 `type` (`basic`、`apiKey` 或 `oauth2`) 跟 OpenAPI 的 security scheme 連結起來。

      - Each security scheme can be of `type`:

          - `basic` for Basic authentication
          - `apiKey` for an API key
          - `oauth2` for OAuth 2

        Other required properties depend on the security type. For details, check the Swagger Specification or our examples for Basic auth and API keys.

      - After you have defined the security schemes in `securityDefinitions`, you can apply them to the whole API or individual operations by adding the `security` section on the ROOT LEVEL or OPERATION LEVEL, respectively.

        When used on the root level, security applies the specified security schemes globally to all API operations, unless overridden on the operation level.

        In the following example, the API calls can be authenticated using either an API key or OAuth 2. The `ApiKeyAuth` and `OAuth2` names refer to the security schemes previously defined in `securityDefinitions`.

            security:
              - ApiKeyAuth: []
              - OAuth2: [read, write]

      - Global `security` can be overridden in individual operations to use a different authentication type, different OAuth 2 scopes, or NO AUTHENTICATION AT ALL:

             paths:
              /billing_info:
                get:
                  summary: Gets the account billing info
                  security:
                    - OAuth2: [admin]   # Use OAuth with a different scope
                  responses:
                    200:
                      description: OK
                    401:
                      description: Not authenticated
                    403:
                      description: Access token does not have the required scope
              /ping:
                get:
                  summary: Checks if the server is running
                  security: []   # No security
                  responses:
                    200:
                      description: Server is up and running
                    default:
                      description: Something is wrong

  - [API Keys - OpenAPI 2 \| Swagger](https://swagger.io/docs/specification/2-0/authentication/api-keys/) #ril

## 參考資料 {: #reference }

文件：

  - [OpenAPI Specification 3](https://swagger.io/docs/specification/basic-structure/)
  - [OpenAPI Specification 2 (Swagger)](https://swagger.io/docs/specification/2-0/basic-structure/)
