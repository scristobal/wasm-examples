(module
  ;;
  ;; Score a dart throw based on its coordinates.
  ;;
  ;; @param {f32} x - The x coordinate of the dart.
  ;; @param {f32} y - The y coordinate of the dart.
  ;;
  ;; @returns {i32} - The score of the dart throw (10, 5, 1, or 0).
  ;;
  (func (export "score") (param $x f32) (param $y f32) (result i32)
    (local $dist f32)

    (f32.sqrt (f32.add
      (f32.mul (local.get $x) (local.get $x)) ;; square of $x
      (f32.mul (local.get $y) (local.get $y)) ;; square of $y
    ));; distance to center

    local.tee $dist

    (if (f32.gt (local.get $dist) (f32.const 10)) (then (return (i32.const 0)))) ;; outside target, 0 points
    (if (f32.gt (local.get $dist) (f32.const  5)) (then (return (i32.const 1)))) ;; outer circle, 1 point
    (if (f32.gt (local.get $dist) (f32.const  1)) (then (return (i32.const 5)))) ;; middle circle, 5 points
    (return (i32.const 10));; inner circle, 10 points
  )
)