class HttpFormatterOptions {
  // Request Options
  final bool includeRequest;
  final bool includeRequestHeaders;
  final bool includeRequestQueryParams;
  final bool includeRequestBody;

  // Response Options
  final bool includeResponse;
  final bool includeResponseHeaders;
  final bool includeResponseBody;

  const HttpFormatterOptions({
    this.includeRequest = true,
    this.includeRequestHeaders = true,
    this.includeRequestQueryParams = true,
    this.includeRequestBody = true,
    this.includeResponse = true,
    this.includeResponseBody = true,
    this.includeResponseHeaders = true,
  });
}
