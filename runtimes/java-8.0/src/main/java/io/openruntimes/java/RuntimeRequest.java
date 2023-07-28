package io.openruntimes.java;

import java.util.Map;

public class RuntimeRequest {
    private final String method;
    private final String scheme;
    private final String host;
    private final int port;
    private final String path;
    private final Map<String, String> query;
    private final String queryString;
    private final Map<String, String> headers;
    private final Object body;
    private final String bodyRaw;
    private final String url;

    public RuntimeRequest(
            String method,
            String scheme,
            String host,
            int port,
            String path,
            Map<String, String> query,
            String queryString,
            Map<String, String> headers,
            Object body,
            String bodyRaw,
            String url
    ) {
        this.method = method;
        this.scheme = scheme;
        this.host = host;
        this.port = port;
        this.path = path;
        this.query = query;
        this.queryString = queryString;
        this.headers = headers;
        this.body = body;
        this.bodyRaw = bodyRaw;
        this.url = url;
    }

    public String getMethod() {
        return method;
    }

    public String getScheme() {
        return scheme;
    }

    public String getHost() {
        return host;
    }

    public int getPort() {
        return port;
    }

    public String getPath() {
        return path;
    }

    public Map<String, String> getQuery() {
        return query;
    }

    public String getQueryString() {
        return queryString;
    }

    public Map<String, String> getHeaders() {
        return headers;
    }

    public Object getBody() {
        return body;
    }

    public String getBodyRaw() {
        return bodyRaw;
    }

    public String getUrl() {
        return url;
    }
}


