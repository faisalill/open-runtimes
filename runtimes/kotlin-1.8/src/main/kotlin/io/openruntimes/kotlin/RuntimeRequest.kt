package io.openruntimes.kotlin

data class RuntimeRequest(
    val method: String,
    val scheme: String,
    val host: String,
    val port: Int,
    val path: String,
    val query: MutableMap<String, String>,
    val queryString: String,
    val headers: MutableMap<String, String>,
    val body: Any,
    val bodyRaw: String,
    val url: String,
)