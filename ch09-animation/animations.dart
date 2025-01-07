// AnimatedAlign
  AnimatedAlign(
    alignment: selected ? Alignment.topRight : Alignment.bottomLeft, // If selected, align to top right, otherwise align to bottom left
    duration: widget.duration,  // Animation duration: Duration(seconds: 1)
    curve: widget.curve, // Animation curve: Curves.fastOutSlowIn
    child: const FlutterLogo(),  // Child widget(to be animated) FlutterLogo
  )

// AnimatedBuilder
  with TickerProviderStateMixin {  // Mixin for animation controller
    // Define a controller
    late final AnimationController _controller = AnimationController(
      duration: widget.duration,
      vsync: this,  // Vsync with this(which is TickerProviderStateMixin)
    )..repeat();

    // ... Some irrelevant stuff here!

    // Return AnimatedBuilder
    return AnimatedBuilder(
      animation: _controller,  // Animation controller
      child: widget.elemToAnimate, // Child widget to be animated
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }

// AnimatedContainer
  child: Center(
    child: AnimatedContainer(
      // Constant
      child: const FlutterLogo(size: 50),

      // Animation-based properties
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,

      // Updates
      color: selected ? Colors.red : Colors.blue,
    ),
  ),

// AnimatedCrossFade
  child: AnimatedCrossFade(
    duration: const Duration(seconds: 3),  // Animation duration
    firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),  // First child
    secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),  // Second child
    crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,  // Crossfade state
  )

// AnimatedDefaultTextStyle
  child: AnimatedDefaultTextStyle(
    duration: const Duration(seconds: 2),  // Animation duration
    style: selected ? TextStyle(color: Colors.red) : TextStyle(color: Colors.blue),  // Style to animate
    child: const Text('Yoo!'),  // Child widget
  )

// AnimatedListState -- THIS NEEDS FURTHER EXPLANATION
  // By default, AnimatedList will automatically pad the limits of the list's scrollable to
  // avoid partial obstructions indicated by MediaQuery's padding.
  // To avoid this behavior, override with a **zero padding** property.
  AnimatedList(
    key: _listKey,  // Key for the list
    initialItemCount: _list.length,  // Initial item count
    itemBuilder: (context, index, animation) {  // Item builder
      return _buildItem(context, index, animation);
    },
  )

// AnimatedListState
  AnimatedListState _listKey.currentState!.insert(0, _list.length);

// AnimatedModalBarrier
  // when a dialog is on the screen, the page below the dialog is usually
  // darkened by the modal barrier, this one is the animated version of it
  child: AnimatedModalBarrier(
    color: selected ? Colors.red : Colors.blue,  // Barrier color
    dismissible: true,  // Dismissable
    semanticsLabel: 'Yoo!',  // Semantics label
  )

// AnimatedOpacity
  // Implicitly an animated widget
  AnimatedOpacity(
    opacity: selected ? 1.0 : 0.0,  // Opacity value

    duration: const Duration(seconds: 2),  // Animation duration
    child: const FlutterLogo(size: 50),  // Child widget
  )

// AnimatedPhysicalModel
  // Animated version of PhysicalModel
  // Color animated if animateColor isset
  // Shape is not animated
  AnimatedPhysicalModel(
    duration: const Duration(seconds: 2),  // Animation duration
    curve: Curves.fastOutSlowIn,  // Animation curve

    elevation: selected ? 16.0 : 0.0,  // Elevation value
    shape: BoxShape.rectangle,  // Shape
    shadowColor: Colors.black,  // Shadow color
    color: Colors.red,  // Color
    child: const FlutterLogo(size: 50),  // Child widget
  )

// AnimatedPositioned
  // Animated version of Positioned
  AnimatedPositioned(
    duration: const Duration(seconds: 2),  // Animation duration
    curve: Curves.fastOutSlowIn,  // Animation curve

    left: selected ? 100.0 : 0.0,  // Left value
    top: selected ? 100.0 : 0.0,  // Top value
    child: const FlutterLogo(size: 50),  // Child widget
  )

// AnimatedSize
