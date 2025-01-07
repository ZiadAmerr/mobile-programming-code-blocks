# Notes from Lecture Slides

What is the difference between `AnimatedAlign` and `AnimatedPositioned`?
| Feature               | AnimatedAlign                               | AnimatedPositioned                                |
|-----------------------|---------------------------------------------|-------------------------------------------------|
| **Parent Widget**     | `Align`/`Stack`              | Inside a `Stack`                   |
| **Animation Type**    | Animates the alignment        | Animates position (top, left, right, bottom)|
| **Properties**        | `alignment` (alignment type)               | `top`, `left`, `right`, `bottom` (positioning)  |
| **Usage Context**     | Best for animating alignment changes        | Best for animating widget positions in a `Stack`|
| **Positioning Control** | Controls position via alignment within parent | Controls position using pixel offsets in `Stack` |

---
