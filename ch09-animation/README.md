# Notes from Lecture Slides

## Animation

What is the difference between `AnimatedAlign` and `AnimatedPositioned`?
| Feature               | AnimatedAlign                               | AnimatedPositioned                                |
|-----------------------|---------------------------------------------|-------------------------------------------------|
| **Parent Widget**     | `Align`/`Stack`              | Inside a `Stack`                   |
| **Animation Type**    | Animates the alignment        | Animates position (top, left, right, bottom)|
| **Properties**        | `alignment` (alignment type)               | `top`, `left`, `right`, `bottom` (positioning)  |
| **Usage Context**     | Best for animating alignment changes        | Best for animating widget positions in a `Stack`|
| **Positioning Control** | Controls position via alignment within parent | Controls position using pixel offsets in `Stack` |

---

### `AnimatedWidget`
Commonly used with Animation `Listenable` objects, but can be used with any `Listenable` including `ChangeNotifier` and `ValueNotifier`.

---

### `ImplicitlyAnimatedWidget`
- Abstract class that animate changes to properties
- Animate during rebuilds, not when first built
- Subclasses states must extend `ImplicitlyAnimatedWidgetState`

### Hero Widget Summary (Exam-Oriented)

- **Purpose**: Marks a child widget for hero animations.
- **Hero Animation**: Moves a shared visual element between routes during transitions.
- **Activation**: Wrap the widget in a `Hero` with a unique `tag`.
- **Trigger**: Hero widgets with matching tags on old and new routes trigger the animation.
- **Flight Behavior**: Hero widget "flies" in the `Navigator`'s overlay.
- **In-Flight Display**: Default is the destination route's Hero child.
- **Conditions**: 
  - Hero must exist on the first frame of the new route.
  - Each `tag` must be unique per route. 
- **Redirect**: Ongoing Hero animations are redirected if navigation occurs.

---

### Transition Animations
- `RotationTransition`: Animated rotation.
- `RelativePositionedTransition`: Transitions position based on value of a rectangle relative to a bounding box.
- `SlideTransition`: Animate position relative to its normal position.
- `AlignTransition`: Animate alignment. (`Align.alignment`)
- `ScaleTransition`: Animate scale.
- `SizeTransition`: Animate size.

---

## TTS


### `flutter_tts`
* Android doesn't support pause.
  - Use `onRangeStart()` to get index of start when pause.
  - Use index to create new text.
  - If used inside `setProgressHandler()`, you need to keep track of them.

### `speech_to_text`
- Device-specific
- Commands and short phrases, not continuous speech or always on listening.


# Notes from Lecture Notes
- Flutter has `tween-based` or `complex physics-based` animations
- Animation types:
  - `Tween` for interpolation
  - Implicit like `AnimatedContainer`
  - Explicit by `AnimationController`
  - Hero for smooth between screens

## Animations
- `Align`: align within parent $\rightarrow$ reposition widget
- `Builder`: rebuild part of widget tree, enables complex animation, minimizes rebuilds.
- `Container`: animate properties $\rightarrow$ size, color, padding
- `CrossFade`: Fade-in/out
- `DefaultTextStyle`: Animate font size/color/weight
- `List`: Insertion/Removal (slide, fade, scale in/out)
- `ListState`: has `insert/removeItem`
- `ModalBarrier`: Animate opacity of background $\rightarrow$ for dialogs
- `Opacity`: I mean.. what do I even say.. it is obviously opacity.
- `PhysicalModel`: Elevation, shadow, shape $\rightarrow$ visual depth/shadow change
- `Positioned`: Position inside stack (top-left-right-bottom, pixelwise)
- `Size`: width/height (expanding/collapsing)
- `Widget`: Base class for custom animations
- `ImplicitlyAnimatedWidget`: Simple animation with minimal setup, include `AnimatedContainer/Opacity/Align`
- `DecoratedBoxTransition`: Animate decoration of widget $\rightarrow$ commonly in hover or other visuals for interactive elems
- `Hero`: Transition between routes

## Transitions
- `Positioned`: Within `Stack` to animate position.
- `Rotation`: Uses `Animation<double>` to control rotation
- `Scale`: Zoom-in/out
- `Size`: I mean.. again?
- `Slide`: Position along an axis, uses `Animation<Offset>`.


