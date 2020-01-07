# URI (Uniform Resource Identifier)

  - [Uniform Resource Identifier \- Wikipedia](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier) #ril

      - A Uniform Resource Identifier (URI) is a string of characters that UNAMBIGUOUSLY identifies a particular resource. To guarantee UNIFORMITY, all URIs follow a predefined set of syntax rules, but also maintain extensibility through a separately defined hierarchical naming scheme (e.g. `http://`).

        下面 "As such, the URI syntax is a federated ..." 解釋了這一點，因為 URI generic syntax 只定義了 naming 的大框架，細節則由各 scheme 定義。

        URL 是 URI 的一種，但 URI 只是個 identifier，重點是 "識別" 而非 URL 的 "定位"，所以 URI 不一定能直接透過網路取得什麼資源；例如：

          - JWT 的 `iss` claim 型態是 `StringOrURI`，常見的用法像是 `"iss": "https://authorization-server. example.com/"`。
          - XML namespace 只是用 URI 來避免衝突，例如 `<html xmlns="http://www.w3.org/1999/xhtml">`

      - Such identification enables interaction with REPRESENTATIONS OF THE RESOURCE over a network, typically the World Wide Web, using specific protocols.

        SCHEMES specifying a CONCRETE SYNTAX and associated protocols define each URI. The most common form of URI is the Uniform Resource Locator (URL), frequently referred to informally as a web address.

        Scheme 不就是 protocol ??

        More rarely seen in usage is the Uniform Resource Name (URN), which was designed to complement URLs by providing a mechanism for the identification of resources IN PARTICULAR NAMESPACES. ??

    Generic syntax

      - Each URI begins with a SCHEME NAME that refers to a SPECIFICATION for assigning identifiers WITHIN THAT SCHEME. As such, the URI syntax is a FEDERATED and extensible naming system wherein each scheme's specification may further restrict the syntax and semantics of identifiers using that scheme.

        The URI generic syntax is a SUPERSET of the syntax of all URI schemes. It was first defined in Request for Comments (RFC) 2396, published in August 1998, and finalized in RFC 3986, published in January 2005.

      - The URI generic syntax consists of a hierarchical sequence of five components:

            URI = scheme:[//authority]path[?query][#fragment]

        where the `authority` component divides into three subcomponents:

            authority = [userinfo@]host[:port]

        This is represented in a syntax diagram as:

        ![](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/URI_syntax_diagram.svg/2136px-URI_syntax_diagram.svg.png)

    Relation to XML namespaces

      - In XML, a namespace is an ABSTRACT DOMAIN to which a collection of element and attribute names can be assigned.

        The namespace name is a character string which must adhere to the generic URI syntax. However, the name is generally not considered to be a URI, because the URI specification bases the decision not only on lexical components, but also on their intended use. ??

        A namespace name does not necessarily imply any of the semantics of URI schemes; for example, a namespace name beginning with `http:` may HAVE NO CONNOTATION TO THE USE OF THE HTTP.

      - Originally, the namespace name could match the syntax of any non-empty URI reference, but the use of relative URI references was deprecated by the W3C. A separate W3C specification for namespaces in XML 1.1 permits internationalized resource identifier (IRI) references to serve as the basis for namespace names in addition to URI references.

## 參考資料 {: #reference }

手冊：

  - [RFC 3986 - Uniform Resource Identifier (URI): Generic Syntax](https://tools.ietf.org/html/rfc3986)
