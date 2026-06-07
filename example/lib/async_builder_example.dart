import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

// --- Data Model ---
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// --- API Service using GetConnect ---
class PostService extends GetConnect {
  Future<List<Post>> fetchPosts({bool fail = false}) async {
    // Simulate error if requested
    if (fail) {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception("Manual Error Triggered!");
    }

    final response = await get('https://jsonplaceholder.typicode.com/posts');

    if (response.status.hasError) {
      throw Exception(response.statusText);
    }

    final List<dynamic> data = response.body;
    return data.map((json) => Post.fromJson(json)).toList();
  }

  Stream<int> countStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
}

// --- Controller with StateMixin ---
class PostController extends GetXController with StateMixin<List<Post>> {
  final PostService _service = PostService();

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  void loadPosts({bool fail = false, bool empty = false}) {
    // Using the new 'futurize' method for automatic state management
    futurize(
      () async {
        if (empty) return [];
        return _service.fetchPosts(fail: fail);
      },
      errorMessage: "Failed to load posts from JSONPlaceholder",
      useEmpty: true,
    );
  }
}

// --- Main Example Screen ---
class AsyncBuilderExample extends StatelessWidget {
  const AsyncBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject dependencies
    final controller = Get.put(PostController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Async & State Management"),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadPosts(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("1. GetStateView (StateMixin)"),
            _buildStateViewDemo(),
            const SizedBox(height: 32),
            _sectionTitle("2. GetAsyncBuilder.future"),
            _buildFutureBuilderDemo(),
            const SizedBox(height: 32),
            _sectionTitle("3. GetAsyncBuilder.stream"),
            _buildStreamBuilderDemo(),
            const SizedBox(height: 32),
            _buildControlButtons(controller),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  // Demo 1: GetStateView
  // Automatically handles loading, error, empty, and success states from the controller
  Widget _buildStateViewDemo() {
    return Container(
      height: 250,
      decoration: _cardDecoration(),
      child: GetStateView<PostController, List<Post>>(
        onSuccess: (context, posts) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: posts?.length ?? 0,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(child: Text("${posts![index].id}")),
              title: Text(
                posts[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                posts[index].body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
        // Optional: Custom loading
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  // Demo 2: GetAsyncBuilder.future
  // Perfect for one-off async operations without needing a full controller
  Widget _buildFutureBuilderDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: GetAsyncBuilder<List<Post>>.future(
        future: () => PostService().fetchPosts(),
        onSuccess: (context, posts) => Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
                child:
                    Text("Directly fetched ${posts.length} posts via Future.")),
          ],
        ),
        // keepDataOnReload: true, // Default
      ),
    );
  }

  // Demo 3: GetAsyncBuilder.stream
  // Effortlessly handle streams with built-in status management
  Widget _buildStreamBuilderDemo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: GetAsyncBuilder<int>.stream(
        stream: () => PostService().countStream(),
        onSuccess: (context, count) => Center(
          child: Column(
            children: [
              const Text("Stream counter value:"),
              Text(
                "$count",
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButtons(PostController controller) {
    return Column(
      children: [
        const Text("Test Controller States:",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.loadPosts(fail: true),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[50]),
                child: const Text("Trigger Error",
                    style: TextStyle(color: Colors.red)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.loadPosts(empty: true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[50]),
                child: const Text("Trigger Empty",
                    style: TextStyle(color: Colors.orange)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.loadPosts(),
                child: const Text("Success"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[200]!),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    );
  }
}
