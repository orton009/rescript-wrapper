module Operators = {
  type fn<'x, 'y> = 'x => 'y
  @module("./operators.js")
  external compose_left: ('a => 'b, 'b => 'c) => fn<'a, 'c> = "compose_left"
  @module("./operators.js")
  external compose_left2: (('a, 'b) => 'c, 'c => 'd) => fn<'a, fn<'b, 'd>> = "compose_left"
}

module Array = {
  include Js.Array2
  %%private(let index_to_optional = i => i === -1 ? None : Some(i))
  %%private(let from_ref = (a: ref<array<'a>>) => a.contents)

  // let test = (a: string, b: int) => 0
  // let x = "h"->test(1)
  // let y = 1 |> test("h")

  //exported array utils
  let copyWithin = (a, ~to) => a->from_ref->Js.Array2.copyWithin(~to_=to)
  let copyWithinFrom = (a, ~to, ~from) => a->from_ref->Js.Array2.copyWithinFrom(~to_=to, ~from)
  let copyWithinFromRange = (a, ~to, ~start, ~end) =>
    a->from_ref->Js.Array2.copyWithinFromRange(~to_=to, ~start, ~end_=end)

  let fillInPlace = (a, b) => a->Js.Array2.fillInPlace(b)
  let fillFromInPlace = (a, b, ~from) => a->Js.Array2.fillFromInPlace(b, ~from)
  let fillRangeInPlace = (a, ~start, ~end) => a->Js.Array2.fillRangeInPlace(~start, ~end_=end)

  let findIndex = (a, b) => b->findIndex(a)->index_to_optional
  let findIndexi = (a, b) => b->findIndexi(a)->index_to_optional

  let indexOf = (a, b) => b->indexOf(a)->index_to_optional

  let pop = x => x->from_ref->pop
  let push = (a, b) => a->from_ref->Js.Array2.push(b)
  let pushMany = (a, b) => a->from_ref->Js.Array2.pushMany(b)

  let lastIndexOf = (a, b) => a->Js.Array2.lastIndexOf(b)->index_to_optional
  let lastIndexOfFrom = (a, b, ~from) => a->Js.Array2.lastIndexOfFrom(b, ~from)->index_to_optional

  let removeCountInPlace = (a, ~pos, ~count) =>
    a->from_ref->Js.Array2.removeCountInPlace(~pos, ~count)
  let removeFromInPlace = (a, ~pos) => a->from_ref->Js.Array2.removeFromInPlace(~pos)

  let reverseInPlace = a => a->from_ref->Js.Array2.reverseInPlace
  let shift = a => a->from_ref->Js.Array2.shift

  let sortInPlace = a => a->from_ref->Js.Array2.sortInPlace
  let sortInPlaceWith = (a, fn) => a->from_ref->Js.Array2.sortInPlaceWith(fn)

  let spliceInPlace = (a, ~pos, ~remove, ~add) =>
    a->from_ref->Js.Array2.spliceInPlace(~pos, ~remove, ~add)

  let unsafe_get = ()
  let unsafe_set = ()

  let unshift = (a, b) => a->from_ref->Js.Array2.unshift(b)
  let unshiftMany = (a, b) => a->from_ref->Js.Array2.unshiftMany(b)

  //Utils from Belt library
  let keep = Belt.Array.keep
  let keepU = Belt.Array.keepU

  let keepWithIndex = Belt.Array.keepWithIndex
  let keepWithIndexU = Belt.Array.keepWithIndexU

  let keepMap = Belt.Array.keepMap
  let keepMapU = Belt.Array.keepMapU

  let zip = Belt.Array.zip
  let zipBy = Belt.Array.zipBy
  let zipByU = Belt.Array.zipByU

  let unzip = Belt.Array.unzip
}
