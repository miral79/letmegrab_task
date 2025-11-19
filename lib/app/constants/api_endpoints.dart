class ApiEndpoints {
  // Base URL for your API
  // static const String baseUrl = "https://admin.buttonshift.com/api/v1/";
  static const String baseUrl = "https://dummyjson.com";

  // Authentication Endpoints
  static const String getPosts = "$baseUrl/products";

  // Example of a custom endpoint for fetching comments
  static String getComments(String postId) => '$baseUrl/posts/$postId/comments';
}
