import 'package:flutter/services.dart';
import 'package:food_app_task/imports.dart';

class AnimatedSwipeSlider extends StatefulWidget {
  final String text;
  final String actionText;
  final Color primaryColor;
  final Color backgroundColor;
  final VoidCallback onSwipeComplete;
  final IconData icon;
  final double height;
  final double threshold;
  final bool enableFloatingAnimation;
  final bool enablePulseAnimation;
  final Duration floatingDuration;
  final Duration pulseDuration;
  final double floatingRange;
  final double pulseScale;

  const AnimatedSwipeSlider({
    super.key,
    required this.text,
    required this.actionText,
    required this.primaryColor,
    required this.onSwipeComplete,
    this.backgroundColor = Colors.transparent,
    this.icon = Icons.arrow_right,
    this.height = 60,
    this.threshold = 0.7,
    this.enableFloatingAnimation = true,
    this.enablePulseAnimation = true,
    this.floatingDuration = const Duration(milliseconds: 2000),
    this.pulseDuration = const Duration(milliseconds: 1500),
    this.floatingRange = 2.0,
    this.pulseScale = 1.05,
  });

  @override
  State<AnimatedSwipeSlider> createState() => _AnimatedSwipeSliderState();
}

class _AnimatedSwipeSliderState extends State<AnimatedSwipeSlider> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  double _dragProgress = 0.0;
  bool _isDragging = false;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    // Floating animation controller
    _floatingController = AnimationController(duration: widget.floatingDuration, vsync: this);

    // Pulse animation controller
    _pulseController = AnimationController(duration: widget.pulseDuration, vsync: this);

    // Floating animation with configurable range
    _floatingAnimation = Tween<double>(
      begin: -widget.floatingRange,
      end: widget.floatingRange,
    ).animate(CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut));

    // Pulse animation with configurable scale
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pulseScale,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    // Start animations if enabled
    _startAnimations();
  }

  void _startAnimations() {
    if (!_isCompleted) {
      if (widget.enableFloatingAnimation) {
        _floatingController.repeat(reverse: true);
      }
      if (widget.enablePulseAnimation) {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  void _stopAnimations() {
    _floatingController.stop();
    _pulseController.stop();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleSwipeComplete() {
    if (_isCompleted) return;

    // Haptic feedback for successful swipe
    HapticFeedback.mediumImpact();

    setState(() {
      _isCompleted = true;
    });

    _stopAnimations();

    _animationController.forward().then((_) {
      widget.onSwipeComplete();

      // Reset after completion
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _dragProgress = 0.0;
            _isDragging = false;
            _isCompleted = false;
          });
          _animationController.reset();
          _startAnimations();
        }
      });
    });
  }

  void _handlePanStart(DragStartDetails details) {
    if (_isCompleted) return;

    // Light haptic feedback when starting to drag
    HapticFeedback.lightImpact();

    setState(() {
      _isDragging = true;
      _dragProgress = 0.0;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_isCompleted) return;

    setState(() {
      _dragProgress += details.delta.dx / (MediaQuery.of(context).size.width * 0.7);
      _dragProgress = _dragProgress.clamp(0.0, 1.0);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_isCompleted) return;

    if (_dragProgress > widget.threshold) {
      _handleSwipeComplete();
    } else {
      // Light feedback when swipe is not completed
      HapticFeedback.lightImpact();
      setState(() {
        _dragProgress = 0.0;
        _isDragging = false;
      });

      // Ensure animations continue
      if (!_floatingController.isAnimating && widget.enableFloatingAnimation) {
        _floatingController.repeat(reverse: true);
      }
      if (!_pulseController.isAnimating && widget.enablePulseAnimation) {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return GestureDetector(
          onPanStart: _handlePanStart,
          onPanUpdate: _handlePanUpdate,
          onPanEnd: _handlePanEnd,
          child: Container(
            height: widget.height.sp,
            decoration: BoxDecoration(
              color: widget.backgroundColor != Colors.transparent ? widget.backgroundColor : widget.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular((widget.height / 2).sp),
              border: Border.all(
                color: widget.primaryColor.withValues(
                  alpha: 0.3 + (widget.enablePulseAnimation ? (_pulseAnimation.value - 1.0) * 0.2 : 0) + (_isDragging ? 0.2 : 0),
                ),
                width: 1.sp,
              ),
              boxShadow: _isDragging || !widget.enablePulseAnimation
                  ? []
                  : [
                      BoxShadow(
                        color: widget.primaryColor.withValues(alpha: 0.1 + (_pulseAnimation.value - 1.0) * 0.1),
                        blurRadius: 8.sp + (_pulseAnimation.value - 1.0) * 4.sp,
                        spreadRadius: (_pulseAnimation.value - 1.0) * 2.sp,
                      ),
                    ],
            ),
            child: Stack(
              children: [
                // Background progress
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: _isDragging ? Duration.zero : const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((widget.height / 2).sp),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [_dragProgress, _dragProgress],
                        colors: [widget.primaryColor.withValues(alpha: 0.2), Colors.transparent],
                      ),
                    ),
                  ),
                ),

                // Slide indicator with floating and pulse effects
                AnimatedBuilder(
                  animation: Listenable.merge([_floatingController, _pulseController]),
                  builder: (context, child) {
                    final indicatorSize = (widget.height - 16).sp;
                    return Positioned(
                      left: 8.sp + (_dragProgress * (MediaQuery.of(context).size.width - (indicatorSize + 32))),
                      top: 8.sp + (widget.enableFloatingAnimation ? _floatingAnimation.value : 0),
                      child: Transform.scale(
                        scale: widget.enablePulseAnimation ? _pulseAnimation.value : 1.0,
                        child: Container(
                          width: indicatorSize,
                          height: indicatorSize,
                          decoration: BoxDecoration(
                            color: widget.primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.primaryColor.withValues(alpha: 0.4),
                                blurRadius: widget.enableFloatingAnimation
                                    ? 8.sp + (_floatingAnimation.value.abs() * 2) + (_isDragging ? 4.sp : 0)
                                    : _isDragging
                                    ? 12.sp
                                    : 8.sp,
                                offset: Offset(
                                  0,
                                  widget.enableFloatingAnimation
                                      ? 2.sp + _floatingAnimation.value + (_isDragging ? 2.sp : 0)
                                      : _isDragging
                                      ? 4.sp
                                      : 2.sp,
                                ),
                              ),
                            ],
                          ),
                          child: Icon(widget.icon, color: Colors.white, size: (indicatorSize * 0.45).sp),
                        ),
                      ),
                    );
                  },
                ),

                // Text content
                Center(
                  child: Text(
                    "${widget.text} ${widget.actionText}",
                    style: bodyMedium(context).copyWith(color: widget.primaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
