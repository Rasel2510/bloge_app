class PostResponse {
  final bool success;
  final String message;
  final List<Post> posts;
  final Pagination pagination;

  PostResponse({
    required this.success,
    required this.message,
    required this.posts,
    required this.pagination,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      posts: (json['data']?['posts'] as List? ?? [])
          .map((item) => Post.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['data']?['pagination'] ?? {}),
    );
  }
}

class Post {
  final int id;
  final String title;
  final String excerpt;
  final String? content;
  final String? featuredImage;
  final Author author;
  final List<String> categories;
  final int readTime;
  final String createdAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool isBookmarked;

  Post({
    required this.id,
    required this.title,
    required this.excerpt,
    this.content,
    this.featuredImage,
    required this.author,
    required this.categories,
    required this.readTime,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.isBookmarked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: (json['id'] is String) ? int.tryParse(json['id']) ?? 0 : json['id'] ?? 0,
      title: json['title'] ?? '',
      excerpt: json['excerpt'] ?? '',
      content: json['content'],
      featuredImage: json['featured_image'],
      author: Author.fromJson(json['author'] ?? {}),
      categories: (json['categories'] as List? ?? []).map((e) => e.toString()).toList(),
      readTime: (json['read_time'] is String) ? int.tryParse(json['read_time']) ?? 0 : json['read_time'] ?? 0,
      createdAt: json['created_at'] ?? '',
      likeCount: (json['like_count'] is String) ? int.tryParse(json['like_count']) ?? 0 : json['like_count'] ?? 0,
      commentCount: (json['comment_count'] is String) ? int.tryParse(json['comment_count']) ?? 0 : json['comment_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
      isBookmarked: json['is_bookmarked'] ?? false,
    );
  }
}

class Author {
  final int id;
  final String name;
  final String avatar;
  final String? bio;

  Author({
    required this.id,
    required this.name,
    required this.avatar,
    this.bio,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: (json['id'] is String) ? int.tryParse(json['id']) ?? 0 : json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Author',
      avatar: json['avatar'] ?? '',
      bio: json['bio'],
    );
  }
}

class Pagination {
  final int currentPage;
  final int perPage;
  final int totalPosts;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.perPage,
    required this.totalPosts,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: (json['current_page'] is String) ? int.tryParse(json['current_page']) ?? 1 : json['current_page'] ?? 1,
      perPage: (json['per_page'] is String) ? int.tryParse(json['per_page']) ?? 10 : json['per_page'] ?? 10,
      totalPosts: (json['total_posts'] is String) ? int.tryParse(json['total_posts']) ?? 0 : json['total_posts'] ?? 0,
      totalPages: (json['total_pages'] is String) ? int.tryParse(json['total_pages']) ?? 1 : json['total_pages'] ?? 1,
    );
  }
}