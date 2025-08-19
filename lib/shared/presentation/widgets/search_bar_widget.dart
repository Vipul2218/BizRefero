import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/route_names.dart';

class SearchBarWidget extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool enabled;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;

  const SearchBarWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.height,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;
  bool _isControllerInternal = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _isControllerInternal = true;
    }
  }

  @override
  void dispose() {
    if (_isControllerInternal) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 48.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        onTap: widget.onTap ?? _handleTap,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        textInputAction: TextInputAction.search,
        onSubmitted: _handleSubmit,
        decoration: InputDecoration(
          hintText: widget.hintText ?? 'Search businesses...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
          ),
          prefixIcon: widget.prefixIcon ?? Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.search_rounded,
              size: 20.w,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          suffixIcon: widget.suffixIcon,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  void _handleTap() {
    // Navigate to search page when tapped
    context.pushNamed(RouteNames.search);
  }

  void _handleSubmit(String query) {
    if (query.trim().isEmpty) return;
    
    // Navigate to search results with query
    context.pushNamed(
      RouteNames.search,
      queryParameters: {'q': query.trim()},
    );
  }
}

// Advanced search bar with filters
class AdvancedSearchBar extends StatefulWidget {
  final String? initialQuery;
  final String? initialCategory;
  final String? initialLocation;
  final ValueChanged<String>? onQueryChanged;
  final ValueChanged<String?>? onCategoryChanged;
  final ValueChanged<String?>? onLocationChanged;
  final VoidCallback? onSearch;
  final List<String>? categories;

  const AdvancedSearchBar({
    super.key,
    this.initialQuery,
    this.initialCategory,
    this.initialLocation,
    this.onQueryChanged,
    this.onCategoryChanged,
    this.onLocationChanged,
    this.onSearch,
    this.categories,
  });

  @override
  State<AdvancedSearchBar> createState() => _AdvancedSearchBarState();
}

class _AdvancedSearchBarState extends State<AdvancedSearchBar> {
  late TextEditingController _queryController;
  String? _selectedCategory;
  String? _selectedLocation;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController(text: widget.initialQuery);
    _selectedCategory = widget.initialCategory;
    _selectedLocation = widget.initialLocation;
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main search bar
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    onChanged: widget.onQueryChanged,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _performSearch(),
                    decoration: InputDecoration(
                      hintText: 'Search for businesses...',
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 20.w,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                IconButton(
                  onPressed: () => setState(() => _showFilters = !_showFilters),
                  icon: Icon(
                    _showFilters ? Icons.tune_rounded : Icons.tune_rounded,
                    color: _showFilters 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Filters section
          if (_showFilters) ...[
            Divider(height: 1.h),
            Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Category filter
                  Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 20.w,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          hint: const Text('All Categories'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                          ),
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('All Categories'),
                            ),
                            ...(widget.categories ?? []).map((category) =>
                                DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedCategory = value);
                            widget.onCategoryChanged?.call(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Location filter
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20.w,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter location...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            suffixIcon: Icon(
                              Icons.my_location_outlined,
                              size: 18.w,
                            ),
                          ),
                          onChanged: (value) {
                            _selectedLocation = value;
                            widget.onLocationChanged?.call(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Search button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _performSearch,
                      child: const Text('Search'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _performSearch() {
    final query = _queryController.text.trim();
    
    final queryParams = <String, String>{};
    if (query.isNotEmpty) queryParams['q'] = query;
    if (_selectedCategory != null) queryParams['category'] = _selectedCategory!;
    if (_selectedLocation != null && _selectedLocation!.isNotEmpty) {
      queryParams['location'] = _selectedLocation!;
    }
    
    // Navigate to search results
    context.pushNamed(
      RouteNames.search,
      queryParameters: queryParams,
    );
    
    widget.onSearch?.call();
  }
}

// Compact search bar for headers
class CompactSearchBar extends StatelessWidget {
  final String? hintText;
  final VoidCallback? onTap;
  final bool showMicIcon;
  final VoidCallback? onMicPressed;

  const CompactSearchBar({
    super.key,
    this.hintText,
    this.onTap,
    this.showMicIcon = false,
    this.onMicPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 18.w,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                hintText ?? 'Search...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ),
            if (showMicIcon) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onMicPressed,
                child: Icon(
                  Icons.mic_outlined,
                  size: 18.w,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}